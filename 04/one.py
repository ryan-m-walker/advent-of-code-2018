import re
from dateutil import parser
import operator


active_guard = None
guards = {}

WAKES_UP = 'wakes up'
FALLS_ASLEEP = 'falls asleep'


class Guard:
    def __init__(self, guard_id):
        self.guard_id = guard_id
        self.time_went_to_sleep = None
        self.total_minutes_slept = 0
        self.time_table = [0] * 60

    def __repr__(self):
        return self.guard_id

    def go_to_sleep(self, time):
        self.time_went_to_sleep = time

    def wake_up(self, time):
        delta = time - self.time_went_to_sleep

        start_minute = int(self.time_went_to_sleep.minute)
        minutes_slept = int(delta.total_seconds() / 60)

        for minute in range(start_minute, start_minute + minutes_slept):
            self.time_table[minute] += 1
            self.total_minutes_slept += 1


def process_data(input_data):
    global active_guard, guards

    for item in input_data:
        raw_date, action = item.split('] ')
        date = raw_date.replace('[', '')
        dt = parser.parse(date)
        if action == FALLS_ASLEEP:
            guards[active_guard].go_to_sleep(dt)
        elif action == WAKES_UP:
            guards[active_guard].wake_up(dt)
        else:
            guard_id = action.split(' ')[1]
            if not guard_id in guards:
                guards[guard_id] = Guard(guard_id)
            active_guard = guard_id


def main(input_data):
    global guards

    sorted_data = sorted(input_data, key=lambda x: str(re.search(
        r"(?<=\[).*(?=\])", x)))
    process_data(sorted_data)

    sleepy_boi = max(guards.values(), key=lambda boi: boi.total_minutes_slept)
    sleepy_time, _ = max(enumerate(sleepy_boi.time_table),
                         key=operator.itemgetter(1))

    return (sleepy_boi.guard_id, sleepy_time)


if __name__ == '__main__':
    with open('input.txt') as file:
        input_data = file.read().strip().split('\n')
        guard, time = main(input_data)
        print(int(guard[1:]) * time)

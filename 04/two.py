import re
from dateutil import parser
import operator

# string constants
WAKES_UP = 'wakes up'
FALLS_ASLEEP = 'falls asleep'


class Guard:
    def __init__(self, guard_id):
        self.guard_id = guard_id
        # datetime of when a guard goes to sleep
        self.time_went_to_sleep = None
        # a counter of all the minutes the guard has slept
        self.total_minutes_slept = 0
        # a list with each slot represting a minute in the midnight hour
        self.time_table = [0] * 60

    def __repr__(self):
        """ outputs guard id when printing for easier testing/debugging """
        return self.guard_id

    def go_to_sleep(self, time):
        # sets the current time that the guard has gone to sleep
        self.time_went_to_sleep = time

    def wake_up(self, time):
        # get the time delta between when guard went to sleep and when they woke up
        delta = time - self.time_went_to_sleep

        # get the minute in the hour that the guard went to sleep
        start_minute = int(self.time_went_to_sleep.minute)
        # get the total number of minutes slept from the timedelta
        minutes_slept = int(delta.total_seconds() / 60)

        # iterate over the minutes slept ranging from start to end
        for minute in range(start_minute, start_minute + minutes_slept):
            # increment the slot in the time table the corrisponds with this minute
            self.time_table[minute] += 1
            # increment the total minutes slept by this guard
            self.total_minutes_slept += 1


def process_data(input_data):
    # variable to keep track of the current on duty guard
    active_guard = None
    # dictionary to collect all the guards that patrol
    guards = {}

    # iterate over all the lines in the input
    for item in input_data:
        # split the input into it's date and action components
        raw_date, action = item.split('] ')
        # strip the initial bracket off the front of the time
        date = raw_date.replace('[', '')
        # parse the string date to a datetime object
        dt = parser.parse(date)

        if action == FALLS_ASLEEP:
            # if the action is fall asleep, put the
            # guard to sleep and pass the time as argument
            guards[active_guard].go_to_sleep(dt)
        elif action == WAKES_UP:
            # if the action is wake up, wake the
            # guard up and pass the time as argument
            guards[active_guard].wake_up(dt)
        else:
            # if the action is not wake up or fall asleep
            # grab the guard id from the action string
            guard_id = action.split(' ')[1]
            if not guard_id in guards:
                # if the guard hasn't been initialized and
                # added to the guard dictionary do so
                guards[guard_id] = Guard(guard_id)
            # set this guard to the active guard
            active_guard = guard_id

    # return the guards dictionary so it can be used in the main function
    return guards


def main(input_data):
    # the initial input was not sorted crchronologically
    # this sorts the data so that it can be used
    sorted_data = sorted(input_data, key=lambda x: str(re.search(
        r"(?<=\[).*(?=\])", x)))
    # process the data using the process_data function
    guards = process_data(sorted_data)

    # use the max function with a max function on the guards
    # time table as the sort key to find the guard who sleeps
    # the most at a particular time
    sleepy_boi = max(guards.values(), key=lambda boi: max(boi.time_table))
    # use the max function again to find the index in the guard's
    # time table, which is also the minute that they sleep the most
    sleepy_time, _ = max(enumerate(sleepy_boi.time_table),
                         key=operator.itemgetter(1))

    # return the guard and the minute they sleep the most
    return (sleepy_boi.guard_id, sleepy_time)


if __name__ == '__main__':
    with open('input.txt') as file:
        input_data = file.read().strip().split('\n')
        guard, time = main(input_data)
        # multiply the id and minute for solution
        print(int(guard[1:]) * time)

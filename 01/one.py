from functools import reduce


def calc(input_data):
    total = 0
    for shift in input_data:
        total += int(shift)
    return total


if __name__ == "__main__":
    with open("input.txt") as file:
        # read the input, split by lines and use it as argument to main function
        input_data = file.read().split('\n')
        output = calc(input_data)
        print(output)

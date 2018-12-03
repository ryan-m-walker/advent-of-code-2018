
def calc(input_data, total=0, freq={}):
    # initialize variable to find the found number once found
    found = None

    # iterate over each item in input list
    for item in input_data:
        if total in freq:
            # if the frequency dictionary already has a key with
            # the current total then we found then number we are
            # looking for. Set the found variable to it and break
            found = total
            break
        else:
            # if frequency dictionary has no key that is
            # equal to the current total, create one
            # and just set it to the value True to indicate
            # this total has been found before already
            freq[total] = True

        # add the current shift to the total
        total += int(item)

    # if the found variable is still None, then our number hasn't been
    # found yet and we need to continue looping through our input and
    # adding it to our running total. Recursively call this 'calc' function
    # but pass the current total and frequency into the initialization arguments
    if not found:
        return calc(input_data, total)

    # if we passed the above check that means
    # we found our number and we can return it
    return found


if __name__ == "__main__":
    with open("input.txt") as file:
        # read the input, split by lines and use it as argument to main function
        input_data = file.read().split('\n')
        output = calc(input_data)
        print(output)

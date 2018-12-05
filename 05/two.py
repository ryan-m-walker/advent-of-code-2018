from string import ascii_lowercase, ascii_uppercase
import operator


def are_same_character(a, b):
    # check if both charactesr are the same
    # character regardless of their casing
    return a.lower() == b.lower()


def are_opposite_case(a, b):
    # test to see if each character is opposite casing to each
    # other by using a string of all upper and lower case characters
    return a in ascii_lowercase and b in ascii_uppercase \
        or a in ascii_uppercase and b in ascii_lowercase


def calc(input_data):
    # variable to determine if we should continue to loop through sequence
    reactions_occuring = True

    # loop through data until we have no more interactions
    while reactions_occuring:
        # initialize this as false so the loop will
        # break if no reactions are found this time
        reactions_occuring = False

        # iterate over the characters and get reference to the index
        for index, char in enumerate(input_data):
            # make sure it's not the last character
            # because if it is it won't have a next char
            if index == len(input_data) - 1:
                continue

            # get a reference to the next character in the sequence
            next_char = input_data[index + 1]

            # test if the current and next character are the same character
            # and if they also have opposite casing
            if are_same_character(char, next_char) and are_opposite_case(char, next_char):
                # set the reactions occuring variable to true to indicate that
                # we are going to have to go back through the list again
                reactions_occuring = True
                # delete both characters from the list since the react with each other
                del input_data[index: index + 2]

    # if no reactions were found that means we're done
    # and can return the lenght of the final sequence
    return len(input_data)


def main(input_data):
    # initialize a list to hold the lengths of each reaction after character has been removed
    lengths = []

    # since we will be removing a letter in both upper case and lower case
    # we can just loop over a list of lowercase letters
    for letter in ascii_lowercase:
        # create a list of the input with the current letter filtered out
        # convert the letter to lowercase in filtering so we get both cases
        filtered_input = list(
            filter(lambda x: x.lower() != letter, input_data))
        # run the calc function on the filtered list and
        # append its result to the lengths list
        lengths.append(calc(filtered_input))

    # find the smallest value in the final lengths list
    # we can use the index of that value to determine
    # which letter it is by using that index on the
    # ascii_lowercase string
    index, value = min(enumerate(lengths), key=operator.itemgetter(1))

    return (ascii_lowercase[index], value)


if __name__ == '__main__':
    with open('input.txt') as file:
        # read the input and get a list of characters
        input_data = list(file.read().strip())
        char, value = main(input_data)
        print(value)

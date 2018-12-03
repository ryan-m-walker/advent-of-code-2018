
def calc(input):
    total_twos = []
    total_threes = []

    # loop over every ID
    for box_id in input:
        # a table for all of the character frequencies in a single ID
        char_freq = {}

        # loop over every character in the ID
        for char in list(box_id):
            # if a key doesn't exist on the char_freq dictionary create one
            if not char in char_freq:
                char_freq[char] = 0
            # increment the character amount on the dictionary
            char_freq[char] += 1

        # list a list to hold all the instances of a character
        # occuring two and three times in an ID
        two = []
        three = []
        # loop over all the keys in the character frequency dictionary
        for key in char_freq.keys():
            # if the character occured 2 times add it to the two list
            if char_freq[key] == 2:
                two.append(key)
            # if the character occured 3 times add it to the three list
            if char_freq[key] == 3:
                three.append(key)

        # if only one instance of a charcter occuring twice happens
        if len(two) > 0:
            # add the item to the total two dictionary
            total_twos.append(box_id)
        # if only one instance of a character occuring thrice happens
        if len(three) > 0:
            # add the item to the total three dictionary
            total_threes.append(box_id)

    return len(total_twos) * len(total_threes)


if __name__ == "__main__":
    with open("input.txt") as file:
        # read the input, split by lines and use it as argument to main function
        input_data = file.read().split('\n')
        output = calc(input_data)
        print(output)

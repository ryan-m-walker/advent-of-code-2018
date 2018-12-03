import numpy as np


SQUARE_SIZE = 1000
COLLISION_SYMBOL = 'X'
CLAIM_SPACE_SYMBOL = '#'


class FabricSquare:
    def __init__(self, claim_id, x, y, width, height):
        self.claim_id = claim_id
        self.x = x
        self.y = y
        self.width = width
        self.height = height

        # create a list of all the row/column coordinates the fabric rectangle takes up
        # so that it can easily be iterated over and mapped to the main fabric piece
        coordinates = []
        for row in range(self.y, self.y + self.height):
            for cell in range(self.x, self.x + self.width):
                coordinates.append((row, cell))

        self.coordinates = coordinates


def parse_input(input_data):
    """
    Takes a line for the input and parses the string to a FabricRectangle instance
    """
    cleaned_input = input_data.replace('@ ', '').replace(':', '')
    split_data = cleaned_input.split(' ')
    xy = split_data[1].split(',')
    wh = split_data[2].split('x')
    return FabricSquare(
        claim_id=split_data[0],
        x=int(xy[0]),
        y=int(xy[1]),
        width=int(wh[0]),
        height=int(wh[1])
    )


def main(input_data):
    # create an empty array with the main fabric size, one cell representing a square inch
    main_fabric = np.empty((SQUARE_SIZE, SQUARE_SIZE), dtype=np.str)
    # take the inputed list of strings and use the parse function
    # and map to get back a list of FabricRectangle instances
    parsed_input = list(map(parse_input, input_data))

    # iterate over all of the FabricRectangle instances
    for fabric_claim in parsed_input:
        # iterate over all of the coordinates in the FabricRectangle instance
        for coordinate in fabric_claim.coordinates:
            row, cell = coordinate
            # if a space is already claimed or a collision already exists,
            # mark the space with a collision symbol
            if main_fabric[row][cell] == COLLISION_SYMBOL \
                    or main_fabric[row][cell] == CLAIM_SPACE_SYMBOL:
                main_fabric[row][cell] = COLLISION_SYMBOL
            # if space is unclaimed, mark it with claim space symbol
            else:
                main_fabric[row][cell] = CLAIM_SPACE_SYMBOL

    # initialize a variable to hold ID of the fabric
    # piece with no collisions once it has been found
    found_id = None
    # iterate back over all of the FabricRectangle instances
    for fabric_claim in parsed_input:
        # initialize a variable declaring whether or not the
        # current fabricRectangle has any collisions with other pieces
        no_collisions = True
        # iterate over all of the coordinates for the current fabric piece
        for coordinate in fabric_claim.coordinates:
            row, cell = coordinate
            # if any of the coordinates on the current fabric peice map to
            # a collision symbol on the main fabric array, change the 'no_collisions'
            # variable to false to indicate the piece is not the correct piece
            if main_fabric[row][cell] == COLLISION_SYMBOL:
                no_collisions = False

        # if this piece of did not encounter any collision symbols
        # then we have found the piece we are look for. Set found_id
        # variable this piece's id, break the loop and return the id
        if no_collisions:
            found_id = fabric_claim.claim_id
            break

    return found_id


if __name__ == "__main__":
    with open("input.txt") as file:
        # read the input, split by lines and use it as argument to main function
        input_data = file.read().split('\n')
        output = main(input_data)
        print(output)

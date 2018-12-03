import re
import numpy as np


SQUARE_SIZE = 1000


class FabricSquare:
    def __init__(self, claim_id, x, y, width, height):
        self.claim_id = claim_id
        self.x = x
        self.y = y
        self.width = width
        self.height = height

        coordinates = []
        for row in range(self.y, self.y + self.height):
            for cell in range(self.x, self.x + self.width):
                coordinates.append((row, cell))

        self.coordinates = coordinates


def render_fabric(fabric):
    final_render = ''
    for row in fabric:
        for cell in row:
            if cell == '':
                final_render += ' '
            else:
                final_render += cell
        final_render += '\n'
    return final_render


def parse_input(input_data):
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
    main_fabric = np.empty((SQUARE_SIZE, SQUARE_SIZE), dtype=np.str)
    parsed_input = list(map(parse_input, input_data))

    found_id = []

    for fabric_claim in parsed_input:
        for coordinate in fabric_claim.coordinates:
            row, cell = coordinate
            if main_fabric[row][cell] == 'X' or main_fabric[row][cell] == '#':
                main_fabric[row][cell] = 'X'
            else:
                main_fabric[row][cell] = '#'

    print(main_fabric)

    for fabric_claim in parsed_input:
        no_collisions = True
        for coordinate in fabric_claim.coordinates:
            row, cell = coordinate
            if main_fabric[row][cell] == 'X':
                no_collisions = False

        if no_collisions:
            found_id.append(fabric_claim.claim_id)

    return found_id

    # for fabric_claim in parsed_input:
    #     no_collisions = True
    #     for other in parsed_input:
    #         if fabric_claim == other:
    #             continue
    #         for coordinate in fabric_claim.coordinates:
    #             if coordinate in other.coordinates:
    #                 no_collisions = False

    #     if no_collisions:
    #         found_id.append(fabric_claim.claim_id)


if __name__ == "__main__":
    with open("input.txt") as file:
        input_data = file.read().split('\n')
        output = main(input_data)
        print(output)

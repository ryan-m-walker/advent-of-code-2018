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
    print(main_fabric)
    parsed_input = list(map(parse_input, input_data))

    for fabric_claim in parsed_input:
        for coordinate in fabric_claim.coordinates:
            row, cell = coordinate
            if main_fabric[row][cell] == 'X':
                continue
            elif main_fabric[row][cell] == '#':
                main_fabric[row][cell] = 'X'
            else:
                main_fabric[row][cell] = '#'

    flat_array = main_fabric.flatten()

    total_collisions = 0

    for cell in flat_array:
        if cell == 'X':
            total_collisions += 1

    return total_collisions


if __name__ == "__main__":
    with open("input.txt") as file:
        input_data = file.read().split('\n')
        output = main(input_data)
        print(output)

from collections import defaultdict


def manhattan_distance(a, b):
    return abs(a[0] - b[0]) + abs(a[1] - b[1])


def find_closest(point, coordinates):
    # find the coordinate closest to the given point
    # return None if there is a tie
    distances = [(i, manhattan_distance(point, coord)) for i, coord in enumerate(coordinates)]
    distances.sort(key=lambda x: x[1])

    # check for tie
    if distances[0][1] == distances[1][1]:
        return None

    return distances[0][0]


def calc(coordinates):
    # find the bounding box
    min_x = min(c[0] for c in coordinates)
    max_x = max(c[0] for c in coordinates)
    min_y = min(c[1] for c in coordinates)
    max_y = max(c[1] for c in coordinates)

    # count the area for each coordinate
    areas = defaultdict(int)

    # track which coordinates have infinite areas
    infinite = set()

    # iterate over every point in the bounding box
    for x in range(min_x, max_x + 1):
        for y in range(min_y, max_y + 1):
            closest = find_closest((x, y), coordinates)

            # skip ties
            if closest is None:
                continue

            areas[closest] += 1

            # if the point is on the edge of the bounding box
            # the coordinate has an infinite area
            if x == min_x or x == max_x or y == min_y or y == max_y:
                infinite.add(closest)

    # find the largest area that isn't infinite
    largest = 0
    for coord_index, area in areas.items():
        if coord_index not in infinite and area > largest:
            largest = area

    return largest


if __name__ == '__main__':
    with open('input.txt') as file:
        coordinates = []
        for line in file.read().strip().split('\n'):
            x, y = line.split(', ')
            coordinates.append((int(x), int(y)))
        print(calc(coordinates))

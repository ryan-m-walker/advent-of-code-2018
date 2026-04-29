def manhattan_distance(a, b):
    return abs(a[0] - b[0]) + abs(a[1] - b[1])


def calc(coordinates, max_distance=10000):
    # find the bounding box
    min_x = min(c[0] for c in coordinates)
    max_x = max(c[0] for c in coordinates)
    min_y = min(c[1] for c in coordinates)
    max_y = max(c[1] for c in coordinates)

    # count the number of points in the safe region
    region_size = 0

    # iterate over every point in the bounding box
    for x in range(min_x, max_x + 1):
        for y in range(min_y, max_y + 1):
            # calculate the total distance to all coordinates
            total_distance = sum(manhattan_distance((x, y), coord) for coord in coordinates)

            # if the total distance is less than the max
            # then this point is in the safe region
            if total_distance < max_distance:
                region_size += 1

    return region_size


if __name__ == '__main__':
    with open('input.txt') as file:
        coordinates = []
        for line in file.read().strip().split('\n'):
            x, y = line.split(', ')
            coordinates.append((int(x), int(y)))
        print(calc(coordinates))

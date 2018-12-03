
def find_pairs(ids):
    for box_id in ids:
        sameness = {}
        for second_id in ids:
            if box_id == second_id:
                continue
            sameness[second_id] = 0
            for i in range(len(box_id)):
                if box_id[i] == second_id[i]:
                    sameness[second_id] += 1

            if sameness[second_id] == len(ids[0]) - 1:
                return (box_id, second_id)


def get_final_output(pairs):
    id1, id2 = pairs
    final_output = ''
    for i in range(len(id1)):
        if id1[i] == id2[i]:
            final_output += id1[i]
    return final_output


def main(ids):
    pairs = find_pairs(ids)
    final_output = get_final_output(pairs)
    return final_output


if __name__ == "__main__":
    with open("input.txt") as file:
        ids = file.read().split('\n')
        output = main(ids)
        print(output)

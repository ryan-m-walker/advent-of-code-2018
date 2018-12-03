
def calc(input, total=0, freq={}):
    found = None

    for item in input:
        if total in freq:
            print(total)
            found = total
            break
        else:
            freq[total] = True

        sign = item[0]
        num = int(item[1:])
        if sign == '+':
            total += num
        else:
            total -= num

    if not found:
        return calc(input, total)

    return found


if __name__ == "__main__":
    with open("input.txt") as file:
        data = file.read().split('\n')
        print(calc(data))

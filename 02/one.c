#include <stdio.h>
#include <string.h>

#define MAX_IDS 300
#define MAX_LEN 64

int main(void) {
    FILE *fp = fopen("input.txt", "r");
    if (!fp) {
        perror("input.txt");
        return 1;
    }

    char ids[MAX_IDS][MAX_LEN];
    int count = 0;

    while (fgets(ids[count], MAX_LEN, fp) && count < MAX_IDS) {
        ids[count][strcspn(ids[count], "\n")] = '\0';
        if (ids[count][0] != '\0')
            count++;
    }
    fclose(fp);

    int twos = 0, threes = 0;

    for (int i = 0; i < count; i++) {
        int freq[26] = {0};
        for (int j = 0; ids[i][j]; j++)
            freq[ids[i][j] - 'a']++;

        int has_two = 0, has_three = 0;
        for (int j = 0; j < 26; j++) {
            if (freq[j] == 2) has_two = 1;
            if (freq[j] == 3) has_three = 1;
        }
        twos += has_two;
        threes += has_three;
    }

    printf("%d\n", twos * threes);
    return 0;
}

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

    for (int i = 0; i < count; i++) {
        int len = strlen(ids[i]);
        for (int j = i + 1; j < count; j++) {
            int diffs = 0;
            for (int k = 0; k < len; k++) {
                if (ids[i][k] != ids[j][k])
                    diffs++;
            }
            if (diffs == 1) {
                for (int k = 0; k < len; k++) {
                    if (ids[i][k] == ids[j][k])
                        putchar(ids[i][k]);
                }
                putchar('\n');
                return 0;
            }
        }
    }

    return 1;
}

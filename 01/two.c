#include <limits.h>
#include <stdio.h>
#include <stdlib.h>

// Simple open-addressing hash set for the frequencies we have already seen.
#define TABLE_SIZE 1048576  // power of two, must be > number of distinct freqs
#define EMPTY_SLOT LONG_MIN

static long table[TABLE_SIZE];

static size_t slot_for(long value) {
  // Knuth multiplicative hash, masked to the table size.
  size_t index = (size_t)(value * 2654435761u) & (TABLE_SIZE - 1);
  while (table[index] != EMPTY_SLOT && table[index] != value) {
    index = (index + 1) & (TABLE_SIZE - 1);
  }
  return index;
}

// Returns 1 if the value was already present, 0 if it was newly inserted.
static int seen(long value) {
  size_t index = slot_for(value);
  if (table[index] == value) {
    return 1;
  }
  table[index] = value;
  return 0;
}

int main(void) {
  FILE *file = fopen("input.txt", "r");
  if (file == NULL) {
    perror("input.txt");
    return 1;
  }

  // Read every shift into a dynamic array so we can cycle over it.
  size_t capacity = 1024;
  size_t count = 0;
  long *shifts = malloc(capacity * sizeof(long));
  if (shifts == NULL) {
    fclose(file);
    return 1;
  }

  long shift;
  while (fscanf(file, "%ld", &shift) == 1) {
    if (count == capacity) {
      capacity *= 2;
      long *grown = realloc(shifts, capacity * sizeof(long));
      if (grown == NULL) {
        free(shifts);
        fclose(file);
        return 1;
      }
      shifts = grown;
    }
    shifts[count++] = shift;
  }
  fclose(file);

  for (size_t i = 0; i < TABLE_SIZE; i++) {
    table[i] = EMPTY_SLOT;
  }

  long total = 0;
  seen(total);
  while (1) {
    for (size_t i = 0; i < count; i++) {
      total += shifts[i];
      if (seen(total)) {
        printf("FOUND: %ld\n", total);
        free(shifts);
        return 0;
      }
    }
  }
}

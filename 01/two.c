#include <stdio.h>
#include <stdlib.h>

/* Simple open-addressing hash set of longs so we can check whether a
 * frequency has been seen before in (amortized) constant time. */
typedef struct {
  long *slots;
  char *used;
  size_t cap;
  size_t len;
} Set;

static void set_init(Set *s, size_t cap) {
  s->cap = cap;
  s->len = 0;
  s->slots = malloc(cap * sizeof(long));
  s->used = calloc(cap, sizeof(char));
}

static size_t set_index(Set *s, long value) {
  /* mix the (possibly negative) value into a non-negative slot */
  size_t i = (size_t)(value * 2654435761u) & (s->cap - 1);
  while (s->used[i] && s->slots[i] != value) {
    i = (i + 1) & (s->cap - 1);
  }
  return i;
}

static void set_grow(Set *s) {
  size_t old_cap = s->cap;
  long *old_slots = s->slots;
  char *old_used = s->used;

  set_init(s, old_cap * 2);
  for (size_t i = 0; i < old_cap; i++) {
    if (old_used[i]) {
      size_t j = set_index(s, old_slots[i]);
      s->slots[j] = old_slots[i];
      s->used[j] = 1;
      s->len++;
    }
  }
  free(old_slots);
  free(old_used);
}

/* returns 1 if value was already present, 0 if it was newly added */
static int set_add(Set *s, long value) {
  if ((s->len + 1) * 2 >= s->cap) {
    set_grow(s);
  }
  size_t i = set_index(s, value);
  if (s->used[i]) {
    return 1;
  }
  s->slots[i] = value;
  s->used[i] = 1;
  s->len++;
  return 0;
}

int main(void) {
  FILE *file = fopen("input.txt", "r");
  if (file == NULL) {
    perror("input.txt");
    return 1;
  }

  /* read every shift into a growable array so we can cycle over them */
  size_t cap = 1024, count = 0;
  int *shifts = malloc(cap * sizeof(int));
  int shift;
  while (fscanf(file, "%d", &shift) == 1) {
    if (count == cap) {
      cap *= 2;
      shifts = realloc(shifts, cap * sizeof(int));
    }
    shifts[count++] = shift;
  }
  fclose(file);

  Set seen;
  set_init(&seen, 1024);
  set_add(&seen, 0); /* frequency starts at 0 */

  long total = 0;
  for (size_t i = 0;; i = (i + 1) % count) {
    total += shifts[i];
    if (set_add(&seen, total)) {
      printf("%ld\n", total);
      break;
    }
  }

  free(shifts);
  free(seen.slots);
  free(seen.used);
  return 0;
}

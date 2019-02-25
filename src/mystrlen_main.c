#include <stdio.h>

extern size_t mystrlen(char *str);

int main()
{
  char s[100];

  while (scanf("%s", s) == 1)
    printf("length of %s: %lu\n", s, mystrlen(s));

  return 0;
}

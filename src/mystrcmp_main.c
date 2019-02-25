#include <stdio.h>

extern int mystrcmp(const char *str1, const char *str2);

int main()
{
  char str1[100], str2[100];

  while (scanf("%99s%99s", str1, str2) == 2)
    printf("mystrcmp(%s, %s) = %d\n", str1, str2, mystrcmp(str1, str2));
  
  return 0;
}

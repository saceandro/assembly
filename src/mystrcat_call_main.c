#include <stdio.h>

extern char *mystrcat2(char *s1, const char *s2);

int main()
{
  char s1[199], s2[100];

  while (scanf("%99s%99s", s1, s2) == 2)
    printf("%s\n", mystrcat2(s1, s2));
  
  return 0;
}

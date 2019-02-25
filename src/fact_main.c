#include <stdio.h>

extern long long int fact(long long int i);

int main()
{
  long long int n;
  while (scanf("%lld", &n) == 1)
    printf("%lld\n", fact(n));
  return 0;
}

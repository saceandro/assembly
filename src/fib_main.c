#include <stdio.h>

extern long long int fib(long long int n);

int main()
{
  long long int n;
  while (scanf("%lld", &n) == 1)
    printf("fib(%lld) = %lld\n", n, fib(n));
  return 0;
}

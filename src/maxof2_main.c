#include <stdio.h>

extern long long int maxof2(long long int x, long long int y);

int main()
{
  long long int a,b;
  
  while(scanf("%lld%lld", &a, &b) == 2)
    printf("maxof2(%lld, %lld): %lld\n", a, b, maxof2(a,b));
  
  return 0;
}

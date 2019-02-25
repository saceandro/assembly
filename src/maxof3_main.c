#include <stdio.h>

extern long long int maxof3(long long int x, long long int y, long long int z);

int main()
{
  long long int a,b,c;
  
  while(scanf("%lld%lld%lld", &a, &b, &c) == 3)
    printf("maxof3(%lld, %lld, %lld): %lld\n", a, b, c, maxof3(a,b,c));
  
  return 0;
}

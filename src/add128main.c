#include <stdio.h>
extern void add128(unsigned long long int*, unsigned long long int*, unsigned long long int*);
int main()
{
  unsigned long long int a[2] = {0x1ULL, 0xffffffffffffffffULL};
  unsigned long long int b[2] = {0x2ULL, 0x2ULL};
  unsigned long long int c[2];

  add128(c, a, b);
  printf("繰り上がりあり: %llx %llx + %llx %llx = %llx %llx\n", a[0], a[1], b[0], b[1], c[0], c[1]);

  a[0] = 0x3ULL;
  a[1] = 0x4ULL;
  b[0] = 0xaULL;
  b[1] = 0xbULL;  

  add128(c, a, b);
  printf("繰り上がりなし: %llx %llx + %llx %llx = %llx %llx\n", a[0], a[1], b[0], b[1], c[0], c[1]);

  return 0;
}

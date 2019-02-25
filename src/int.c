#include <stdio.h>
#include <limits.h>

int main()
{
  printf("INT_MIN: %d\n", INT_MIN);
  printf("INT_MAX: %d\n", INT_MAX);
  
  int n;
  int i;
  
  while (scanf("%d", &n) == 1)
    {
      printf("入力された10進符号付き整数: %d\n", n);
      printf("16進数: %x\n2進数bitパターン: ", n);
      
      for (i=31; i>=0; i--)
	printf("%d", (n>>i) & 1);
      printf("\n\n");
    }
  return 0;
}

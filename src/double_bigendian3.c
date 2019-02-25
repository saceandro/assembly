#include <stdio.h>
#include <float.h>

union _DoubleBit 
{
  long long int c;
  double d;
}
  DoubleBit;

int main()
{
  printf("DBL_MIN: %e\n", DBL_MIN);
  printf("DBL_MAX: %e\n", DBL_MAX);
  
  int i, bit;
  
  while(scanf("%lf",&DoubleBit.d) == 1)
    {
      printf("入力されたdouble値: %f\nbitパターン :", DoubleBit.d);
      
      for (i=63;i>=0;i--)
	{
	  bit=(DoubleBit.c>>i)&0x00000001;
	  printf("%d",bit);
	}

      printf("\n\n");
    }
  return 0;
}

#include <stdio.h>

extern void mulmat(double *c, const double *a, const double *b);

int main ()
{
  int i, j, k, l;
  double a[3][16];

  while (1)
    {
      for (k=0; k<2; k++)
	{
	  for (i=0; i<4; i++)
	    {
	      for (j=0; j<4; j++)
		{
		  l = scanf("%lf", &a[k][i*4+j]);
		  if (l!=1) break;
		}
	    }
	}
      if (l!=1) break;
      
      mulmat(a[2], a[0], a[1]);
      
      for(i=0;i<4;i++)
	{
	  for(j=0;j<4;j++)
	    printf("%f ", a[2][i*4+j]);
	  printf("\n");
	}
      printf("\n");
    }
  
  return 0;
}

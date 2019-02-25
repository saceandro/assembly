#include <stdio.h>

extern double inner(const double *a, const double *b);

int main()
{
  double x[4];
  double y[4];

  while (scanf("%lf%lf%lf%lf%lf%lf%lf%lf", &x[0], &x[1], &x[2], &x[3], &y[0], &y[1], &y[2], &y[3]) == 8)
    printf("(%f %f %f %f)・(%f %f %f %f) = %f\n", x[0], x[1], x[2], x[3], y[0], y[1], y[2], y[3], inner(x, y));
  
  return 0;
}

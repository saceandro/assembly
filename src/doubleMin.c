#include <stdio.h>
#include <float.h>
#include <math.h>

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

/* 1.0より大きい最小の正の数のビットパターンは、 */
/* 0011111111110...01 (符号が0、指数部が01...1、仮数部が0...01) */
/* これは、long long int 型のビットパターンとして考えると、 */
  long long int n = 0;
  int i;
  for (i=61; i>=52; i--)
    n += pow(2,i);
  DoubleBit.c = n + 1;
  printf("1.0より大きい最小の正の数: %.20f\n", DoubleBit.d);

/*  正規化数で最小の正の数のビットパターンは */
/*  0000000000010...0 (符号が0、指数部が0...01、仮数部が0...0)*/
/*  これは、long long int 型のビットパターンとして考えると、2**52 = 4503599627370496にあたる */
  DoubleBit.c = 4503599627370496LL;
  printf("正規化数の最小の正の数: %e\n", DoubleBit.d);

/*  IEEE754における最小の正の数、即ち非正規化数を含む最小の正の数のビットパターンは、*/
/*  0...01 (符号が0、指数部が0...0、仮数部が0...01) */
/*  これは、 longlong int 型のビットパターンとして考えると、2**0 = 1にあたる */
  DoubleBit.c = 1LL;
  printf("非正規化数の最小の正の数: %e\n", DoubleBit.d);

  return 0;
}

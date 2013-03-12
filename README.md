findPLL
----------

 A quick and dirty Haskell program to find PLL (Phase locked loop) configurations for the Cortex M3. Pass in your desired frequency (in MHz) and get out a table of possible M, N and CCLKDIV values which will result in the desired frequency with a safe PLL frequency.

$ ./findPll 44.1
 M    N  CCLKDIV
147    8   10
147   10    8
294   16   10
294   20    8
441   20   12
441   24   10
441   30    8

#include <stdio.h>

int main( int argc, char *argv[] )  {

   if( argc == 2 ) {
      printf(atoi(argv[1])-atoi(argv[2]));
   }
   else {
      printf("err\n");
   }
return 0;
}
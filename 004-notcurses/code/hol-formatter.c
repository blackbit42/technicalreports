//#include <stdio.h>
#include <stdlib.h>
#include <notcurses.h>

int main(void){
  const char blue[] = "house";
  const char *b = blue;
  struct ncdirect* n = notcurses_directmode(NULL, stdout);
  int c, ret = 0;
  if(n){
    while(!ret && (c = getchar()) != EOF){
      if(*b == c){
        ++b;
      }else{
        if(b > blue){
          if(!*b){
            ret |= ncdirect_fg(n, 0x0339dc);
          }
          ret |= (printf("%.*s", (int)(b - blue), blue) < 0 ? -1 : 0);
          if(!*b){
            ret |= ncdirect_fg_default(n);
          }
          b = blue;
        }
        ret |= (putchar(c) == EOF) ? -1 : 0;
      }
    }
    if(b > blue){
      ret = (printf("%.*s", (int)(b - blue), blue) < 0) ? -1 : 0;
    }
  }
  return (!n || ncdirect_stop(n) || !feof(stdin) || ret) ?
          EXIT_FAILURE : EXIT_SUCCESS;
}
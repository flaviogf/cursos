#include <stdio.h>
#include <stdlib.h>
#include "helper.h"

int main(int argc, char **argv)
{
  const char str1[] = { "Test " };
  const char str2[] = { "works" };

  char result[11];
  concat(result, str1, 5, str2, 6);

  printf("%s\n", result);

  for(int i = 0; i < 11; ++i) printf("%c", result[i]);

  printf("\n");

  return EXIT_SUCCESS;
}
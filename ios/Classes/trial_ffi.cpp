// cat > ios/Classes/trial_ffi.cpp << EOF
#include <stdint.h>
#include <iostream>
int i;
int key =5;
char temp;
char* inputresult;

extern "C" __attribute__((visibility("default"))) __attribute__((used)) 

char* encrypt(char* input)
{
    inputresult = input;
    for (i = 0; input[i] != '\0'; ++i)
    {
        temp = input[i];
        if (temp >= 'a' && temp <= 'z')
        {
            temp = temp + key;
            if (temp > 'z')
            {
                temp = temp - 'z' + 'a' - 1;
            }
        input[i] = temp;
        }
        else if (temp >= 'A' && temp <= 'Z'){
            temp = temp + key;
            if (temp > 'Z'){
                temp = temp - 'Z' + 'A' -1;
            }
        input[i] = temp;
        }
    }
    return input;
}

extern "C" __attribute__((visibility("default"))) __attribute__((used)) char* decrypt(char* input)
{
    for (i = 0; input[i] != '\0'; ++i)
    {
        temp = input[i];
        if (temp >= 'a' && temp <= 'z')
        {
            temp = temp - key;
            if (temp < 'a')
            {
                temp = temp + 'z' - 'a' + 1;
            }
        input[i] = temp;
        }
        else if (temp >= 'A' && temp <= 'Z'){
            temp = temp - key;
            if (temp < 'A'){
                temp = temp + 'Z' - 'A' +1;
            }
        input[i] = temp;
        }
    }
    return input;
}


// int32_t trial_ffi(int32_t x, int32_t y) {
//     return x + y;
// }
// EOF

/*
 * StackFrame.c
 *
 * Source file for StackFrame module that provides functionality relating to
 * stack frames and printing out stack frame data.
 *
 */

#include <stdio.h>
#include "StackFrame.h"


/*
 * Non-static (akin to "public") functions that can be called from anywhere.
 * Comments for each function are given in the module interface StackFrame.h
 *
 * At present, they all just return 0 or do nothing.
 *
 * These are the functions you have to implement.
 *
 */

unsigned long getBasePointer() {
    unsigned long base_pointer;
    asm("movq %%rbp, %0" : "=r" (base_pointer));
    return *((unsigned long *)base_pointer);
}


unsigned long getReturnAddress() {
    unsigned long return_address;
    asm("movq (%%rsp), %0" : "=r" (return_address));
    return return_address;
}

void printStackFrameData(unsigned long basePointer, unsigned long previousBasePointer) {
    unsigned long* current_pointer = (unsigned long*) basePointer;
    unsigned long* previous_pointer = (unsigned long*) previousBasePointer;

    // Iterate through the stack frame
    while (current_pointer > previous_pointer) {
        // Print the memory address and its value in hexadecimal format
        printf("%p: 0x%lx\n", current_pointer, *current_pointer);
        // Move to the next memory address in the stack frame
        current_pointer--;
    }
}

void printStackFrames(int number) {
    // Define a pointer to the current base pointer
    unsigned long* base_pointer;

    // Obtain the current base pointer
    asm ("movq %%rbp, %0" : "=r" (base_pointer));

    // Iterate through the stack frames
    for (int i = 0; i < number; ++i) {
        printf("-------------\n");
      

        // Print the stack frame data
        for (int j = 0; j < 4; ++j) {
            printf("%016lx:   %016lx   --   ", (unsigned long)(base_pointer + j), *(base_pointer + j));
            for (int k = 0; k < 8; ++k) {
                printf("%02lx   ", (*(unsigned char*)(base_pointer + j) >> (k * 8)) & 0xFF);
            }
            printf("\n");
        }

        // Move to the previous stack frame
        base_pointer = (unsigned long*)*base_pointer;
    }
}

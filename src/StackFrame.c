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
    asm volatile("movq %%rbp, %0" : "=r" (base_pointer));
    return *((unsigned long *)base_pointer);
}


unsigned long getReturnAddress() {
    unsigned long return_address;
    asm volatile(
        "movq (%%rsp), %0" 
        : "=r" (return_address) 
        : /* no input operands */
    );
    return return_address;
}

void printStackFrameData(unsigned long basePointer, unsigned long previousBasePointer) {
}

void printStackFrames(int number) {
}

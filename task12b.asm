global _start

section .text
%INCLUDE "mystring.asm"
%INCLUDE "printdec.asm"
%INCLUDE "testlib.asm"

_start:
FUNC mystrchr, "strchr"
OK    0,  "abcde",      "a", 1
OK    3,  "fffwwqw",    "w", 2
OK    3,  "abcde",      "d", 3
NONE      "qweasd",     "z", 4
OK    7,  "qqqqqqqr",   "r", 5
OK    0,  "apple",      "a", 6
OK    2,  "banana",     "n", 7
OK    4,  "hello",      "o", 8
OK    2,  "world",      "r", 9
OK    1,  "goodbye",    "o", 10
NONE     "cat",         "z", 11
NONE     "dog",         "x", 12
OK    3,  "python",     "h", 13
OK    7,  "javascript", "i", 14
OK    0,  "cpp",        "c", 15
OK    1,  "badtest",    "b", 16
DONE
	mov rax, 60
	mov rdi, 0
	syscall

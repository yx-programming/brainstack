# BrainStack - Brainf but it's a stack
## Note that for brevity BrainStack will be refered to as BS from this point

# Specification
BS is a stack-based, simple, and predictable programming language. As a matter of fact, there are only 8 instructions!
`#`: Takes the next two characters in the program, interpreted as two hex digits, and adds it to the stack
`.`: Pops the top value from the stack and prints it as a hex value
`:`: Duplicates the top of the stack
`~`: Pops the second item on the stack and pushes it to the top
`+`: Pops the top two values from the stack, adds them, and pushes the result to the stack
`-`: Subtracts the top of the stack from the second value on the stack, and pushes the result
`[`: Seeks the matching `]` in the program if the top of the stack is 0
`]`: Seeks the matching `[` in the program if the top of the stack is NOT 0

## Implementation Details:
BS uses a single stack with an arbitrary, but constant maximum size. Values on the stack are bytes represented by two hex digits
Any non-recognized instructions are ignored, allowing for inline comments anywhere in your program

## Writing Code in BS
Code written in BS is very compact. Here's BS's equivalent of the classic Hello World program to demonstrate:
`#03#0f~.. prints 03 and 0f to the screen`

## Style Guide
There are two acceptable styles for writing BS:
* No whitespace/comments (only instructions)
* A newline after every instruction
For the first style, comments are acceptable after the bulk of the program but not reccomended
The extension for BS sources files is `.bs`

## How to Build
The interpreter hosted in this repository is written in the Odin programming language
To build the binary, in the project directory run `odin build bs.odin`
This will produce a binary called `bs`
To run BS, call the binary with one argument, the name of the source file
The `tests` folder contains three example programs for learning

## FAQ
### Is BS Turing complete?
No, but nothing is so I wouldn't worry too much
### How hard is it to write BS?
It takes some time and dedication, but with some practice you'll learn it's not too hard
### Will you write any tooling for BS?
Maybe eventually, but BS is simple enough that tooling isn't really needed
Most people can write it unaided

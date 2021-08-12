package brainstack;

import "core:fmt";
import "core:os";

MAX_STACK_SIZE :: 32;

// This assumes the hex digit is 2 digits (1 byte)
parse_hex_digit :: proc(val: []u8)-> u8 {
	out: u8 = 0;
	place: u8 = 0x10;
	for digit in val {
		if digit >= '0' && digit <= '9' {
			out += place * (digit - '0');
		} else if digit >= 'a' && digit <= 'f' {
			out += place * (digit - 'a' + 10);
		} else if digit >= 'A' && digit <= 'F' {
			out += place * (digit - 'A' + 10);
		}
		place = 1;
	}
	return out;
}

Byte_Stack :: struct {
	bytes: [MAX_STACK_SIZE]u8,
	pointer: int,
};

stack_push :: proc(using stack: ^Byte_Stack, val: u8) {
	bytes[pointer] = val;
	pointer += 1;
}

stack_pop :: proc(using stack: ^Byte_Stack) -> u8 {
	pointer -= 1;
	val := bytes[pointer];	
	return val;
}

Interpreter :: struct {
	data: Byte_Stack,
	program: []u8,
};

interpreter_load_program :: proc(using interpreter: ^Interpreter, file: string) -> (ok: bool) {
	program, ok = os.read_entire_file(file); 
	return;
};

interpreter_run :: proc(using interpreter: ^Interpreter) {
	for i := 0; i < len(program); i += 1 {
		instruction := program[i];
		switch instruction {
		case '#':
			stack_push(&data, parse_hex_digit(program[i + 1:i + 3]));
			i += 2;
		case '.': fmt.printf("%X\n", stack_pop(&data));
		case ':': 
			val := stack_pop(&data);
			stack_push(&data, val); stack_push(&data, val);
		case '~':
			val1 := stack_pop(&data);
			val2 := stack_pop(&data);
			stack_push(&data, val1);
			stack_push(&data, val2);
		case '+':
			val1, val2 := stack_pop(&data), stack_pop(&data);
			stack_push(&data, val2 + val1);
		case '-':
			val1, val2 := stack_pop(&data), stack_pop(&data);
			stack_push(&data, val2 - val1);
		case '[':
			val := stack_pop(&data);
			stack_push(&data, val);
			if val == 0 {
				bracket_count := 1;
				for bracket_count != 0 {
					i += 1;
					switch program[i] {
					case '[': bracket_count += 1;
					case ']': bracket_count -= 1;
					}
				}
			}
		case ']':
			val := stack_pop(&data);
			stack_push(&data, val);
			if val != 0 {
				bracket_count := -1;
				for bracket_count != 0 {
					i -= 1;
					switch program[i] {
					case '[': bracket_count += 1;
					case ']': bracket_count -= 1;
					}
				}
			}
		}
	}
};

main :: proc() {
	if len(os.args) != 2 {
		fmt.println("usage: ./bs PROGRAM");
	}
	interpreter: Interpreter;
	if !(interpreter_load_program(&interpreter, os.args[1])) {
		fmt.println("file does not exist");
	}
	interpreter_run(&interpreter);
}

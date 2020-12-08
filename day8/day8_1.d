#!/usr/bin/env rdmd

import std;

void main() {
	int acc, idx;
	auto debugger = stdin.byLine()
		.map!(i => i.split(" ").to!(string[]))
		.map!(i => tuple(i.front, i.back.to!int, size_t.init))
		.array;
	typeof(debugger.front)* cur;
	while(!(*(cur = &debugger[idx]))[2]) {
		(*cur)[2]++;
		final switch((*cur)[0]) {
			case "jmp": idx+=(*cur)[1]; break;
			case "acc": acc+=(*cur)[1]; goto case;
			case "nop": idx++; break;
		}
	}
	acc.writeln;
}

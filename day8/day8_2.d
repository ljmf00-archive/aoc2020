#!/usr/bin/env rdmd

import std;

void main() {
	int valid; size_t swpidx;
	auto debugger = stdin.byLine()
		.map!(i => i.split(" ").to!(string[]))
		.map!(i => tuple(i.front, i.back.to!int, size_t.init))
		.array;
	typeof(debugger) dupdbg;
	int execute(typeof(debugger) dbg) {
		int acc, idx;
		typeof(dbg.front)* cur;
		while(!(*(cur = &dbg[idx]))[2]) {
			(*cur)[2]++;
			final switch((*cur)[0]) {
				case "jmp": idx+=(*cur)[1]; break;
				case "acc": acc+=(*cur)[1]; goto case;
				case "nop": idx++; break;
			}
			if(idx >= dbg.length) return acc;
		}
		return int.min;
	}
	do {
		dupdbg = debugger.dup;
		swpidx += dupdbg[swpidx..$].countUntil!(i => i[0] == "jmp" || i[0] == "nop");
		dupdbg[swpidx][0] = (dupdbg[swpidx][0] == "jmp") ? "nop" : "jmp";
		swpidx++;
	} while((valid = execute(dupdbg)) == int.min);
	valid.writeln;
}

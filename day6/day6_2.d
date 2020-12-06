#!/usr/bin/env rdmd

import std;

void main() {
	stdin.byLine()
		.map!(to!string)
		.array.splitter([])
		.map!(a => a.join.array
			.sort.group
			.filter!(b => b[1] == a.length)
			.walkLength)
		.sum.writeln;
}

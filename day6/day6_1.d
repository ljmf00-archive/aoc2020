#!/usr/bin/env rdmd

import std;

void main() {
	stdin.byLine()
		.map!(to!string)
		.array.splitter([])
		.map!"a.join.array.sort.uniq.count"
		.sum.writeln;
}

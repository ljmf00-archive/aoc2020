#!/usr/bin/env rdmd

import std;

void main() {
	auto bsp(Tuple!(uint, "lo", uint, "hi") a, dchar b) {
		auto val = cast(uint)ceil((a.hi - a.lo) / 2.0);
		(b == 'F' || b == 'L') ? (a.hi -= val) : (a.lo += val);
		return a;
	}
	stdin.byLine()
		.map!(s =>
			  reduce!(bsp)(tuple!("lo", "hi")(0U, 127U), s[0..7]).hi * 8
			+ reduce!(bsp)(tuple!("lo", "hi")(0U, 7U), s[7..10]).hi)
		.maxElement
		.writeln;
}

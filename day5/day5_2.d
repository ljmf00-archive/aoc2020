#!/usr/bin/env rdmd

import std;

void main() {
	immutable seat_nr = 128 * 8;
	auto bsp(Tuple!(uint, "lo", uint, "hi") a, dchar b) {
		auto val = cast(uint)ceil((a.hi - a.lo) / 2.0);
		(b == 'F' || b == 'L') ? (a.hi -= val) : (a.lo += val);
		return a;
	}
	auto seats = stdin.byLine()
		.map!(s =>
			  reduce!(bsp)(tuple!("lo", "hi")(0U, 127U), s[0..7]).hi * 8
			+ reduce!(bsp)(tuple!("lo", "hi")(0U, 7U), s[7..10]).hi)
		.array.sort;

	setDifference(iota(1, seat_nr), seats)
	.enumerate.filter!"a.index + 1 != a.value"
	.front.value.writeln;
}

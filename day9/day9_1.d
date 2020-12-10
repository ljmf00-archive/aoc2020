#!/usr/bin/env rdmd

import std;

void main() {
	auto num_stream = stdin.byLine().map!(i => i.to!size_t);
	num_stream.cumulativeFold!((a,b) => tuple(
			cartesianProduct(a[1], a[1])
				.filter!(a => a[0] != a[1] && (a[0] + a[1]) == b)
				.take(1).array.length != 0,
			a[1][1..$] ~ b))(tuple(true, num_stream.take(25).array))
	.filter!"a[0] == false"
	.front[1].back.writeln;
}

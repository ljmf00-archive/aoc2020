#!/usr/bin/env rdmd

import std;

void main() {
	auto num_arr = stdin.byLine().map!(i => i.to!size_t).array;
	auto invalid = num_arr[26..$].cumulativeFold!((a,b) => tuple(
			cartesianProduct(a[1], a[1])
				.filter!(a => a[0] != a[1] && (a[0] + a[1]) == b)
				.take(1).array.length != 0,
			a[1][1..$] ~ b))(tuple(true, num_arr[0..26]))
		.filter!"a[0] == false"
		.front[1].back;
	iota(0, num_arr.length).map!(i => num_arr[i..$].cumulativeFold!"a ~ b"(size_t[].init)
			.map!((vals){
				auto nsum = vals.sum;
				if(nsum > invalid) return nullable!size_t(0);
				if(nsum == invalid) return nullable(vals.minElement + vals.maxElement);
				return Nullable!(size_t).init;
			}).until!"!a.isNull && a.get == 0"
		).joiner.filter!"!a.isNull".front.writeln;
}

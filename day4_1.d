#!/usr/bin/env rdmd

import std;

void main(string[] args)
{
	stdin.byLine()
		.map!(i => i.split(" ").to!(string[]))
		.array.splitter([])
		.map!((p) {
			return p.join.map!((e) {
				auto pair = e.split(":");
				return tuple(pair.front, pair.back);
			}).assocArray;
		})
		.filter!`"byr" in a`
		.filter!`"iyr" in a`
		.filter!`"eyr" in a`
		.filter!`"hgt" in a`
		.filter!`"hcl" in a`
		.filter!`"ecl" in a`
		.filter!`"pid" in a`
		.count
		.writeln;
}

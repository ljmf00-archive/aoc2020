#!/usr/bin/env rdmd

import std;

void main() {
	auto bags = stdin.byLine()
		.map!(r => r.split(" bags contain ").to!(string[]))
		.map!((r) {
			auto bag = r.front;
			auto bags = r.back
				.splitter(", ")
				.filter!(b => !b.startsWith("no "))
				.map!(b => b.split(" ")[0..$-1].join(" "))
				.map!((b){
					size_t num; string bags;
					b.formattedRead!"%d %s"(num, bags);
					return tuple(num, bags);
				})
				.array;
			return tuple(bag.idup, bags);
		}).assocArray;
	size_t recurseContains(string bag) {
		return reduce!((a,b) => a + b[0] + b[0] * recurseContains(b[1]))
			(cast(size_t)0U, (bag in bags) ? bags[bag] : []);
	}
	recurseContains("shiny gold").writeln;
}

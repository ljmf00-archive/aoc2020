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
		}).array;

	auto _bags = bags.assocArray;
	bool recurseContains(string bag) {
		auto cbags = _bags[bag].map!"a[1]";
		return cbags.canFind("shiny gold") || cbags.any!recurseContains;
	}
	writefln("First approach: %d", _bags.keys.map!recurseContains.sum);

	string[][string] reverse_bags;
	bags.each!(b => b[1].each!(c => reverse_bags[c[1]] ~= b[0]));
	auto queue = DList!string(["shiny gold"]);
	string[] visited;
	while(!queue.empty) {
		auto f = queue.front();
		queue.removeFront();
		if(f in reverse_bags)
			foreach(bag; reverse_bags[f])
				if(!canFind(visited, bag)) {
					queue.insertBack(bag);
					visited ~= bag;
				}
	}
	writefln("Second approach (overcomplicated): %d", visited.length);
}

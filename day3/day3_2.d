#!/usr/bin/env rdmd

import std.string;
import std.stdio;
import std.algorithm;
import std.typecons;
import std.format;
import std.array;
import std.range;

size_t countTrees(Cycle!(bool[])[] infmap, size_t right, size_t down)
{
	size_t rowidx, idx, counter;
	while(rowidx < infmap.length - 1)
	{
		if(infmap[rowidx+=down][idx+=right])
			counter++;
	}

	return counter;
}

int main(string[] args)
{
	// create the infinite map
	auto infmap = stdin.byLine()
		.map!(
			map!((c) {
				final switch(c)
				{
					case '.': return false;
					case '#': return true;
				}
			})
		)
		.map!(m => cycle(m.array))
		.array;

	size_t counter = 1;
	counter *= countTrees(infmap, 1, 1);
	counter *= countTrees(infmap, 3, 1);
	counter *= countTrees(infmap, 5, 1);
	counter *= countTrees(infmap, 7, 1);
	counter *= countTrees(infmap, 1, 2);

	writeln(counter);

	return 0;
}

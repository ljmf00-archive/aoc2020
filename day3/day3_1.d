#!/usr/bin/env rdmd

import std.string;
import std.stdio;
import std.algorithm;
import std.typecons;
import std.format;
import std.array;
import std.range;


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

	size_t rowidx, idx, counter;
	while(rowidx < infmap.length - 1)
	{
		if(infmap[rowidx+=1][idx+=3])
			counter++;
	}

	counter.writeln;

	return 0;
}

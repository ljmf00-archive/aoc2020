#!/usr/bin/env rdmd

import std.stdio;
import std.conv;
import std.array;
import std.string;
import std.algorithm;
import std.typecons;
import std.range;

int main(string[] args)
{
	auto numbers = stdin.byLine()
		.map!(to!uint)
		.filter!"a <= 2020"
		.array;

	// this is not an optimal solution but it works for 
	// the given dataset.
	auto res = cartesianProduct(numbers, numbers)
		.filter!"a[0] != a[1]"
		.filter!(n => sum([n.expand]) == 2020)
		.map!(n => reduce!"a * b"(1, n));

	writeln(res.front);

	return 0;
}
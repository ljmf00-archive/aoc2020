#!/usr/bin/env rdmd

import std.stdio;
import std.file;
import std.process;
import std.array;
import std.algorithm;
import std.typecons;
import std.format;
import std.string;
import std.conv : to;

int main(string[] args)
{
	auto executor = delegate(Tuple!(string,"day", string, "part") day, bool example) {
		auto exec = executeShell(
			(example)
				? format!"cat day%1$s_%2$s.in.example | ./day%1$s_%2$s.d"(day.day, day.part)
				: format!"cat day%1$s_%2$s.in | ./day%1$s_%2$s.d"(day.day, day.part)
		);
	
		if(exec.status != 0)
			stderr.writefln("Error on day %s part %s", day.day, day.part);
	
		return exec;
	};

	auto days = dirEntries("","*.d",SpanMode.depth)
		.filter!(d => d.name != "build.d")
		.map!"a.name"
		.map!((d) {
			auto signature = d.split("day")[1].split(".")[0];
			auto day = signature.split("_")[0];
			auto part = signature.split("_")[1];

			return tuple!("day", "part")(day, part);
		});

	if(args[1..$].length)
	{
		if(args[1..$].length != 3)
			return 1;
			
		auto exec = executor(tuple!("day", "part")(args[1], args[2]), args[3].to!bool);
		exec.output.write;
		return 0;
	}
		
	foreach(d; days)
	{
		Tuple!(int,"status",string,"output") exec;
		if((exec = executor(d, false)).status == 0) writefln("Day %s Part %s: %s", d.day, d.part, exec.output.chomp);
		if((exec = executor(d, true)).status == 0) writefln("Day %s Part %s (example): %s", d.day, d.part, exec.output.chomp);
	}

	return 0;
}
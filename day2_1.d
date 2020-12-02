#!/usr/bin/env rdmd

import std.string;
import std.stdio;
import std.algorithm;
import std.typecons;
import std.format;
import std.array;

alias Policy = Tuple!(size_t, "min", size_t, "max", string, "ch");

struct Password {
	Policy policy;
	string password;
}

int main(string[] args)
{
	auto pws = stdin.byLine()
		.map!((l) {
			Password pw;
			l.formattedRead!"%s-%s %s: %s"
				(pw.policy.min, pw.policy.max, pw.policy.ch, pw.password);

			return pw;
		})
		.filter!((p) {
			auto c = count(p.password, p.policy.ch);
			return c <= p.policy.max && c >= p.policy.min;
		})
		.array;

		writeln(pws.length);

	return 0;
}
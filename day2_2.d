#!/usr/bin/env rdmd

import std.string;
import std.stdio;
import std.algorithm;
import std.typecons;
import std.format;
import std.array;

alias Policy = Tuple!(size_t, "first", size_t, "second", string, "ch");

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
				(pw.policy.first, pw.policy.second, pw.policy.ch, pw.password);

			return pw;
		})
		.filter!"(a.password[a.policy.first - 1] == a.policy.ch[0]) ^ (a.password[a.policy.second - 1] == a.policy.ch[0])"
		.array;

		writeln(pws.length);

	return 0;
}

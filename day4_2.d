#!/usr/bin/env rdmd

import std;

void main() {
	bool validateYear(string val, int lo, int hi) {
		if(val.length != 4 || !val.isNumeric) return false;
		auto ival = val.to!int;
		return ival.clamp(lo, hi) == ival;
	}

	bool validateHeight(string val) {
		bool validateCmIn(string _val, int lo, int hi) {
			if(! _val.isNumeric) return false;
			auto ival = _val.to!int;
			return ival.clamp(lo, hi) == ival;
		}

		if(val.endsWith("cm"))
			return validateCmIn(val.split("cm").front, 150, 193);
		else if (val.endsWith("in"))
			return validateCmIn(val.split("in").front, 59, 76);
	
		return false;
	}

	stdin.byLine()
		.map!(i => i.split(" ").to!(string[]))
		.array.splitter([])
		.map!((p) {
			return p.join.map!((e) {
				auto pair = e.split(":");
				return tuple(pair.front, pair.back);
			}).assocArray;
		})
		.filter!(a => "byr" in a && validateYear(a["byr"], 1920, 2002))
		.filter!(a => "iyr" in a && validateYear(a["iyr"], 2010, 2020))
		.filter!(a => "eyr" in a && validateYear(a["eyr"], 2020, 2030))
		.filter!(a => "hgt" in a && validateHeight(a["hgt"]))
		.filter!(a => "hcl" in a && !matchFirst(a["hcl"], ctRegex!`^#([a-f0-9]{6})$`).empty)
		.filter!(a => "ecl" in a && ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].canFind(a["ecl"]))
		.filter!(a => "pid" in a && a["pid"].length == 9 && a["pid"].isNumeric)
		.count
		.writeln;
}

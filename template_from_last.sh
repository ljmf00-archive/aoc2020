#!/usr/bin/env bash

[ -z ${AOC_COOKIE+x} ] && exit 0

LAST_DAY_N="$(find . -type d -name 'day*' | wc -l)"

DAY_INPUT=$(curl -s --cookie "session=$AOC_COOKIE" "https://adventofcode.com/2020/day/$((LAST_DAY_N + 1))/input")

cp -r "day$LAST_DAY_N" "day$((LAST_DAY_N + 1))"
(cd "day$((LAST_DAY_N + 1))" || exit
	for f in $(find . -mindepth 1 -maxdepth 1 -type f); do
		NEW_F="day$((LAST_DAY_N + 1))_$(echo "$f" | cut -d'_' -f 2)"
		if [[ "$f" == *.in* ]]; then
			echo "$DAY_INPUT" > "$NEW_F"
			rm "$f"
		else
			mv "$f" "$NEW_F"
		fi
	done
)

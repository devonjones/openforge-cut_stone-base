#!/bin/bash

: ${OPENSCAD:="openscad"}
: ${CONVERTSTL:="../../../../openforge/bin/convertSTL.rb"}

for x in {1..4}
do
	for y in {1..4}
	do
		$OPENSCAD -o cut_stone_full_base.${x}x${y}.curved.convex.internal.stl \
				-D "x=$x" -D "y=$y" \
				../cut_stone_full_base.curved.convex.scad
		$CONVERTSTL cut_stone_full_base.${x}x${y}.curved.convex.internal.stl
		mv cut_stone_full_base.${x}x${y}.curved.convex.internal-binary.stl cut_stone_full_base.${x}x${y}.curved.convex.internal.stl
	done
done


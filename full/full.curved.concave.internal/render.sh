#!/bin/bash

: ${OPENSCAD:="openscad"}
: ${CONVERTSTL:="../../../../openforge/bin/convertSTL.rb"}

for x in {1..4}
do
	for y in {1..4}
	do
		$OPENSCAD -o cut_stone_full_base.${x}x${y}.curved.concave.internal.stl \
				-D "x=$x" -D "y=$y" \
				../cut_stone_full_base.curved.concave.scad
		$CONVERTSTL cut_stone_full_base.${x}x${y}.curved.concave.internal.stl
		mv cut_stone_full_base.${x}x${y}.curved.concave.internal-binary.stl cut_stone_full_base.${x}x${y}.curved.concave.internal.stl
	done
done


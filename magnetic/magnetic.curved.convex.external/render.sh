#!/bin/bash

: ${OPENSCAD:="openscad"}
: ${CONVERTSTL:="../../../../openforge/bin/convertSTL.rb"}

for x in {1..4}
do
	for y in {1..4}
	do
		$OPENSCAD -o cut_stone_curved_convex_magnetic_base.${x}x${y}.external.stl \
				-D "x=$x" -D "y=$y" -D 'edge="true"' \
				../cut_stone_magnetic_base.curved.convex.scad
		$CONVERTSTL cut_stone_curved_convex_magnetic_base.${x}x${y}.external.stl
		mv cut_stone_curved_convex_magnetic_base.${x}x${y}.external-binary.stl cut_stone_curved_convex_magnetic_base.${x}x${y}.external.stl
	done
done


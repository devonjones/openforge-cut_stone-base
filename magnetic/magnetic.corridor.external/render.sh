#!/bin/bash

: ${OPENSCAD:="openscad"}
: ${CONVERTSTL:="../../../../openforge/bin/convertSTL.rb"}

for x in {1..4}
do
	for y in {1..4}
	do
		$OPENSCAD -o cut_stone_magnetic_base.${x}x${y}.corridor.external.stl \
				-D "x=$x" -D "y=$y" -D 'back_edge="true"' -D 'front_edge="true"' \
				../cut_stone_magnetic_base.square.scad
		$CONVERTSTL cut_stone_magnetic_base.${x}x${y}.corridor.external.stl
		mv cut_stone_magnetic_base.${x}x${y}.corridor.external-binary.stl cut_stone_magnetic_base.${x}x${y}.corridor.external.stl
	done
done


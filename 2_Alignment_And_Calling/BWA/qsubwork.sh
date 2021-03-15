#!/bin/sh
for name in RPG_BLD5 RPG_BLD6 RPG_BLD7 RPG_BLD8 RPG_LCL5 RPG_LCL6 RPG_LCL7 RPG_LCL8;do
qsub $name.sh
done

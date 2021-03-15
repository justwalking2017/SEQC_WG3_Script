#!/bin/sh
for name in BL5 BL6 BL7 BL8 LCL5 LCL6 LCL7 LCL8;do
qsub $name.sh
done

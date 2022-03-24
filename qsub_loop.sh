#!/bin/bash

for dir_num in {733..734}
do
	qsub -N sigfig${dir_num} ./reduce_sigfig.sh -- /g/data/ik11/outputs/access-om2-01/01deg_jra55v140_iaf_cycle4/output${dir_num}/ocean
done

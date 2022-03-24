#!/bin/bash

for num_dir in {733..734}
do
	vi reduce_sigfig.sh -c ":%s/num_dir=.*/num_dir=${num_dir}/" -c ":wq"
	qsub reduce_sigfig.sh
done

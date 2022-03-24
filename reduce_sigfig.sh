#!/bin/bash
 
#PBS -l ncpus=1
#PBS -l mem=12GB
#PBS -q normal
#PBS -l walltime=00:30:00
#PBS -l storage=gdata/ik11+scratch/v45+scratch/x77
#PBS -l wd

lev_comp=5
num_dir=734
path_ocean=/g/data/ik11/outputs/access-om2-01/01deg_jra55v140_iaf_cycle4/output${num_dir}/ocean

for path_file in ${path_ocean}/oceanbgc-[2,3]d-*.nc
do
	name_file="${path_file##*/}"
	trim_front="${name_file##oceanbgc-[2,3]d-}"
	#Trim back to get variable name
	name_var="${trim_front%%-*}"
	#Initialise ppc to zero to avoid potential error.
	ppc=0

	#Set the sig fig according to the variable name

	#ppc=4 for adic,dic,alk,o2
	if [ "${name_var}" == "adic" ] || [ "${name_var}" == "dic" ] || [ "${name_var}" == "alk" ] || [ "${name_var}" == "o2" ]
	then
		ppc=4
	elif [ "${name_var}" == "no3" ] || [ "${name_var}" == "fe" ] || [ "${name_var}" == "phy" ] || [ "${name_var}" == "zoo" ] || [ "${name_var}" == "det" ] || [ "${name_var}" == "caco3" ]
	then
		ppc=3
	elif [ "${name_var}" == "stf03" ] || [ "${name_var}" == "stf07" ] || [ "${name_var}" == "stf09" ]
	then
		ppc=4
	elif [ "${name_var}" == "npp2d" ] || [ "${name_var}" == "pprod_gross_2d" ] || [ "${name_var}" == "wdet100" ]
	then
		ppc=3
	fi
	ncks -O -7 -L ${lev_comp} --baa=4 --ppc default=${ppc} ${path_file} ./bit_groomed_${name_file}
done

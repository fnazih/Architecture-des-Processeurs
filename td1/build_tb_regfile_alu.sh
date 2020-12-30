#! /bin/bash
files_list=(alu_constants.vhd \
		basic_comps.vhd \
		register_file.vhd \
		alu.vhd \
		top_regfile_alu.vhd \
		../tb/regfile_alu_tb.vhd
		)

if [ -d ./libs/work ]
then
    vdel -lib ./libs/work/ -all
    vlib ./libs/work
else
    vlib ./libs/work
fi
vmap work ./libs/work 

for file in ${files_list[*]} ; do
    echo "compiling : " $file

    vcom -2008 -work work ./src/$file  

done

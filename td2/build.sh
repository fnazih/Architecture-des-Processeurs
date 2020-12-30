#! /bin/sh
files_list=(RV32I_constants.vhd \
		RV32I_components.vhd \
		sync_mem.vhd \
		register_file.vhd \
		alu.vhd \
		RV32I_Monocycle_datapath.vhd \
		RV32I_Monocycle_controlpath.vhd \
		RV32I_Monocycle_top.vhd \
		../tb/RV32I_tb.vhd)

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
    if [ $file!="sync_mem.vhd" ]
    then
       vcom -2008 -work work ./src/$file
    else
	vcom -93 -work work ./src/$file  
    fi
done

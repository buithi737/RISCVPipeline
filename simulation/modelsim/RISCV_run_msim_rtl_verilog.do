transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/RISCV/RISCV_Pipeline_Core/RISCV_Build {D:/RISCV/RISCV_Pipeline_Core/RISCV_Build/Mux.v}
vlog -vlog01compat -work work +incdir+D:/RISCV/RISCV_Pipeline_Core/RISCV_Build {D:/RISCV/RISCV_Pipeline_Core/RISCV_Build/PC_Module.v}
vlog -vlog01compat -work work +incdir+D:/RISCV/RISCV_Pipeline_Core/RISCV_Build {D:/RISCV/RISCV_Pipeline_Core/RISCV_Build/PC_Adder.v}
vlog -vlog01compat -work work +incdir+D:/RISCV/RISCV_Pipeline_Core/RISCV_Build {D:/RISCV/RISCV_Pipeline_Core/RISCV_Build/IMem.v}
vlog -vlog01compat -work work +incdir+D:/RISCV/RISCV_Pipeline_Core/RISCV_Build {D:/RISCV/RISCV_Pipeline_Core/RISCV_Build/Fetch_Cycle.v}

vlog -vlog01compat -work work +incdir+D:/RISCV/RISCV_Pipeline_Core/RISCV_Build {D:/RISCV/RISCV_Pipeline_Core/RISCV_Build/Fetch_Cycle_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver -L rtl_work -L work -voptargs="+acc"  Fetch_Cycle_tb

add wave *
view structure
view signals
run -all

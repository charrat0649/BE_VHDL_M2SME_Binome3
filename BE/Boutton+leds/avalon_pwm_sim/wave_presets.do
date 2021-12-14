# Display signals from module cpu_0
add wave -noupdate -divider {cpu_0}
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_cpu_0/d_irq
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_cpu_0/d_waitrequest
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_cpu_0/d_address
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_cpu_0/d_byteenable
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_cpu_0/d_read
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_cpu_0/d_readdata
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_cpu_0/d_write
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_cpu_0/d_writedata
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_cpu_0/i_waitrequest
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_cpu_0/i_address
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_cpu_0/i_read
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_cpu_0/i_readdata
add wave -noupdate -divider {common}
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_cpu_0/clk
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_cpu_0/reset_n
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_cpu_0/F_pcb_nxt
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_cpu_0/F_pcb
add wave -noupdate -format Logic -radix ascii /test_bench/DUT/the_cpu_0/F_vinst
add wave -noupdate -format Logic -radix ascii /test_bench/DUT/the_cpu_0/D_vinst
add wave -noupdate -format Logic -radix ascii /test_bench/DUT/the_cpu_0/R_vinst
add wave -noupdate -format Logic -radix ascii /test_bench/DUT/the_cpu_0/E_vinst
add wave -noupdate -format Logic -radix ascii /test_bench/DUT/the_cpu_0/W_vinst
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_cpu_0/F_valid
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_cpu_0/D_valid
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_cpu_0/R_valid
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_cpu_0/E_valid
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_cpu_0/W_valid
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_cpu_0/D_wr_dst_reg
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_cpu_0/D_dst_regnum
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_cpu_0/W_wr_data
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_cpu_0/F_iw
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_cpu_0/D_iw
add wave -noupdate -divider {breaks}
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_cpu_0/hbreak_req
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_cpu_0/oci_hbreak_req
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_cpu_0/hbreak_enabled
add wave -noupdate -format Logic -radix hexadecimal /test_bench/DUT/the_cpu_0/wait_for_one_post_bret_inst


# Display signals from module jtag_uart_0
add wave -noupdate -divider {jtag_uart_0}
add wave -noupdate -format Literal -radix hexadecimal /test_bench/DUT/the_jtag_uart_0/av_address
add wave -noupdate -format Logic /test_bench/DUT/the_jtag_uart_0/av_chipselect
add wave -noupdate -format Logic /test_bench/DUT/the_jtag_uart_0/av_irq
add wave -noupdate -format Logic /test_bench/DUT/the_jtag_uart_0/av_read_n
add wave -noupdate -format Literal -radix hexadecimal /test_bench/DUT/the_jtag_uart_0/av_readdata
add wave -noupdate -format Logic /test_bench/DUT/the_jtag_uart_0/av_waitrequest
add wave -noupdate -format Logic /test_bench/DUT/the_jtag_uart_0/av_write_n
add wave -noupdate -format Literal -radix hexadecimal /test_bench/DUT/the_jtag_uart_0/av_writedata
add wave -noupdate -format Logic /test_bench/DUT/the_jtag_uart_0/dataavailable
add wave -noupdate -format Logic /test_bench/DUT/the_jtag_uart_0/readyfordata


# Display signals from module onchip_memory2_0
add wave -noupdate -divider {onchip_memory2_0}
add wave -noupdate -format Logic /test_bench/DUT/the_onchip_memory2_0/chipselect
add wave -noupdate -format Logic /test_bench/DUT/the_onchip_memory2_0/write
add wave -noupdate -format Literal -radix hexadecimal /test_bench/DUT/the_onchip_memory2_0/address
add wave -noupdate -format Literal -radix binary /test_bench/DUT/the_onchip_memory2_0/byteenable
add wave -noupdate -format Literal -radix hexadecimal /test_bench/DUT/the_onchip_memory2_0/readdata
add wave -noupdate -format Literal -radix hexadecimal /test_bench/DUT/the_onchip_memory2_0/writedata


configure wave -justifyvalue right
configure wave -signalnamewidth 1
TreeUpdate [SetDefaultTree]
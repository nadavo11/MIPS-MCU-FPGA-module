onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /tb_top/U_0/PC
add wave -noupdate -itemcolor Yellow -radix hexadecimal /tb_top/U_0/Instruction
add wave -noupdate -group TOP /tb_top/U_0/reset
add wave -noupdate -group TOP /tb_top/U_0/clock
add wave -noupdate -group TOP /tb_top/U_0/PORT_LEDG
add wave -noupdate -group TOP /tb_top/U_0/PORT_LEDR
add wave -noupdate -group TOP /tb_top/U_0/PORT_HEX0
add wave -noupdate -group TOP /tb_top/U_0/PORT_HEX1
add wave -noupdate -group TOP /tb_top/U_0/PORT_HEX2
add wave -noupdate -group TOP /tb_top/U_0/PORT_HEX3
add wave -noupdate -group TOP /tb_top/U_0/PORT_SW
add wave -noupdate -group TOP /tb_top/U_0/PORT_KEY
add wave -noupdate -group TOP /tb_top/U_0/rst
add wave -noupdate -group TOP -radix decimal /tb_top/U_0/ALU_result
add wave -noupdate -group TOP -radix decimal /tb_top/U_0/read_data_1
add wave -noupdate -group TOP -radix decimal /tb_top/U_0/read_data_2
add wave -noupdate -group TOP -itemcolor Yellow -radix hexadecimal /tb_top/U_0/Instruction
add wave -noupdate -group TOP -radix decimal /tb_top/U_0/PC
add wave -noupdate -group TOP -radix decimal /tb_top/U_0/Add_result
add wave -noupdate -group TOP /tb_top/U_0/Branch
add wave -noupdate -group TOP /tb_top/U_0/Zero
add wave -noupdate -group TOP /tb_top/U_0/MemWrite
add wave -noupdate -group TOP /tb_top/U_0/RegWrite
add wave -noupdate -group TOP -radix hexadecimal /tb_top/U_0/address
add wave -noupdate -group TOP -itemcolor Cyan /tb_top/U_0/INTR
add wave -noupdate -group TOP /tb_top/U_0/ITYPE
add wave -noupdate -group TOP /tb_top/U_0/BT_en
add wave -noupdate -group TOP /tb_top/U_0/BTI_ACK
add wave -noupdate -group TOP /tb_top/U_0/MEM_ACCESS
add wave -noupdate -group TOP /tb_top/U_0/MEM_WR_EN
add wave -noupdate -group TOP /tb_top/U_0/interrupt_REG
add wave -noupdate -group TOP /tb_top/U_0/flags
add wave -noupdate -group TOP /tb_top/U_0/IFG
add wave -noupdate -group TOP /tb_top/U_0/ACK
add wave -noupdate -group TOP /tb_top/U_0/IRQ
add wave -noupdate -group TOP /tb_top/U_0/IE
add wave -noupdate -group TOP -itemcolor Violet /tb_top/U_0/IO_ACCESS
add wave -noupdate -group TOP -radix hexadecimal /tb_top/U_0/IO_ADDRESS
add wave -noupdate -group TOP -radix hexadecimal /tb_top/U_0/write_data
add wave -noupdate -group TOP -radix hexadecimal /tb_top/U_0/READ_DATA
add wave -noupdate -group TOP -itemcolor Violet /tb_top/U_0/IO_WRITE
add wave -noupdate -group TOP -itemcolor Violet /tb_top/U_0/IO_READ
add wave -noupdate -group TOP /tb_top/U_0/switches
add wave -noupdate -group TOP /tb_top/U_0/keys
add wave -noupdate -group TOP /tb_top/U_0/write_clock
add wave -noupdate -group TOP /tb_top/U_0/IO_registers
add wave -noupdate -group MIPS /tb_top/U_0/MIPS_CORE/reset
add wave -noupdate -group MIPS /tb_top/U_0/MIPS_CORE/clock
add wave -noupdate -group MIPS -radix decimal /tb_top/U_0/MIPS_CORE/PC
add wave -noupdate -group MIPS -radix decimal /tb_top/U_0/MIPS_CORE/address_out
add wave -noupdate -group MIPS -radix decimal /tb_top/U_0/MIPS_CORE/ALU_result_out
add wave -noupdate -group MIPS -radix decimal /tb_top/U_0/MIPS_CORE/read_data_1_out
add wave -noupdate -group MIPS -radix decimal /tb_top/U_0/MIPS_CORE/read_data_2_out
add wave -noupdate -group MIPS -radix decimal /tb_top/U_0/MIPS_CORE/write_data_out
add wave -noupdate -group MIPS -radix hexadecimal /tb_top/U_0/MIPS_CORE/Instruction_out
add wave -noupdate -group MIPS -radix decimal /tb_top/U_0/MIPS_CORE/read_data_in
add wave -noupdate -group MIPS /tb_top/U_0/MIPS_CORE/Branch_out
add wave -noupdate -group MIPS /tb_top/U_0/MIPS_CORE/Zero_out
add wave -noupdate -group MIPS /tb_top/U_0/MIPS_CORE/Memwrite_out
add wave -noupdate -group MIPS /tb_top/U_0/MIPS_CORE/Regwrite_out
add wave -noupdate -group MIPS -itemcolor Cyan /tb_top/U_0/MIPS_CORE/INTR
add wave -noupdate -group MIPS /tb_top/U_0/MIPS_CORE/ITYPE
add wave -noupdate -group MIPS -radix decimal /tb_top/U_0/MIPS_CORE/PC_plus_4
add wave -noupdate -group MIPS -radix decimal /tb_top/U_0/MIPS_CORE/read_data_1
add wave -noupdate -group MIPS -radix decimal /tb_top/U_0/MIPS_CORE/read_data_2
add wave -noupdate -group MIPS -radix decimal /tb_top/U_0/MIPS_CORE/Sign_Extend
add wave -noupdate -group MIPS -radix decimal /tb_top/U_0/MIPS_CORE/Add_result
add wave -noupdate -group MIPS -radix decimal /tb_top/U_0/MIPS_CORE/ALU_result
add wave -noupdate -group MIPS -radix decimal /tb_top/U_0/MIPS_CORE/read_data
add wave -noupdate -group MIPS /tb_top/U_0/MIPS_CORE/ALUSrc
add wave -noupdate -group MIPS /tb_top/U_0/MIPS_CORE/Branch
add wave -noupdate -group MIPS /tb_top/U_0/MIPS_CORE/RegDst
add wave -noupdate -group MIPS /tb_top/U_0/MIPS_CORE/Regwrite
add wave -noupdate -group MIPS /tb_top/U_0/MIPS_CORE/Zero
add wave -noupdate -group MIPS /tb_top/U_0/MIPS_CORE/MemWrite
add wave -noupdate -group MIPS /tb_top/U_0/MIPS_CORE/MemtoReg
add wave -noupdate -group MIPS /tb_top/U_0/MIPS_CORE/MemRead
add wave -noupdate -group MIPS /tb_top/U_0/MIPS_CORE/bne
add wave -noupdate -group MIPS /tb_top/U_0/MIPS_CORE/ALUop
add wave -noupdate -group MIPS -radix hexadecimal /tb_top/U_0/MIPS_CORE/Instruction
add wave -noupdate -group MIPS /tb_top/U_0/MIPS_CORE/jr
add wave -noupdate -group MIPS /tb_top/U_0/MIPS_CORE/jump
add wave -noupdate -group MIPS /tb_top/U_0/MIPS_CORE/R_format
add wave -noupdate -group MIPS /tb_top/U_0/MIPS_CORE/link
add wave -noupdate -group MIPS /tb_top/U_0/MIPS_CORE/MEM_ACCESS
add wave -noupdate -group MIPS /tb_top/U_0/MIPS_CORE/MEM_WR_EN
add wave -noupdate -group ICT /tb_top/U_0/ICT/clock
add wave -noupdate -group ICT /tb_top/U_0/ICT/reset
add wave -noupdate -group ICT -itemcolor Cyan /tb_top/U_0/ICT/INTR_out
add wave -noupdate -group ICT /tb_top/U_0/ICT/ITYPE
add wave -noupdate -group ICT /tb_top/U_0/ICT/ACK
add wave -noupdate -group ICT -radix decimal /tb_top/U_0/ICT/WR_DATA
add wave -noupdate -group ICT -radix hexadecimal /tb_top/U_0/ICT/WR_ADDRESS
add wave -noupdate -group ICT -itemcolor Cyan /tb_top/U_0/ICT/IRQ
add wave -noupdate -group ICT /tb_top/U_0/ICT/IO_WRITE
add wave -noupdate -group ICT /tb_top/U_0/ICT/IE_out
add wave -noupdate -group ICT -itemcolor Cyan /tb_top/U_0/ICT/BT_src
add wave -noupdate -group ICT /tb_top/U_0/ICT/IFG_out
add wave -noupdate -group ICT -radix hexadecimal /tb_top/U_0/ICT/IE
add wave -noupdate -group ICT -itemcolor Cyan /tb_top/U_0/ICT/IFG
add wave -noupdate -group ICT /tb_top/U_0/ICT/ITYPE_reg
add wave -noupdate -group ICT -itemcolor Cyan /tb_top/U_0/ICT/pending
add wave -noupdate -group ICT -itemcolor Cyan /tb_top/U_0/ICT/enables
add wave -noupdate -group ICT /tb_top/U_0/ICT/ITYPE_sig
add wave -noupdate -group ICT /tb_top/U_0/ICT/cnt_en_pend_down
add wave -noupdate -group ICT -radix decimal /tb_top/U_0/ICT/cnt_q
add wave -noupdate -group ICT /tb_top/U_0/ICT/cnt_en
add wave -noupdate -group TOP_TESTER /tb_top/U_1/reset
add wave -noupdate -group TOP_TESTER /tb_top/U_1/clock
add wave -noupdate -group TOP_TESTER /tb_top/U_1/PORT_LEDG
add wave -noupdate -group TOP_TESTER /tb_top/U_1/PORT_LEDR
add wave -noupdate -group TOP_TESTER /tb_top/U_1/PORT_HEX0
add wave -noupdate -group TOP_TESTER /tb_top/U_1/PORT_HEX1
add wave -noupdate -group TOP_TESTER /tb_top/U_1/PORT_HEX2
add wave -noupdate -group TOP_TESTER /tb_top/U_1/PORT_HEX3
add wave -noupdate -group TOP_TESTER /tb_top/U_1/PORT_SW
add wave -noupdate -group TOP_TESTER /tb_top/U_1/PORT_KEY
add wave -noupdate -group TOP_TESTER /tb_top/U_1/mw_U_0clk
add wave -noupdate -group TOP_TESTER /tb_top/U_1/mw_U_0disable_clk
add wave -noupdate -group TOP_TESTER /tb_top/U_1/mw_U_1pulse
add wave -noupdate -group ID /tb_top/U_0/MIPS_CORE/ID/read_data_1
add wave -noupdate -group ID /tb_top/U_0/MIPS_CORE/ID/read_data_2
add wave -noupdate -group ID -itemcolor Yellow -radix hexadecimal /tb_top/U_0/MIPS_CORE/ID/Instruction
add wave -noupdate -group ID /tb_top/U_0/MIPS_CORE/ID/read_data
add wave -noupdate -group ID /tb_top/U_0/MIPS_CORE/ID/ALU_result
add wave -noupdate -group ID /tb_top/U_0/MIPS_CORE/ID/Function_opcode
add wave -noupdate -group ID /tb_top/U_0/MIPS_CORE/ID/RegWrite
add wave -noupdate -group ID /tb_top/U_0/MIPS_CORE/ID/MemtoReg
add wave -noupdate -group ID /tb_top/U_0/MIPS_CORE/ID/RegDst
add wave -noupdate -group ID /tb_top/U_0/MIPS_CORE/ID/Sign_extend
add wave -noupdate -group ID -radix decimal /tb_top/U_0/MIPS_CORE/ID/PC_PLUS_4
add wave -noupdate -group ID /tb_top/U_0/MIPS_CORE/ID/link
add wave -noupdate -group ID /tb_top/U_0/MIPS_CORE/ID/INTR
add wave -noupdate -group ID /tb_top/U_0/MIPS_CORE/ID/clock
add wave -noupdate -group ID /tb_top/U_0/MIPS_CORE/ID/reset
add wave -noupdate -group ID -radix decimal -childformat {{/tb_top/U_0/MIPS_CORE/ID/register_array(0) -radix decimal} {/tb_top/U_0/MIPS_CORE/ID/register_array(1) -radix decimal} {/tb_top/U_0/MIPS_CORE/ID/register_array(2) -radix decimal} {/tb_top/U_0/MIPS_CORE/ID/register_array(3) -radix decimal} {/tb_top/U_0/MIPS_CORE/ID/register_array(4) -radix decimal} {/tb_top/U_0/MIPS_CORE/ID/register_array(5) -radix decimal} {/tb_top/U_0/MIPS_CORE/ID/register_array(6) -radix decimal} {/tb_top/U_0/MIPS_CORE/ID/register_array(7) -radix decimal} {/tb_top/U_0/MIPS_CORE/ID/register_array(8) -radix decimal} {/tb_top/U_0/MIPS_CORE/ID/register_array(9) -radix decimal} {/tb_top/U_0/MIPS_CORE/ID/register_array(10) -radix decimal} {/tb_top/U_0/MIPS_CORE/ID/register_array(11) -radix decimal} {/tb_top/U_0/MIPS_CORE/ID/register_array(12) -radix decimal} {/tb_top/U_0/MIPS_CORE/ID/register_array(13) -radix decimal} {/tb_top/U_0/MIPS_CORE/ID/register_array(14) -radix decimal} {/tb_top/U_0/MIPS_CORE/ID/register_array(15) -radix decimal} {/tb_top/U_0/MIPS_CORE/ID/register_array(16) -radix decimal} {/tb_top/U_0/MIPS_CORE/ID/register_array(17) -radix decimal} {/tb_top/U_0/MIPS_CORE/ID/register_array(18) -radix decimal} {/tb_top/U_0/MIPS_CORE/ID/register_array(19) -radix decimal} {/tb_top/U_0/MIPS_CORE/ID/register_array(20) -radix decimal} {/tb_top/U_0/MIPS_CORE/ID/register_array(21) -radix decimal} {/tb_top/U_0/MIPS_CORE/ID/register_array(22) -radix decimal} {/tb_top/U_0/MIPS_CORE/ID/register_array(23) -radix decimal} {/tb_top/U_0/MIPS_CORE/ID/register_array(24) -radix decimal} {/tb_top/U_0/MIPS_CORE/ID/register_array(25) -radix decimal} {/tb_top/U_0/MIPS_CORE/ID/register_array(26) -radix decimal} {/tb_top/U_0/MIPS_CORE/ID/register_array(27) -radix decimal} {/tb_top/U_0/MIPS_CORE/ID/register_array(28) -radix decimal} {/tb_top/U_0/MIPS_CORE/ID/register_array(29) -radix decimal} {/tb_top/U_0/MIPS_CORE/ID/register_array(30) -radix decimal} {/tb_top/U_0/MIPS_CORE/ID/register_array(31) -radix decimal}} -expand -subitemconfig {/tb_top/U_0/MIPS_CORE/ID/register_array(0) {-height 15 -radix decimal} /tb_top/U_0/MIPS_CORE/ID/register_array(1) {-height 15 -radix decimal} /tb_top/U_0/MIPS_CORE/ID/register_array(2) {-height 15 -radix decimal} /tb_top/U_0/MIPS_CORE/ID/register_array(3) {-height 15 -radix decimal} /tb_top/U_0/MIPS_CORE/ID/register_array(4) {-height 15 -radix decimal} /tb_top/U_0/MIPS_CORE/ID/register_array(5) {-height 15 -radix decimal} /tb_top/U_0/MIPS_CORE/ID/register_array(6) {-height 15 -radix decimal} /tb_top/U_0/MIPS_CORE/ID/register_array(7) {-height 15 -radix decimal} /tb_top/U_0/MIPS_CORE/ID/register_array(8) {-height 15 -radix decimal} /tb_top/U_0/MIPS_CORE/ID/register_array(9) {-height 15 -radix decimal} /tb_top/U_0/MIPS_CORE/ID/register_array(10) {-height 15 -radix decimal} /tb_top/U_0/MIPS_CORE/ID/register_array(11) {-height 15 -radix decimal} /tb_top/U_0/MIPS_CORE/ID/register_array(12) {-height 15 -radix decimal} /tb_top/U_0/MIPS_CORE/ID/register_array(13) {-height 15 -radix decimal} /tb_top/U_0/MIPS_CORE/ID/register_array(14) {-height 15 -radix decimal} /tb_top/U_0/MIPS_CORE/ID/register_array(15) {-height 15 -radix decimal} /tb_top/U_0/MIPS_CORE/ID/register_array(16) {-height 15 -radix decimal} /tb_top/U_0/MIPS_CORE/ID/register_array(17) {-height 15 -radix decimal} /tb_top/U_0/MIPS_CORE/ID/register_array(18) {-height 15 -radix decimal} /tb_top/U_0/MIPS_CORE/ID/register_array(19) {-height 15 -radix decimal} /tb_top/U_0/MIPS_CORE/ID/register_array(20) {-height 15 -radix decimal} /tb_top/U_0/MIPS_CORE/ID/register_array(21) {-height 15 -radix decimal} /tb_top/U_0/MIPS_CORE/ID/register_array(22) {-height 15 -radix decimal} /tb_top/U_0/MIPS_CORE/ID/register_array(23) {-height 15 -radix decimal} /tb_top/U_0/MIPS_CORE/ID/register_array(24) {-height 15 -radix decimal} /tb_top/U_0/MIPS_CORE/ID/register_array(25) {-height 15 -radix decimal} /tb_top/U_0/MIPS_CORE/ID/register_array(26) {-height 15 -radix decimal} /tb_top/U_0/MIPS_CORE/ID/register_array(27) {-height 15 -itemcolor Yellow -radix decimal} /tb_top/U_0/MIPS_CORE/ID/register_array(28) {-height 15 -radix decimal} /tb_top/U_0/MIPS_CORE/ID/register_array(29) {-height 15 -radix decimal} /tb_top/U_0/MIPS_CORE/ID/register_array(30) {-height 15 -radix decimal} /tb_top/U_0/MIPS_CORE/ID/register_array(31) {-height 15 -radix decimal}} /tb_top/U_0/MIPS_CORE/ID/register_array
add wave -noupdate -group ID -radix decimal /tb_top/U_0/MIPS_CORE/ID/write_register_address
add wave -noupdate -group ID /tb_top/U_0/MIPS_CORE/ID/write_data
add wave -noupdate -group ID /tb_top/U_0/MIPS_CORE/ID/read_register_1_address
add wave -noupdate -group ID /tb_top/U_0/MIPS_CORE/ID/read_register_2_address
add wave -noupdate -group ID -radix decimal /tb_top/U_0/MIPS_CORE/ID/write_register_address_1
add wave -noupdate -group ID -radix decimal /tb_top/U_0/MIPS_CORE/ID/write_register_address_0
add wave -noupdate -group ID /tb_top/U_0/MIPS_CORE/ID/Instruction_immediate_value
add wave -noupdate -group ID -radix decimal /tb_top/U_0/MIPS_CORE/ID/PC
add wave -noupdate -group {BT} /tb_top/U_0/BASIC_TIMER/clock
add wave -noupdate -group {BT} /tb_top/U_0/BASIC_TIMER/reset
add wave -noupdate -group {BT} /tb_top/U_0/BASIC_TIMER/ACK
add wave -noupdate -group {BT} /tb_top/U_0/BASIC_TIMER/BT_IRQ
add wave -noupdate -group {BT} -radix hexadecimal /tb_top/U_0/BASIC_TIMER/WR_data
add wave -noupdate -group {BT} -radix hexadecimal /tb_top/U_0/BASIC_TIMER/WR_Address
add wave -noupdate -group {BT} /tb_top/U_0/BASIC_TIMER/IO_WRITE
add wave -noupdate -group {BT} /tb_top/U_0/BASIC_TIMER/BTCTL
add wave -noupdate -group {BT} -radix decimal /tb_top/U_0/BASIC_TIMER/BTCNT
add wave -noupdate -group {BT} /tb_top/U_0/BASIC_TIMER/enable
add wave -noupdate -group {BT} /tb_top/U_0/BASIC_TIMER/BTSSEL
add wave -noupdate -group {BT} /tb_top/U_0/BASIC_TIMER/BTIP
add wave -noupdate -group {BT} /tb_top/U_0/BASIC_TIMER/q_int_down
add wave -noupdate -group {BT} /tb_top/U_0/BASIC_TIMER/BTSSEL_cnt
add wave -noupdate -group {BT} /tb_top/U_0/BASIC_TIMER/BTCNT_clk
add wave -noupdate -group MEM /tb_top/U_0/MIPS_CORE/MEM/read_data
add wave -noupdate -group MEM /tb_top/U_0/MIPS_CORE/MEM/INPUT_read_data
add wave -noupdate -group MEM /tb_top/U_0/MIPS_CORE/MEM/address
add wave -noupdate -group MEM /tb_top/U_0/MIPS_CORE/MEM/write_data
add wave -noupdate -group MEM /tb_top/U_0/MIPS_CORE/MEM/MemRead
add wave -noupdate -group MEM /tb_top/U_0/MIPS_CORE/MEM/Memwrite
add wave -noupdate -group MEM /tb_top/U_0/MIPS_CORE/MEM/MEM_ACCESS
add wave -noupdate -group MEM /tb_top/U_0/MIPS_CORE/MEM/MEM_WR_EN
add wave -noupdate -group MEM /tb_top/U_0/MIPS_CORE/MEM/INTR
add wave -noupdate -group MEM /tb_top/U_0/MIPS_CORE/MEM/ITYPE
add wave -noupdate -group MEM /tb_top/U_0/MIPS_CORE/MEM/clock
add wave -noupdate -group MEM /tb_top/U_0/MIPS_CORE/MEM/reset
add wave -noupdate -group MEM /tb_top/U_0/MIPS_CORE/MEM/write_clock
add wave -noupdate -group MEM /tb_top/U_0/MIPS_CORE/MEM/IO_registers_array
add wave -noupdate -group MEM /tb_top/U_0/MIPS_CORE/MEM/IO_ADRESS
add wave -noupdate -group MEM /tb_top/U_0/MIPS_CORE/MEM/IO_ACCESS
add wave -noupdate -group MEM -radix hexadecimal /tb_top/U_0/MIPS_CORE/MEM/read_data_internal
add wave -noupdate -group MEM -radix hexadecimal /tb_top/U_0/MIPS_CORE/MEM/address_sig
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2519563 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 359
configure wave -valuecolwidth 85
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {1967688 ps} {2805016 ps}

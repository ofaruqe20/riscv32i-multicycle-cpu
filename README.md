# riscv32i-multicycle-cpu
Verilog implementation of a multi-cycle RV32I RISC-V CPU featuring datapath, FSM-based controller, complete RV32I instruction support, memory subsystem, and memory-mapped UART peripheral.
CPU_Verilog_Files/
│
├── cpu.v                 # Top-level RV32I CPU integrating datapath and controller
├── controller.v          # Multi-cycle CPU controller and control-signal generation
├── datapath.v            # CPU datapath containing PC, register file, ALU, and memory interface
│
├── main_fsm.v            # Main finite-state machine controlling instruction execution
├── ALU_decoder.v         # Decodes instruction fields into ALU control signals
├── branch_unit.v         # Branch decision logic (BEQ, BNE, BLT, BGE, etc.)
├── imm_src_decoder.v     # Selects immediate format based on instruction type
├── load_store_unit.v     # Load/store operation decoding and data formatting
│
├── ALU.v                 # Arithmetic Logic Unit implementation
├── register_file.v       # 32 × 32-bit RISC-V register file
├── register_n.v          # Parameterized register module
│
├── extend.v              # Immediate value generation and extension logic
├── sign_extend.v         # Sign-extension module
├── zero_extend.v         # Zero-extension module
├── constant_32bit.v      # Constant-value generator
│
├── mux2.v                # 2-to-1 multiplexer
├── mux3.v                # 3-to-1 multiplexer
├── mux4.v                # 4-to-1 multiplexer
│
├── ROM_memory.v          # Instruction memory (program storage)
├── RAM_memory.v          # Data memory
├── address_decoder.v     # Memory-mapped address decoding logic
├── read_data.v           # Load-data formatting unit
├── write_data.v          # Store-data formatting unit
│
├── reset_clock.v         # Clock and reset generation module
├── testbench.v           # Top-level verification environment
│
├── riscvtest.asm         # RISC-V assembly test program
├── riscvtest.txt         # Machine-code image loaded into instruction memory

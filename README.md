# 💻 Single-Cycle Processor

## 🧾 Overview

This repository contains a Verilog implementation of a **single-cycle processor**. Each instruction is executed in **one clock cycle**, providing a straightforward baseline for understanding basic CPU architecture and RTL design.

---

## 📁 File Descriptions

| File                | Description                                                    |
| ------------------- | -------------------------------------------------------------- |
| `alu.v`             | Performs arithmetic and logic operations                       |
| `alu_control.v`     | Decodes ALU operations using function fields and ALUOp signals |
| `branch_logic.v`    | Computes branch decisions like BEQ or BNE                      |
| `control.v`         | Main control unit generating control signals based on opcode   |
| `data_mem.v`        | Simulates load/store data memory                               |
| `display_digs.v`    | Drives 7-segment display digits on the board                   |
| `hex7seg.v`         | Converts hexadecimal values to 7-segment encodings             |
| `imm_gen.v`         | Sign-extends immediate fields from instruction formats         |
| `instruction_mem.v` | Simulates ROM-based instruction memory                         |
| `pc.v`              | Program counter that increments or branches each cycle         |

---

## 🔧 Processor Functionality

This single-cycle CPU follows the classic 5-block architecture:

### 1️⃣ Instruction Fetch

* `pc.v`: Holds current PC value
* `instruction_mem.v`: Outputs instruction at PC

### 2️⃣ Instruction Decode

* `control.v`: Decodes opcode to generate control signals
* `imm_gen.v`: Sign-extends immediate values
* Register file (**external**): Reads `rs1`, `rs2`

### 3️⃣ Execute

* `alu_control.v`: Selects ALU function
* `alu.v`: Performs operations (add, sub, etc.)
* `branch_logic.v`: Evaluates branch condition

### 4️⃣ Memory Access

* `data_mem.v`: Reads/writes data from/to memory

### 5️⃣ Write Back

* Writes ALU or memory result to the register file

---

## 🚀 FPGA Deployment

To deploy on an FPGA (e.g., Basys3):

1. Open Vivado and create a new project
2. Add all source files listed above
3. Set `top.v` as the top-level module
4. Connect buttons/switches and 7-seg display
5. Generate bitstream and program the board

---

## 🧮 Supported Instructions

Based on the current implementation in `control.v`, `alu_control.v`, and related modules, the processor supports the following instructions:

### R-Type

* `add`  — Addition
* `sub`  — Subtraction
* `and`  — Bitwise AND
* `or`   — Bitwise OR
* `xor`  — Bitwise XOR
* `sll`  — Logical left shift
* `srl`  — Logical right shift

### I-Type

* `addi` — Immediate addition
* `lw`   — Load word
* `jalr` — Jump and link register

### S-Type

* `sw`   — Store word

### B-Type

* `beq`  — Branch if equal

### J-Type

* `jal`  — Jump and link

### U-Type

* `lui`  — Load upper immediate

## 👤 Author

\Satvik Gonur
Feel free to customize and expand this design!

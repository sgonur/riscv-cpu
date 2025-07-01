`timescale 1ns / 1ps
module top(
    input wire clk,
    input wire btnR,
    input wire [15:0] sw,
    output wire [15:0] led,
    output wire [3:0] an,
    output wire [6:0] seg,
    output wire dp
);
    // Clock divider
    reg [31:0] div = 0;
    always @(posedge clk)
        div <= div + 1;
    wire cpu_clk = div[27];
    wire disp_clk = clk;
    
    // Reset synchronizer
    reg [2:0] reset_sync = 3'b111;
    always @(posedge clk) begin
        reset_sync <= {reset_sync[1:0], btnR};
    end
    wire reset = reset_sync[2];
    
    // Program Counter
    wire [31:0] pc, next_pc, pc4;
    assign pc4 = pc + 32'd4;
    pc pc_reg (.clk(cpu_clk), .reset(reset), .next_pc(next_pc), .pc(pc));
    
    // Instruction Memory
    wire [31:0] instr;
    instruction_mem imem (.addr(pc), .instr(instr));
    
    // Instruction Decode
    wire [6:0] opcode = instr[6:0];
    wire [2:0] funct3 = instr[14:12];
    wire [6:0] funct7 = instr[31:25];
    wire [4:0] rs1_id = instr[19:15];
    wire [4:0] rs2_id = instr[24:20];
    wire [4:0] rd_id  = instr[11:7];
    
    // Control Unit
    wire reg_write, alu_src, mem2reg, mem_wr, branch;
    wire [1:0] alu_op;
    control cntrl (.opcode(opcode), .reg_write(reg_write), .alu_src(alu_src), .mem_to_reg(mem2reg), .mem_write(mem_wr), .branch(branch), .alu_op(alu_op));
    
    // Immediate Generator
    wire [31:0] imm;
    imm_gen immgen (.instr(instr), .imm_out(imm));
    
    // Register File
    wire [31:0] rs1, rs2, wb_data;
    reg_file RF (.clk(cpu_clk), .reg_write(reg_write), .rs1(rs1_id), .rs2(rs2_id), .rd(rd_id), .wd(wb_data), .rd1(rs1), .rd2(rs2));
    
    // ALU Control
    wire [3:0] alu_ctl;
    alu_control ALUCTL(.alu_op(alu_op), .funct3(funct3), .funct7(funct7), .alu_ctrl(alu_ctl));
    
    // ALU
    wire [31:0] alu_b = alu_src ? imm : rs2;
    wire [31:0] alu_y;
    alu ALU(.a(rs1), .b(alu_b), .alu_op(alu_ctl), .result(alu_y));
    
    // Data Memory
    wire [31:0] dmem_out;
    data_mem dm (.clk(cpu_clk), .mem_write(mem_wr), .addr(alu_y), .write_data(rs2), .read_data(dmem_out));
    
    // Write Back Multiplexer
    assign wb_data = mem2reg ? dmem_out : alu_y;
    
    // Branch Logic
    wire take_branch;
    branch_logic bl (.branch(branch), .funct3(funct3), .rs1_val(rs1), .rs2_val(rs2), .take_branch(take_branch));
    
    // Next PC Logic (handles branches and jumps)
    wire pc_src = branch && take_branch;
    assign next_pc = pc_src ? pc + imm : pc4;
    
    // LED Output
    assign led = alu_y[15:0];
    
    // Display Multiplexer
    reg [15:0] display_value;
    always @(*) begin
        case(sw[1:0])
            2'b00: display_value = alu_y[15:0];     // ALU result
            2'b01: display_value = dmem_out[15:0];  // Memory data (more useful than duplicate ALU)
            2'b10: display_value = pc[15:0];        // Program counter
            2'b11: display_value = instr[15:0];     // Current instruction
            default: display_value = 16'h0000;
        endcase
    end
    
    // 7-Segment Display
    display_digs visual (.clk(disp_clk), .reset(reset), .hex(display_value), .an(an), .seg(seg), .dp(dp));    
endmodule
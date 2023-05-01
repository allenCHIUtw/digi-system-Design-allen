// Your SingleCycle RISC-V code

module CHIP(clk,
            rst_n,
            // for mem_D
            mem_wen_D,
            mem_addr_D,
            mem_wdata_D,
            mem_rdata_D,
            // for mem_I
            mem_addr_I,
            mem_rdata_I
    );
    parameter width = 32;
    input         clk, rst_n ;
    // for mem_D
    output        mem_wen_D  ;  // mem_wen_D is high, CHIP writes data to D-mem; else, CHIP reads data from D-mem
    output [31:0] mem_addr_D ;  // the specific address to fetch/store data 
    output [31:0] mem_wdata_D;  // data writing to D-mem 
    input  [31:0] mem_rdata_D;  // data reading from D-mem
    // for mem_I
    output [31:0] mem_addr_I ;  // the fetching address of next instruction
    input  [31:0] mem_rdata_I;  // instruction reading from I-mem
    
    // wire  [width-1:0] PC,PC_NXT,,PC_IMM,PC_PLUS_I,PC_ZERO,PC_ONE;
    reg  [width-1:0] PC_r,PC_w ;
    
    wire [width-1:0] reg_rdata_1 , reg_rdata_2, alusrc_data , o_immgen ,alu_result ,write_data_reg,final_read;
    wire [width-1:0] i_r_instruction  ,o_addr_mem,i_data_mem ,PC_PLUS4;
    wire [6:0] i_opcode,i_func7;
    wire [4:0] i_rs1,i_rs2,i_rd_or_imm;
    wire [3:0] o_aluctrol;
    wire [2:0] i_func3;
    wire [1:0] aluop;

    wire zero , jalr,jal, jal_or_jalr, branch ,memread,memtoreg ,memwrite,alusrc,regwrite;
    //======================io platform=====================
    assign mem_addr_I    = PC_r;
    assign mem_addr_D    = alu_result; // no need to 
    assign mem_wdata_D   = o_addr_mem;
    assign mem_wen_D     = memwrite ;
    //===================io platform=======================

    //=====================inner wires=========================
    assign i_opcode      = i_r_instruction[6:0];
    assign i_rd_or_imm   = i_r_instruction[11:7];
    assign i_func3       = i_r_instruction[14:12];
    assign i_rs1         = i_r_instruction[19:15];
    assign i_rs2         = i_r_instruction[24:20];
    assign i_func7       = i_r_instruction[31:25];
    assign PCINS_CTRL    = jal | (branch & zero);
    assign PC_PLUS4      = PC_r+32'd4;
  
    //=====================inner wires====================
   
    //==========modules=============
    //PC_control #(.BITS(32)) PCFF01(.i_PC(PC_NXT),.CLK(clk),.rst_n(rst_n),.o_PC(PC));
    REG_FILE #(.BITS(5),.WIDTH(32)) registerfile_01(.read_reg_1(i_rs1),.read_reg_2(i_rs2),.write_reg(i_rd_or_imm),
                                                    .regWrite(regwrite),.clk(clk),.rst_n(rst_n),.write_data(write_data_reg),
                                                    .read_data_1(reg_rdata_1),.read_data_2(reg_rdata_2));
                                                    
    ALU #(.BITS(32)) chipalu01(.i_a(reg_rdata_1),.i_b(alusrc_data),.i_ctrl(o_aluctrol),.o_zero(zero),.o_result(alu_result));

    ENDIAN_CONV endconv01(.i_endians(mem_rdata_I),.o_endians(i_r_instruction)); //i_mem to chip
    ENDIAN_CONV endconv02(.i_endians(reg_rdata_2),.o_endians(o_addr_mem));  //chip to d_mem
    ENDIAN_CONV endconv03(.i_endians(mem_rdata_D),.o_endians(i_data_mem));  //d_mem to chip
    
     
    // adder #(.BITS(32)) adder02(.i_a(PC),.i_b(o_immgen) ,.o_result(PC_IMM));
    // adder #(.BITS(32)) adder03(.i_a(reg_rdata_1),.i_b(o_immgen) ,.o_result(PC_ONE));
    
   
    MUX2to1 #(.BITS(32)) MUX_01(.i_a(PC_PLUS4),.i_b(final_read),.muxctrol(jal_or_jalr),.o_result(write_data_reg));
    MUX2to1 #(.BITS(32)) MUX_02(.i_a(o_immgen),.i_b(reg_rdata_2),.muxctrol(alusrc),.o_result(alusrc_data)); //alusrc 
    MUX2to1 #(.BITS(32)) MUX_03(.i_a(i_data_mem),.i_b(alu_result),.muxctrol(memtoreg),.o_result(final_read));  //memtoreg
    //pc muxs
    // MUX2to1 #(.BITS(32)) MUX_04(.i_a(PC_IMM),.i_b(PC_PLUS4),.muxctrol(PCINS_CTRL),.o_result(PC_ZERO));
    // MUX2to1 #(.BITS(32)) MUX_05(.i_a(PC_ONE),.i_b(PC_ZERO),.muxctrol(jalr),.o_result(PC_NXT));
     //pc muxs

    immGEN #(.WIDTH(32)) immedgene01(.i_instruction(i_r_instruction),.gen_instruction(o_immgen));

    ALU_CTRL alu_control(.OP(aluop),.funct3(i_func3),.funct7(i_func7[5]),.alu_control(o_aluctrol));

    INS_CONTROL insCtrol01(.opcode(i_opcode),.jalr(jalr),.jal(jal),.jal_or_jalr(jal_or_jalr),.branch(branch),
                           .memread(memread),.memtoreg(memtoreg),.aluop(aluop),
                           .memwrite(memwrite),.alusrc(alusrc),.regwrite(regwrite));
    //==========modules=============
    always @(*) begin 
         PC_w       = (jalr) ? reg_rdata_1 + o_immgen : (PCINS_CTRL) ? PC_r + o_immgen : PC_r + 4 ;
    end
    always @(posedge clk) begin 
          if(!rst_n) begin  
            PC_r <= 32'd0; 
             
          end
          else  begin       
            PC_r <= PC_w;
             
          end
    end
    
 
endmodule

module INS_CONTROL(
        input [6:0]opcode,
        output jalr,
        output jal,
        output jal_or_jalr,
        output branch,
        output memread,
        output memtoreg,
        output memwrite,
        output alusrc,
        output regwrite,
        output [1:0] aluop
 );
 reg [10:0] control;
 assign {jalr,jal,jal_or_jalr,branch,memread,memtoreg,memwrite,alusrc,regwrite,aluop[1:0]} = control;
 parameter JAL        = 7'b1101111;   // jal  ==> on= jal
 parameter JALR       = 7'b1100111;   // jalr  ==> on= jalr
 parameter BRANCH     = 7'b1100011;   // brancch ==> on= branch  alusrc,  memtoreg
 parameter LOAD       = 7'b0000011;   // load  ==> on=   regwrite, memtoreg ,aluop
 parameter STORE      = 7'b0100011;   // store  ==> on=  memtoreg , memwrite 
 parameter ARITH      = 7'b0110011;   // acaulation  ==> on= alusrc
 // {jalr,jal,jal_or_jalr,branch,    memread,memtoreg,memwrite,alusrc,    regwrite,aluop[1:0]} 
 always@(*)
 begin
  case (opcode) // xx=dond care  0 or 1 either 0 recommand
    JAL:     control = 11'b01100101100;  //j type : jal    --->
    JALR:    control = 11'b10100101100;  // i type :jalr   --->
    BRANCH:  control = 11'b00010000000;   //b type :beq    ---> NOmemread NOmemwrite  NOalusrc noregwrite just branch
    LOAD:    control = 11'b00001101100; // i type :lw      ---> regwrite memtoreg ,memread, alusrc aluop ok
    STORE:   control = 11'b00000011000; // s type  :sw     --->    aluop noregwrite DCmemtoreg memwrite  alusrc
    ARITH:   control = 11'b00000000110; // R type :add, sub, and, or ,slt ---> regwrite +aluop   ok
    default: control = 11'b00000000000; 
  endcase
 end
endmodule

module REG_FILE #( parameter BITS=5,parameter WIDTH =32)( //ok
    input  [BITS-1:0] read_reg_1,
    input  [BITS-1:0] read_reg_2,
    input  [BITS-1:0] write_reg,
    input  regWrite,
    input  clk,
    input  rst_n,
    input  [WIDTH-1:0] write_data,
    output [WIDTH-1:0] read_data_1,
    output [WIDTH-1:0] read_data_2
    
 );
  integer  idx;
  reg [WIDTH-1:0] reg_r [0:WIDTH-1];
  reg [WIDTH-1:0] reg_w [0:WIDTH-1];
  // assign  read_data_1  = (read_reg_1 == 5'd0 ) ? 32'd0: reg_r[read_reg_1];
  // assign  read_data_2  = (read_reg_2 ==  5'd0) ? 32'd0: reg_r[read_reg_2];
  assign  read_data_1  =   reg_r[read_reg_1];
  assign  read_data_2  =   reg_r[read_reg_2];
  always @(*) begin
    for(idx=0; idx<WIDTH; idx=idx+1) begin 
         reg_w[idx]  = reg_r[idx]; 
      end
  end
 always @(posedge clk   ) begin
  if(!rst_n) begin
    for(idx=0; idx<WIDTH; idx=idx+1) begin 
         reg_r[idx] <= 32'd0; 
    end
  end
  else begin 
      if(regWrite == 1'b1 & write_reg != 5'd0) begin
        reg_r[ write_reg ] <= write_data;
      end
      else begin 
          for(idx=0; idx<WIDTH; idx=idx+1) begin 
              reg_r[idx] <= reg_w[idx]; 
           end
      end
  end
 end
endmodule

module ALU #( parameter BITS =32
 )(
    input [BITS-1:0] i_a,
    input [BITS-1:0] i_b,
    input [3:0] i_ctrl,
    output  o_zero,  
    output  [BITS-1:0] o_result
    
 );
   parameter AND      = 4'b0000;
   parameter OR       = 4'b0001;
   parameter ADD      = 4'b0010; // load or store /+jal jalr
   parameter SUBTRACT = 4'b0110;  //branch
   parameter SLT      = 4'b1000;
    
  reg [31:0 ] in_result ;
  reg in_zero;

   
   assign   o_result = in_result ;
   assign   o_zero   = in_zero  ;

    always @(*) begin
      case(i_ctrl)
        AND:begin
            in_zero     = 1'b0;
            in_result   = i_a & i_b;
        end
        OR: begin
            in_zero     = 1'b0;
            in_result   = i_a | i_b;
        end
        ADD :begin 
             in_zero     = 1'b0;
             in_result = i_a + i_b;
        end
        SUBTRACT: begin 
            in_zero     =  (i_a == i_b) ? 1'b1 : 1'b0;
            in_result   =  i_a - i_b;
        end
        SLT : begin 
            in_zero     = 1'b0 ;
            in_result   = (i_a < i_b) ? 32'd1 : 32'd0;
        end
        default: begin 
            in_zero     = 1'b0;
            in_result   = 32'd0;
        end
      endcase
    
    end
endmodule

module immGEN #(parameter WIDTH =32)(   // ok
    input [WIDTH-1:0] i_instruction,
    output [WIDTH-1:0] gen_instruction
 );
 reg [WIDTH-1:0] gened;
 assign gen_instruction = gened;
 always @(*) begin
    case(i_instruction[6:0]) 
    7'b1100011:  begin // b type
         gened  = {{{WIDTH-12}{i_instruction[31]}},i_instruction[7],i_instruction[30:25],i_instruction[11:8],1'b0};
    end
    7'b1101111: begin  //j type  ok
         gened  = {{{WIDTH-20}{i_instruction[31]}},i_instruction[19:12], i_instruction[20] ,i_instruction[30:25],i_instruction[24:21],1'b0};
    end
    7'b0000011: begin  //i type LW  ok
        gened  ={{{WIDTH-11}{i_instruction[31]}},i_instruction[30:25],i_instruction[24:21],i_instruction[20]};
    end
    7'b0100011: begin  //s type BEQ SW  ok
        gened  ={{{WIDTH-11}{i_instruction[31]}},i_instruction[30:25],i_instruction[11:8],i_instruction[7]};
    end
  
    default: begin
         gened  = {WIDTH{1'b0}};
    end
  endcase
  /*
  R type :add, sub, and, or ,slt 
  i type :lw ,jalr
  s type  :sw 
  b type :beq
  j type :  jal

 
  */
 end
endmodule

module ALU_CTRL( // ptbloe
   input [1:0] OP, //4==>1 3==>0
   input [2:0] funct3,
   input   funct7,
   output [3:0]alu_control
 ); //when meeting jal jalr use + 0011
  assign  alu_control[0] = OP[1] & funct3[2] & funct7 & (!funct3[0]);
  assign  alu_control[1] = !(OP[1] & (!OP[0]) & funct3[1]);
  assign  alu_control[2] = ((!OP[1])  & (!funct3[1])) | (funct7 & OP[1]);
  assign  alu_control[3] = OP[1] & (!funct3[2]) & funct3[1];
  // assign  alu_control[0] = OP[1] & funct3[2] & funct7[1] & (!funct3[0]);
  // assign  alu_control[1] = !OP[4] & (!OP[3]) & funct3[1];
  // assign  alu_control[2] = ((!OP[4])  & (!funct3[1])) | (funct7[5] & OP[4]);
  // assign  alu_control[3] = OP[4] & (!funct3[2]) & funct3[1];
endmodule

module  ENDIAN_CONV(
    input [31:0] i_endians,
    output [31:0] o_endians
 );
 assign  o_endians ={{i_endians[7:0]} ,{i_endians[15:8]} ,{i_endians[23:16]} ,{i_endians[31:24]}};
endmodule

module MUX2to1#(parameter BITS=32) ( 
 input [BITS-1:0] i_a ,
 input [BITS-1:0] i_b ,
 input muxctrol,
 output [BITS-1:0] o_result
 );
 assign o_result =(muxctrol) ? i_a : i_b ;
endmodule
 

module adder #(parameter BITS=32) (
 input [BITS-1:0] i_a ,
 input [BITS-1:0] i_b,
 output o_result
 );
 assign o_result = i_a + i_b;
endmodule

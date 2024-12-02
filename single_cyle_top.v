module single_cyle_top(out,out2,out3,out4,out5,clk,rst);
          
			 
        output [11:0] out;
			  output [4:0] out2,out3;
			  output [2:0] out4;
			  output  [6:0] out5;
        input clk,rst;
         

          wire [31:0]  PC_Top,PC_NEXT,RD_Instr,RD1_Top,Imm_Ext_Top,ALU_Result,READ_DATA,PCPlus4,WriteData,scrb,result_mux,PCMux;
          wire [2:0] ALUControl_Top;
          wire [1:0] ImmSrc,ResultSrc;
          wire MemWrite,ALUSrc,PCSrc,RegWrite,Zero;
          //
          program_counter PC(
            .clk(clk),
            .rst(rst),
            .PC(PC_Top),
            .PC_NEXT(PC_NEXT)

                           );

            PC_ADDER PC_ADDER(
                      .a(PC_Top),
                      .b(32'h00000004),
                      .c(PCPlus4)
        
                               ); 



          instruction_memory instruction_memory(
                                   .rst(rst),
                                   .A(PC_Top),
                                   .RD(RD_Instr)
                                   );




                          

         register_files register_files(
                             .rst(rst),
                             .clk(clk),
                             .A1(RD_Instr[19:15]),
                             .A2(RD_Instr[24:20]),
                             .A3(RD_Instr[11:7]),
                             .WD3(result_mux),
                             .WE3(RegWrite),
                             .RD1(RD1_Top),
                             .RD2(WriteData)  
                             );

        sign_extend sign_extend(
            
                      .In(RD_Instr),
                      .Imm_Ext(Imm_Ext_Top),
                      .ImmSrc(ImmSrc)
                           );


        ALU ALU(
            .a(RD1_Top),
            .b(scrb),
            .ALUControl(ALUControl_Top),
            .result(ALU_Result),
            .z(Zero),
            .n(),
            .v(),
            .c()
        
        
        
        
                );


        Control_Unit_Top Control_Unit_Top(
                           .Op(RD_Instr[6:0]),
                           .RegWrite(RegWrite),
                           .ImmSrc(ImmSrc),
                           .ALUSrc(ALUSrc),
                           .MemWrite(MemWrite),
                           .ResultSrc(ResultSrc),
                           .funct3(RD_Instr[14:12]),
                           .funct7({1'b0,RD_Instr[30],1'b0}),
                           .ALUControl(ALUControl_Top),
                           .PCSrc(PCSrc),
                           .Zero(Zero),
                           .Jump()
                    
                           
                                         );
        data_memory data_memory(
                    .clk(clk),
                    .rst(rst),
                    .A(ALU_Result),
                    .WD(WriteData),
                    .RD(READ_DATA),
                    .WE(MemWrite)
                         ); 


        


                  pctarget pctarget(
                    .Imm_Ext(Imm_Ext_Top),
                    .pc(PC_Top),
                    .PCTraget(PCMux)
              
                  );    

                  pc_mux pc_mux(.PCNext(PC_NEXT),
                                .PCSrc(PCSrc),
                                .PCTarget(PCMux),
                                .PCPlus4(PCPlus4)
                                );
                  ALU_Mux ALU_Mux(.SrcB(scrb),
                                  .ALUSrc(ALUSrc),
                                  .RD2(WriteData),
                                  .Imm_Ext(Imm_Ext_Top)
                                  );

        read_mux  read_data_mux(.Result(result_mux),
                                .ResultSrc(ResultSrc[0]),
                                .ALU_Result(ALU_Result),
                                .READ_DATA(READ_DATA)
                                );


       assign out = Imm_Ext_Top[11:0];
			 assign out2 = RD_Instr[19:15];
			 assign out3 = RD_Instr[24:20];
			 assign out4 = RD_Instr[14:12];
			 assign out5 = RD_Instr[6:0];
		
			 

        

    
 endmodule

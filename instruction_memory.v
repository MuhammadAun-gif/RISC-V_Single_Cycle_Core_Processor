module instruction_memory(RD,A,rst);
       // decalring o/ps
       output [31:0] RD;

       //decalring i/ps
       input [31:0] A;
       input rst;

       
       //creating memoring
       reg [31:0] Mem [31:0] ;
		 

       assign RD = (~rst) ? 32'h00000000: Mem[A[31:2]] ;  

      // initial begin
    //    $readmemh("memfile.hex",mem);
     // end
      
      
      
      initial begin
         //  Mem[0] = 32'hFFC4A303;
        // Mem[1] = 32'h0062E233;
       //Mem[2] = 32'h0064A423;
      //Mem[0] = 32'hFE420AE3;
         
       // Mem[0] = 32'h00000000;
		 //Mem[1] = 32'h00500293;
		 //Mem[2] = 32'h00300313;
		 //Mem[3] = 32'h006283B3;
		 //Mem[4] = 32'h00002403;
		 //Mem[5] = 32'h00100493;
		 //Mem[6] = 32'h00940533;   
       
         
         Mem[0]  = 32'h00500113;
         Mem[1]  = 32'h00C00193;
         Mem[2]  = 32'hFF718393;
         Mem[3]  = 32'h0023E233;
         Mem[4]  = 32'h0041F2B3;
         Mem[5]  = 32'h004282B3;
			Mem[6]  = 32'h02728863;
			Mem[7]  = 32'h0041A233;
			Mem[8]  = 32'h00020463;
			Mem[9]  = 32'h00000293;
			Mem[10] = 32'h0023A233;
			Mem[11] = 32'h005203B3;
			Mem[12] = 32'h402383B3;
			Mem[13] = 32'h0471AA23;
			Mem[14] = 32'h06002103;
			Mem[15] = 32'h005104B3;
			Mem[16] = 32'h008001EF;
			Mem[17] = 32'h00100113;
			Mem[18] = 32'h00910133;
			Mem[19] = 32'h0221A023;
			Mem[20] = 32'h00210063;


      end



endmodule

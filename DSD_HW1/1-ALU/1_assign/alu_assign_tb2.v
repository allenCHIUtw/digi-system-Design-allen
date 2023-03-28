//continuous assignment tb
`timescale 1ns/10ps
`define CYCLE   10
`define HCYCLE  5

module alu_assign_tb;
    reg  [3:0] ctrl;
    reg  [7:0] x;
    reg  [7:0] y;
    wire       carry;
    wire [7:0] out;
    
    alu_assign alu_assign(
        ctrl     ,
        x        ,
        y        ,
        carry    ,
        out  
    );

    initial begin
       $fsdbDumpfile("alu_assign_2.fsdb");
       $fsdbDumpvars;
    end
    
    integer err_count;
    
    initial begin
        err_count   =0;
        x           =8'b10010110;
        y           =8'b00101101;
        ctrl=4'd0;
        $display( "alu_assign_test" );
        #(`CYCLE)
        $display( "0.ADD (signed)"  );
        $display( "[out = x + y]" );      
        ctrl=4'd0;
         #(`HCYCLE);
        if(carry==1 & out==8'b11000011) begin 
            $display( "    .... passed." );
        end
        else begin
            err_count=err_count+1;
             $display( "    .... failed, design(%b) != expected(%b)",out , 8'b11000011 );
        end


        #(`CYCLE)
        $display( "1.SUB (signed)"  );
        $display( "[out = x + y]" );      
        x           =8'b10110111;
        y           =8'b00001101;
        ctrl=4'd1;
         #(`HCYCLE);
        if(carry==1 & out==8'b10101010) begin 
            $display( "    .... passed." );
        end
        else begin
            err_count=err_count+1;
             $display( "    .... failed, design(%b) != expected(%b)",out , 8'b10101010 );
        end
     

        #(`CYCLE)
        $display( "2.BITAND"  );
        $display( "[out = and(x, y)]" );  
        x           =8'b10110111;
        y           =8'b11010101;    
        ctrl=4'd2;
         #(`HCYCLE);
        if(carry==0 & out==8'b10010101) begin 
            $display( "    .... passed." );
        end
        else begin
            err_count=err_count+1;
             $display( "    .... failed, design(%b) != expected(%b)",out , 8'b11000011 );
        end
        x           =8'b10110101;
        y           =8'b10011101;   
        ctrl=4'd3;
        #(`CYCLE)
        $display( "3.BITOR"  );
        $display( "[out = OR(x, y)]" );    

        
        #(`HCYCLE);
        if(carry==0 & out==8'b10111101) begin 
            $display( "    .... passed." );
        end
        else begin
            err_count=err_count+1;
             $display( "    .... failed, design(%b) != expected(%b)",out , 8'b11000011 );
        end


        #(`CYCLE)
        $display( "4.BITNOT"  );
        $display( "[out = ~x]" );      
        x           =8'b10111001;
        
        ctrl=4'd4;
         #(`HCYCLE);
        if(carry==0 & out==8'b01000110) begin 
            $display( "    .... passed." );
        end
        else begin
            err_count=err_count+1;
             $display( "    .... failed, design(%b) != expected(%b)",out , 8'b11000011 );
        end

        #(`CYCLE)
        $display( "5.BITXOR"  );
        $display( "[out = xor(x,y)]" );    
        x           =8'b10110111;
        y           =8'b00101101;   
        ctrl=4'd5;
         #(`HCYCLE);
        if(carry==0 & out==8'b10011010) begin 
            $display( "    .... passed." );
        end
        else begin
            err_count=err_count+1;
             $display( "    .... failed, design(%b) != expected(%b)",out , 8'b11000011 );
        end

        #(`CYCLE)
        $display( "6.BITNOR"  );
        $display( "[out = nor(x , y)]" );  
        x           =8'b10110101;
        y           =8'b00100101;       
        ctrl=4'd6;
         #(`HCYCLE);
        if(carry==0 & out==8'b01001010) begin 
            $display( "    .... passed." );
        end
        else begin
            err_count=err_count+1;
             $display( "    .... failed, design(%b) != expected(%b)",out , 8'b11000011 );
        end

        #(`CYCLE)
        $display( "7.SLLV"  );
        $display( "[out = y << x[2:0]" );      
        x           =8'b01011010;
        y           =8'b11001101;  
        ctrl=4'd7;
         #(`HCYCLE);
        if(carry==0 & out==8'b00110100) begin 
            $display( "    .... passed." );
        end
        else begin
            err_count=err_count+1;
             $display( "    .... failed, design(%b) != expected(%b)",out , 8'b00110100 );
        end
        

        #(`CYCLE)
        $display( "8.SLRV"  );
        $display( "[out = y >> x[2:0]]" );     
        x           =8'b01011011;
        y           =8'b11001101;  
        ctrl=4'd8;
         #(`HCYCLE);
        if(carry==0 & out==8'b00011001 ) begin 
            $display( "    .... passed." );
        end
        else begin
            err_count=err_count+1;
             $display( "    .... failed, design(%b) != expected(%b)",out , 8'b11000011 );
        end

        #(`CYCLE)
        $display( "9.SRA"  );
        $display( "[out={x[7],x[7:1]}]" );      
        ctrl=4'd9;
        x           =8'b01001110;
        y           =8'b11001101; 
         #(`HCYCLE);
        if(carry==0 & out==8'b00100111) begin 
            $display( "    .... passed." );
        end
        else begin
            err_count=err_count+1;
             $display( "    .... failed, design(%b) != expected(%b)",out , 8'b11000011 );
        end

        #(`CYCLE)
        $display( "10.RL"  );
        $display( "[out = {x[6:0] , x[7]}]" ); 
        x           =8'b10110101; //
        y           =8'b10100101;     
        ctrl=4'd10;
        
         #(`HCYCLE);
        if(carry==0 & out==8'b01101011) begin 
            $display( "    .... passed." );
        end
        else begin
            err_count=err_count+1;
             $display( "    .... failed, design(%b) != expected(%b)",out , 8'b11000011 );
        end

        #(`CYCLE)
        $display( "11.RR"  );
        $display( "[out = {x[0] , x[7:1]]" );         
        x           =8'b10110101; //
        y           =8'b10100101; 
        ctrl=4'd11;
         #(`HCYCLE);
        if(carry==0 & out==8'b11011010) begin 
            $display( "    .... passed." );
        end
        else begin
            err_count=err_count+1;
             $display( "    .... failed, design(%b) != expected(%b)",out , 8'b11000011 );
        end

        #(`CYCLE)
        $display( "12.EQ"  );
        $display( "[out = (x = y )? 8'd1:8'd0]" );     
        x           =8'b10110101;
        y           =8'b10100101;   
        ctrl=4'd12;
        #(`HCYCLE);
        if(carry==0 & out==8'd0) begin 
            $display( "    .... passed." );
        end
        else begin
            err_count=err_count+1;
             $display( "    .... failed, design(%b) != expected(%b)",out , 8'b11000011 );
        end

         #(`CYCLE)
        $display( "12_2.EQ"  );
        $display( "[out = (x = y )? 8'd1:8'd0]" );     
        x           =8'b01101011;
        y           =8'b01101011;   
        ctrl=4'd12;
        #(`HCYCLE);
        if(carry==0 & out==8'd1) begin 
            $display( "    .... passed." );
        end
        else begin
            err_count=err_count+1;
             $display( "    .... failed, design(%b) != expected(%b)",out , 8'b11000011 );
        end
        
         #(`CYCLE)
        $display( "13.NOP"  );
        $display( "[out = 8'd0]" );  
        x           =8'b10110101;
        y           =8'b00100101;     
        ctrl=4'd13;
         #(`HCYCLE);
        if(carry==0 & out==8'd0) begin 
            $display( "    .... passed." );
        end
        else begin
            err_count=err_count+1;
             $display( "    .... failed, design(%b) != expected(%b)",out , 8'b11000011 );
        end

        #(`CYCLE)
        $display( "14.NOP"  );
        $display( "[out = 8'd0]" );   
        x           =8'b10110101;
        y           =8'b10100101;     
        ctrl=4'd14;
         #(`HCYCLE);
        if(carry==0 & out==8'd0) begin 
            $display( "    .... passed." );
        end
        else begin
            err_count=err_count+1;
             $display( "    .... failed, design(%b) != expected(%b)",out , 8'b11000011 );
        end
        
         #(`CYCLE)
        $display( "15.NOP"  );
        $display( "[out = 8'd0]" );      
        x           =8'b00110101;
        y           =8'b10101101;  
        ctrl=4'd15;
         #(`HCYCLE);
        if(carry==0 & out==8'd0) begin 
            $display( "    .... passed." );
        end
        else begin
            err_count=err_count+1;
             $display( "    .... failed, design(%b) != expected(%b)",out , 8'b11000011 );
        end

         // finish tb

        
         if( err_count==0 ) begin
            $display("****************************        /|__/|");
            $display("**                        **      / O,O  |");
            $display("**   Congratulations !!   **    /_____   |");
            $display("** All Patterns Passed!!  **   /^ ^ ^ \\  |");
            $display("**                        **  |^ ^ ^ ^ |w|");
            $display("****************************   \\m___m__|_|");
        end
        else begin
            $display("**************************** ");
            $display("**************************** ");
            $display("     Failed ,and ...        ");
            $display("................ . ..... /´ /)");
            $display("................. ..,../¯ ..//");
            $display("................. ..,/¯ ..//");
            $display("................. ./... .//");
            $display("............./´¯/' ...'/´¯`•¸");
            $display("........../'/.../... ./... ..../¨¯\.");
            $display("........('(...´(... ....... ,~/'...')");
            $display(".........\.......... ..... ..\/..../");
            $display("..........\.... ..... ...... _.•´");
            $display("............\....... ..... ..(");
            $display("..............\..... ..... ...\.");
            $display("     Total %2d Errors ...     ", err_count );
            $display("**************************** ");
        end
        #(`CYCLE) $finish;
    end

// x=8'b10010110;   y =8'b00101101;
endmodule

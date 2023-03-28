`timescale 1ns/10ps
`define CYCLE  10
`define HCYCLE  5

module register_file_tb;
    // port declaration for design-under-test
    reg Clk, WEN;
    reg  [2:0] RW, RX, RY;
    reg  [7:0] busW;
    wire [7:0] busX, busY;
    
    // instantiate the design-under-test
    register_file rf(
        Clk  ,
        WEN  ,
        RW   ,
        busW ,
        RX   ,
        RY   ,
        busX ,
        busY
    );

    // write your test pattern here
     initial begin
       $fsdbDumpfile("register_file.fsdb");
       $fsdbDumpvars (0, register_file_tb , "+mda");

    end

     // clock generation
    always#(`HCYCLE) Clk = ~Clk;

    //test pattern
    parameter A ={4'd6,4'd11};
    parameter B ={4'd14,4'd3};
    parameter C ={4'd9,4'd2};
    parameter D ={4'd11,4'd5};
    parameter E ={4'd7,4'd4};

    //simulation count
    integer err_count;
    initial begin

        Clk       = 1'b1;
        err_count = 0;
        $display( " 8 X 8 bits register file test" );

        //------------------2 cycle testbench---------
        #(`CYCLE*0.2)
        $display( "1: store  A=%3d in REG#1 " , A ); 
        WEN = 1'b1 ; RW = 3'd1 ; busW = A ; RX = 3'd0 ;
        RY = 3'd0 ;  
        #(`CYCLE*0.8)
        #(`CYCLE*0.2)
        WEN = 1'b0 ; RW = 3'd3 ;  RX = 3'd1 ;  RY = 3'd0 ;   
        #(`CYCLE*0.3)
        if( busX==A ) $display( "    .... passed." );
        else begin 
            err_count = err_count+1;
            $display( "    .... failed, design(%b) != expected(%b)", busX, A );
        end
        #(`HCYCLE)

        //------------------2 cycle testbench---------
        #(`CYCLE*0.2)
        $display( "2: store  B=%3d in REG#5 " , B ); 
        WEN = 1'b1 ; RW = 3'd5 ; busW = B ; RX = 3'd0 ;
        RY = 3'd0 ;  
        #(`CYCLE*0.8)
        #(`CYCLE*0.2)
        WEN = 1'b0 ; RW = 3'd1 ;  RX = 3'd1 ;  RY = 3'd5 ;   
        #(`CYCLE*0.3)
        if( busY==B ) $display( "    .... passed." );
        else begin 
            err_count = err_count+1;
            $display( "    .... failed, design(%b) != expected(%b)", busX, A );
        end
        #(`HCYCLE)
        
        //------------------2 cycle testbench---------
        #(`CYCLE*0.2)
        $display( "3: store  C=%3d in REG#2 " , B ); 
        WEN = 1'b1 ; RW = 3'd2 ; busW = C ; RX = 3'd5 ;
        RY = 3'd7 ;  
        #(`CYCLE*0.8)
        #(`CYCLE*0.2)
        WEN = 1'b0 ; RW = 3'd2 ;  RX = 3'd2 ;  RY = 3'd2 ;   
        #(`CYCLE*0.3)
        if( busY==C & busX == C ) $display( "    .... passed." );
        else begin 
            err_count = err_count+1;
            $display( "    .... failed, designX(%b) != expected(%b)", busX, C );
            $display( "    .... failed, designY(%b) != expected(%b)", busY, C );
        end 
        #(`HCYCLE)

        //------------------2 cycle testbench---------
        #(`CYCLE*0.2)
        $display( "4: store  D=%3d in REG#4  and look back C=%3d in REG#2" , D ,C); 
        WEN = 1'b1 ; RW = 3'd4 ; busW = D ; RX = 3'd5 ;
        RY = 3'd7 ;  
        #(`CYCLE*0.8)
        #(`CYCLE*0.2)
        WEN = 1'b0 ; RW = 3'd2 ;  RX = 3'd2 ;  RY = 3'd4 ;   
        #(`CYCLE*0.3)
        if(  busY == D && busX ==C ) $display( "    .... passed." );
        else begin 
            err_count = err_count+1;
            $display( "    .... failed, designX(%b) != expected(%b)", busX, C );
            $display( "    .... failed, designY(%b) != expected(%b)", busY, D );
        end
        #(`HCYCLE)
        
         //------------------2 cycle testbench---------
        #(`CYCLE*0.2)
        $display( "5: restore multiplicand E=%3d in REG#1 " , E ); 
        WEN = 1'b1 ; RW = 3'd1 ; busW = E ; RX = 3'd5 ;
        RY = 3'd7 ;  
        #(`CYCLE*0.8)
        #(`CYCLE*0.2)
        WEN = 1'b0 ; RW = 3'd2 ;  RX = 3'd1 ;  RY = 3'd5 ;   
        #(`CYCLE*0.3)
        if( busX == E ) $display( "    .... passed." );
        else begin 
            err_count = err_count+1;
            $display( "    .... failed, design(%b) != expected(%b)", busX, E);
        end
        #(`HCYCLE)
         
         //------------------2 cycle testbench---------
        #(`CYCLE*0.2)
        $display( "6: test #reg0 "  ); 
        WEN = 1'b1 ; RW = 3'd0 ; busW = E ; RX = 3'd2 ;
        RY = 3'd7 ;  
        #(`CYCLE*0.8)
        #(`CYCLE*0.2)
        WEN = 1'b0 ; RW = 3'd2 ;  RX = 3'd0 ;  RY = 3'd0 ;   
        #(`CYCLE*0.3)
        if( busX == 8'd0 ) $display( "    .... passed." );
        else begin 
            err_count = err_count+1;
            $display( "    .... failed, design(%b) != expected(%b)", busX,8'd0 );
        end
        #(`HCYCLE)



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
    $display("     Failed ,and ...        ");
    $display("................ . ..... /´ /)");
    $display("................. ..,../¯ ..//");
    $display("................. ..,/¯ ..//");
    $display("................. ./... .//");
    $display("............./´¯/' ...'/´¯`•¸");
    $display("........../'/.../... ./... ..../¨¯|.");
    $display("........('(...´(... ....... ,~/'...')");
    $display(".........|.......... ..... ../..../");
    $display("..........|.... ..... ...... _.•´");
    $display("............|....... ..... ..(");
    $display("..............|..... ..... ...|.");
    
    $display("     Total %2d Errors ...     ", err_count );
    $display("**************************** ");
    end
     #(`CYCLE) $finish;
    end
endmodule

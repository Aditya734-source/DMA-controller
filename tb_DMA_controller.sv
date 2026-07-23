`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.07.2026 13:23:50
// Design Name: 
// Module Name: tb_DMA_controller
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_DMA_controller;
    logic clk;
    logic rst;
    logic start;
    logic [7:0] src_addr;
    logic [7:0] dst_addr;
    logic [3:0] count;
    
    logic [7:0] mem_addr;
    logic [7:0] mem_data_out;
    logic [7:0] mem_data_in;
    
    logic mem_we;
    logic busy;
    logic done;
    
    
    //Instantiate DMA controller
    DMA_controller dut(
        .clk(clk),
        .rst(rst),
        .start(start),
        .src_addr(src_addr),
        .dst_addr(dst_addr),
        .count(count),
        .mem_data_out(mem_data_out),
        
        .mem_addr(mem_addr),
        .mem_data_in(mem_data_in),
        .mem_we(mem_we),
        .busy(busy),
        .done(done)
    );
    
    //Instantitae memory
    memory mem(
    .clk(clk),
    .we(mem_we),
    .addr(mem_addr),
    .data_in(mem_data_in),
    .data_out(mem_data_out)
);
    initial begin
        clk=0;
        forever #5 clk=~clk;
   end
   
   //=========================================================
    // Initialize Memory with Source Data
    //=========================================================
    initial begin

        // Source data at addresses 10-13
        mem.memory_array[10] = 8'h11;
        mem.memory_array[11] = 8'h22;
        mem.memory_array[12] = 8'h33;
        mem.memory_array[13] = 8'h44;

        // Destination initialized to zero
        mem.memory_array[100] = 8'h00;
        mem.memory_array[101] = 8'h00;
        mem.memory_array[102] = 8'h00;
        mem.memory_array[103] = 8'h00;

    end
    
   initial begin
    rst = 1;
    start = 0;

    src_addr = 8'd10;
    dst_addr = 8'd100;
    count    = 4'd4;

    #20;
    rst = 0;

    //-----------------------------
        // Display Memory Before DMA
        //-----------------------------
        $display("---------------------------------------");
        $display("Memory Before DMA");
        $display("---------------------------------------");

        for(int i=10;i<14;i++)
            $display("Memory[%0d] = %h",i,mem.memory_array[i]);

        for(int i=100;i<104;i++)
            $display("Memory[%0d] = %h",i,mem.memory_array[i]);

        //-----------------------------
        // Start DMA
        //-----------------------------
    #10;
    start = 1;

    #10;
    start = 0;

    wait(done);
    #20;
    //-----------------------------
    // Display Memory After DMA
    //-----------------------------
    $display("\n---------------------------------------");
    $display("Memory After DMA");
    $display("---------------------------------------");

    for(int i=10;i<14;i++)
            $display("Memory[%0d] = %h",i,mem.memory_array[i]);

    for(int i=100;i<104;i++)
            $display("Memory[%0d] = %h",i,mem.memory_array[i]);
            //-----------------------------
        // Verify Data Transfer
        //-----------------------------
        $display("\n---------------------------------------");
        $display("Verification");
        $display("---------------------------------------");

        for(int i=0;i<4;i++) begin

            if(mem.memory_array[10+i] == mem.memory_array[100+i])
                $display("PASS : Address %0d copied correctly",10+i);

            else
                $display("FAIL : Address %0d not copied",10+i);

       end
    #20;
    $finish;
end
endmodule

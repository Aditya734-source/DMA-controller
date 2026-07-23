`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.07.2026 14:33:18
// Design Name: 
// Module Name: count1_register
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


module count1_register(
    input logic clk,
    input logic rst,
    input logic load,
    input logic [7:0] count_in,
    output logic [7:0] count_reg,
    output logic terminal_count
    );
    
    always_ff @(posedge clk)begin
        if(rst) count_reg<=8'd0;
        else if(load) count_reg<=count_in;
    end
    assign terminal_count= (count_reg== 8'd0);
endmodule

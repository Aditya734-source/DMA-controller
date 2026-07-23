`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.07.2026 14:34:48
// Design Name: 
// Module Name: destination1_register
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


module destination1_register(
    input logic clk,
    input logic rst,
    input logic load,
    input logic [7:0] destination_in,
    output logic [7:0] destination_reg
    );
    
    always_ff @(posedge clk)begin
        if(rst) destination_reg<=8'd0;
        else if(load) destination_reg<= destination_in;
    end
    
endmodule

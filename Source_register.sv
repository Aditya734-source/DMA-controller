`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.07.2026 13:41:06
// Design Name: 
// Module Name: Source_register
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


module Source_register(
    input logic clk,
    input logic rst,
    input logic load,
    input logic [7:0]source_in,
    output logic [7:0]source_reg
    );
    
    always_ff @(posedge clk)begin
        if(rst) source_reg<=8'd0;
        else if(load) source_reg<= source_in; 
    end
endmodule

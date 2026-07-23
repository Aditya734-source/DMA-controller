`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.07.2026 12:46:15
// Design Name: 
// Module Name: control_register
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


module control_register(
    input logic clk,
    input logic rst,
    input logic load,
    input logic [7:0] control_in,
    output logic [7:0] control_reg
    );
    
    always_ff @(posedge clk)begin
        if(rst) control_reg<=8'd0;
        else if(load==1) begin
            control_reg<=control_in;
        end 
   end  
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.07.2026 12:46:56
// Design Name: 
// Module Name: memory
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


module memory(
    input logic clk,
    input logic we,
    input logic [7:0] addr,
    input logic [7:0] data_in,
    output logic [7:0] data_out
    );
    logic [7:0] memory_array [0:255];
    
    always_ff @(posedge clk) begin
        
        if(we)begin
            memory_array[addr]<= data_in;//write operation
        end
    end
    
    assign data_out = memory_array[addr]; //read operation
endmodule

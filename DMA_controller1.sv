`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.07.2026 22:19:09
// Design Name: 
// Module Name: DMA_controller1
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


module DMA_controller1(
    input logic clk,
    input logic rst,
    input logic start,
    input logic [7:0]src_addr,
    input logic [7:0] dst_addr,
    input logic [3:0]count,
    input logic [7:0]mem_data_out,
    
    output logic [7:0]mem_addr,
    output logic [7:0]mem_data_in,
    output logic mem_we,
    output logic busy,
    output logic done
    );
    
    typedef enum logic [2:0]{
        IDLE,
        READ,
        WRITE,
        UPDATE,
        DONE
    } state_t;
    state_t p_state,n_state;
    
    logic [7:0] src_reg;
    logic [7:0] dst_reg;
    logic [3:0] count_reg;
    logic [7:0] temp_data;
    
    always_ff @(posedge clk) begin 
        if(rst) p_state<=IDLE;
        else p_state<=n_state;
    end
    
    //FSM
    always_comb begin
        case(p_state)
            IDLE:begin
                if(start) n_state=READ;
                else n_state=IDLE;
            end
            
            READ: begin
                n_state=WRITE;
            end
            
            WRITE:begin
                n_state=UPDATE;
            end
            
            UPDATE:begin
                if(count_reg==4'd1)
                    n_state=DONE;
                else n_state=READ;
            end
            
            DONE:begin
                n_state=IDLE;
            end
            default: begin
                n_state=IDLE;
            end
        endcase
    end
    
    //DATAPATH
    always_ff @(posedge clk)begin
        if(rst) begin
            src_reg<=8'd0;
            dst_reg<=8'd0;
            count_reg<=4'd0;
            temp_data<=8'd0;
        end
        
        else begin
            case(p_state)
                IDLE: begin
                    if(start) begin
                        src_reg<= src_addr;
                        dst_reg<= dst_addr;
                        count_reg<= count;
                    end
                end
                
                READ:begin
                    temp_data <= mem_data_out;
                end
                
                WRITE: begin
                end
                
                UPDATE:begin
                    src_reg<= src_reg+1;
                    dst_reg<=dst_reg+1;
                    count_reg<=count_reg-1;
                end
                default: begin
                end
            endcase
        end
    end
    
    //OUTPUT logic
    always_comb begin
        mem_addr= 8'd0;
        mem_data_in= 8'd0;
        mem_we= 1'b0;
        busy= 1'b0;
        done= 1'b0;
        
        case(p_state)
            IDLE: begin
                busy = 1'b0;
            end
            
            READ: begin
                busy = 1'b1;
                mem_addr = src_reg;
                mem_we = 1'b0;
            end 
            
            WRITE:begin
                busy=1'b1;
                mem_addr= dst_reg;
                mem_data_in=temp_data;
                mem_we=1'b1;
            end
            
            UPDATE: begin
                busy = 1'b1;
            end
            
            DONE: begin
                done = 1'b1;
            end
        endcase
    end
endmodule

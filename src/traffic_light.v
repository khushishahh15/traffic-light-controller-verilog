`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.12.2025 16:05:58
// Design Name: 
// Module Name: traffic_light
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


module traffic_light(
    input clk,
    input reset,
    output reg red,
    output reg yellow,
    output reg green
    );
    // State encoding
        reg [1:0] state;
        parameter RED    = 2'b00,
                  GREEN  = 2'b01,
                  YELLOW = 2'b10;
    
        // Timer for state duration
        reg [3:0] timer;
    
        // State transition logic
        always @(posedge clk or posedge reset) begin
            if (reset) begin
                state <= RED;
                timer <= 0;
            end else begin
                case (state)
    
                RED: begin
                    if (timer == 10) begin
                        state <= GREEN;
                        timer <= 0;
                    end else
                        timer <= timer + 1;
                end
    
                GREEN: begin
                    if (timer == 10) begin
                        state <= YELLOW;
                        timer <= 0;
                    end else
                        timer <= timer + 1;
                end
    
                YELLOW: begin
                    if (timer == 3) begin
                        state <= RED;
                        timer <= 0;
                    end else
                        timer <= timer + 1;
                end
    
                default: begin
                    state <= RED;
                    timer <= 0;
                end
    
                endcase
            end
        end
    
        // Output logic
        always @(*) begin
            red    = 0;
            yellow = 0;
            green  = 0;
    
            case (state)
                RED:    red    = 1;
                GREEN:  green  = 1;
                YELLOW: yellow = 1;
            endcase
        end
endmodule

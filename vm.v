module vm(
    input [1:0] coin_in,
    input beverage_take,
    input change_take,
    input clk,
    input rstn,
    output reg [4:0] money_account,
    output reg beverage_out,
    output reg [1:0] change_out
);

reg [4:0] c_state;
reg [4:0] n_state;
reg c_beverage_state, n_beverage_state;
reg c_change_state, n_change_state;
reg [4:0] temp_c_state;

localparam not_take = 1'b0;
localparam take = 1'b1;

localparam [4:0] S0 = 5'b00000;
localparam [4:0] S1 = 5'b00001;
localparam [4:0] S2 = 5'b00010;
localparam [4:0] S3 = 5'b00011;
localparam [4:0] S4 = 5'b00100;
localparam [4:0] S5 = 5'b00101;
localparam [4:0] S6 = 5'b00110;
localparam [4:0] S7 = 5'b00111;
localparam [4:0] S8 = 5'b01000;
localparam [4:0] S9 = 5'b01001;
localparam [4:0] S10 = 5'b01010;
localparam [4:0] S11 = 5'b01011;
localparam [4:0] S12 = 5'b01100;
localparam [4:0] S13 = 5'b01101;
localparam [4:0] S14 = 5'b01110;
localparam [4:0] S15 = 5'b01111;
localparam [4:0] S16 = 5'b10000;
localparam [4:0] S17 = 5'b10001;
localparam [4:0] S18 = 5'b10010;
localparam [4:0] S19 = 5'b10011;
localparam [4:0] S20 = 5'b10100;
localparam [4:0] S21 = 5'b10101;
localparam [4:0] S22 = 5'b10110;
localparam [4:0] S23 = 5'b10111;
localparam [4:0] S24 = 5'b11000;
localparam [4:0] S25 = 5'b11001;

always@(posedge clk or negedge rstn) begin
    if(!rstn) begin
        c_state = S0;
        c_beverage_state = not_take;
        c_change_state = not_take;
        temp_c_state = S0;
    end else begin
        temp_c_state = c_state;
        c_state = n_state;
        c_beverage_state = n_beverage_state;
        c_change_state = n_change_state;
    end
end

always@(*) begin
    n_beverage_state = c_beverage_state;

    if(coin_in == 2'b01 && beverage_take == 1'b1 || coin_in == 2'b10 && beverage_take == 1'b1 || 
            coin_in == 2'b01 && change_take == 1'b1 || coin_in == 2'b10 && change_take == 1'b1 ||
            beverage_take == 1'b1 && change_take == 1'b1) begin n_beverage_state = not_take; end
    else if(beverage_take == 1'b0) begin n_beverage_state = not_take; end
    else if(beverage_take == 1'b1) begin n_beverage_state = take; end
end

always@(*) begin
    n_state = c_state;
    if(coin_in == 2'b01 && beverage_take == 1'b1 || coin_in == 2'b10 && beverage_take == 1'b1 || 
        coin_in == 2'b01 && change_take == 1'b1 || coin_in == 2'b10 && change_take == 1'b1 || 
        beverage_take == 1'b1 && change_take == 1'b1) begin n_state = n_state; end
    else begin
        case(n_state) 
            S0: begin
                if(change_take == 1'b1 || c_change_state == take) n_state = S0;
                else if(beverage_take == 1'b1) n_state = S0;
                else if(coin_in == 2'b10) n_state = S5; 
                else if(coin_in == 2'b01) n_state = S1; 
            end
            S1: begin
                if(change_take == 1'b1 || c_change_state == take) n_state = S0;
                else if(beverage_take == 1'b1) n_state = S1; 
                else if(coin_in == 2'b10) n_state = S6; 
                else if(coin_in == 2'b01) n_state = S2; 
            end
            S2: begin
                if(change_take == 1'b1 || c_change_state == take) n_state = S1;
                else if(beverage_take == 1'b1) n_state = S2; 
                else if(coin_in == 2'b10) n_state = S7; 
                else if(coin_in == 2'b01) n_state = S3; 
            end
            S3: begin
                if(change_take == 1'b1 || c_change_state == take) n_state = S2;
                else if(beverage_take == 1'b1) n_state = S3; 
                else if(coin_in == 2'b10) n_state = S8; 
                else if(coin_in == 2'b01) n_state = S4; 
            end
            S4: begin
                if(change_take == 1'b1 || c_change_state == take) n_state = S3;
                else if(beverage_take == 1'b1) n_state = S4; 
                else if(coin_in == 2'b10) n_state = S9; 
                else if(coin_in == 2'b01) n_state = S5; 
            end
            S5: begin 
                if(change_take == 1'b1 || c_change_state == take) n_state = S0;
                else if(beverage_take == 1'b1) n_state = S5; 
                else if(coin_in == 2'b10) n_state = S10; 
                else if(coin_in == 2'b01) n_state = S6; 
            end
            S6: begin
                if(change_take == 1'b1 || c_change_state == take) n_state = S1;
                else if(beverage_take == 1'b1) n_state = S6; 
                else if(coin_in == 2'b10) n_state = S11; 
                else if(coin_in == 2'b01) n_state = S7; 
            end
            S7: begin
                if(change_take == 1'b1 || c_change_state == take) n_state = S2;
                else if(beverage_take == 1'b1) n_state = S7; 
                else if(coin_in == 2'b10) n_state = S12; 
                else if(coin_in == 2'b01) n_state = S8; 
            end
            S8: begin
                if(change_take == 1'b1 || c_change_state == take) n_state = S3;
                else if(beverage_take == 1'b1) n_state = S8;
                else if(coin_in == 2'b10) n_state = S13; 
                else if(coin_in == 2'b01) n_state = S9; 
            end
            S9: begin
                if(change_take == 1'b1 || c_change_state == take) n_state = S4;
                else if(beverage_take == 1'b1) n_state = S9; 
                else if(coin_in == 2'b10) n_state = S14; 
                else if(coin_in == 2'b01) n_state = S10; 
            end
            S10: begin
                if(change_take == 1'b1 || c_change_state == take) n_state = S5;
                else if(beverage_take == 1'b1) n_state = S0; 
                else if(coin_in == 2'b10) n_state = S15; 
                else if(coin_in == 2'b01) n_state = S11; 
            end
            S11: begin
                if(change_take == 1'b1 || c_change_state == take) n_state = S6;
                else if(beverage_take == 1'b1) n_state = S1; 
                else if(coin_in == 2'b10) n_state = S16; 
                else if(coin_in == 2'b01) n_state = S12; 
            end
            S12: begin
                if(change_take == 1'b1 || c_change_state == take) n_state = S7;
                else if(beverage_take == 1'b1) n_state = S2; 
                else if(coin_in == 2'b10) n_state = S17; 
                else if(coin_in == 2'b01) n_state = S13; 
            end
            S13: begin
                if(change_take == 1'b1 || c_change_state == take) n_state = S8;
                else if(beverage_take == 1'b1) n_state = S3; 
                else if(coin_in == 2'b10) n_state = S18; 
                else if(coin_in == 2'b01) n_state = S14; 
            end
            S14: begin
                if(change_take == 1'b1 || c_change_state == take) n_state = S9;
                else if(beverage_take == 1'b1) n_state = S4; 
                else if(coin_in == 2'b10) n_state = S19; 
                else if(coin_in == 2'b01) n_state = S15; 
            end
            S15: begin
                if(change_take == 1'b1 || c_change_state == take) n_state = S10;
                else if(beverage_take == 1'b1) n_state = S5; 
                else if(coin_in == 2'b10) n_state = S20; 
                else if(coin_in == 2'b01) n_state = S16; 
            end
            S16: begin
                if(change_take == 1'b1 || c_change_state == take) n_state = S11;
                else if(beverage_take == 1'b1) n_state = S6; 
                else if(coin_in == 2'b10) n_state = S21; 
                else if(coin_in == 2'b01) n_state = S17; 
            end
            S17: begin
                if(change_take == 1'b1 || c_change_state == take) n_state = S12;
                else if(beverage_take == 1'b1) n_state = S7; 
                else if(coin_in == 2'b10) n_state = S22; 
                else if(coin_in == 2'b01) n_state = S18; 
            end
            S18: begin
                if(change_take == 1'b1 || c_change_state == take) n_state = S13;
                else if(beverage_take == 1'b1) n_state = S8;
                else if(coin_in == 2'b10) n_state = S23; 
                else if(coin_in == 2'b01) n_state = S19; 
            end
            S19: begin
                if(change_take == 1'b1 || c_change_state == take) n_state = S14;
                else if(beverage_take == 1'b1) n_state = S9; 
                else if(coin_in == 2'b10) n_state = S24;
                else if(coin_in == 2'b01) n_state = S20;
            end
            S20: begin
                if(change_take == 1'b1 || c_change_state == take) n_state = S15; 
                else if(beverage_take == 1'b1) n_state = S10;
                else if(coin_in == 2'b10) n_state = S25; 
                else if(coin_in == 2'b01) n_state = S21; 
            end
            S21, S22, S23, S24, S25: begin
                if(change_take == 1'b1 || c_change_state == take) n_state = S15; 
                else if(beverage_take == 1'b1) n_state = S10; 
                else if(coin_in == 2'b10) n_state = S25; 
                else if(coin_in == 2'b01) n_state = S21; 
                else n_state = S20;
            end
        endcase
    end
end

always@(*) begin
    n_change_state = c_change_state;

    if(coin_in == 2'b01 && beverage_take == 1'b1 || coin_in == 2'b10 && beverage_take == 1'b1 || 
        coin_in == 2'b01 && change_take == 1'b1 || coin_in == 2'b10 && change_take == 1'b1 || 
        beverage_take == 1'b1 && change_take == 1'b1) begin n_change_state = not_take; end
    else if(c_change_state == take && temp_c_state != S0) begin n_change_state = take; end
    else if(change_take == 1'b0) begin n_change_state = not_take; end 
    else if(change_take == 1'b1) begin n_change_state = take; end
end

always@(c_beverage_state or temp_c_state) begin
    case(c_beverage_state) 
        not_take:
            beverage_out = 1'b0;
        take: 
            case(temp_c_state)
                S0: beverage_out = 1'b0;
                S1: beverage_out = 1'b0;
                S2: beverage_out = 1'b0;
                S3: beverage_out = 1'b0;
                S4: beverage_out = 1'b0;
                S5: beverage_out = 1'b0;
                S6: beverage_out = 1'b0;
                S7: beverage_out = 1'b0;
                S8: beverage_out = 1'b0;
                S9: beverage_out = 1'b0;
                default : beverage_out = 1'b1;
            endcase
    endcase
end

always@(c_state) begin
    case(c_state)
    S0: begin money_account = 5'b00000; end
    S1: begin money_account = 5'b00001; end
    S2: begin money_account = 5'b00010; end
    S3: begin money_account = 5'b00011; end
    S4: begin money_account = 5'b00100; end
    S5: begin money_account = 5'b00101; end
    S6: begin money_account = 5'b00110; end
    S7: begin money_account = 5'b00111; end
    S8: begin money_account = 5'b01000; end
    S9: begin money_account = 5'b01001; end 
    S10: begin money_account = 5'b01010; end
    S11: begin money_account = 5'b01011; end
    S12: begin money_account = 5'b01100; end
    S13: begin money_account = 5'b01101; end
    S14: begin money_account = 5'b01110; end
    S15: begin money_account = 5'b01111; end
    S16: begin money_account = 5'b10000; end
    S17: begin money_account = 5'b10001; end
    S18: begin money_account = 5'b10010; end
    S19: begin money_account = 5'b10011; end
    S20: begin money_account = 5'b10100; end
    S21: begin money_account = 5'b10100; end
    S22: begin money_account = 5'b10100; end
    S23: begin money_account = 5'b10100; end
    S24: begin money_account = 5'b10100; end
    S25: begin money_account = 5'b10100; end
    endcase
end 

always@(c_change_state or temp_c_state or c_state) begin
    case(c_change_state)
    not_take:
        case(c_state) 
            S21: begin change_out = 2'b01; end
            S22: begin change_out = 2'b01; end
            S23: begin change_out = 2'b01; end
            S24: begin change_out = 2'b01; end
            S25: begin change_out = 2'b10; end
            default : change_out = 2'b00;
        endcase
    take:
        case(temp_c_state)
        S0: begin change_out = 2'b00; end
        S1: begin change_out = 2'b01; end
        S2: begin change_out = 2'b01; end
        S3: begin change_out = 2'b01; end
        S4: begin change_out = 2'b01; end
        S5: begin change_out = 2'b10; end
        S6: begin change_out = 2'b10; end
        S7: begin change_out = 2'b10; end
        S8: begin change_out = 2'b10; end
        S9: begin change_out = 2'b10; end 
        S10: begin change_out = 2'b10; end
        S11: begin change_out = 2'b10; end
        S12: begin change_out = 2'b10; end
        S13: begin change_out = 2'b10; end
        S14: begin change_out = 2'b10; end
        S15: begin change_out = 2'b10; end
        S16: begin change_out = 2'b10; end
        S17: begin change_out = 2'b10; end
        S18: begin change_out = 2'b10; end
        S19: begin change_out = 2'b10; end
        S20: begin change_out = 2'b10; end
        S21: begin change_out = 2'b10; end
        S22: begin change_out = 2'b10; end
        S23: begin change_out = 2'b10; end
        S24: begin change_out = 2'b10; end
        S25: begin change_out = 2'b10; end
        endcase
    endcase
end

endmodule
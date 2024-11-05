`timescale 1ns/1ns
module vm_tb;

reg [1:0]coin_in;
reg beverage_take;
reg change_take;
reg clk;
reg rstn;
wire [4:0] money_account;
wire beverage_out;
wire [1:0]change_out;

vm u_vm(
    .coin_in(coin_in),
    .beverage_take(beverage_take),
    .change_take(change_take),
    .clk(clk),
    .rstn(rstn),
    .money_account(money_account),
    .beverage_out(beverage_out),
    .change_out(change_out)
);

always 
    #5 clk = ~clk;

initial begin
    $dumpfile("vm.vcd");
    $dumpvars(0);
end

initial begin
    rstn = 1'b0; coin_in = 2'b00; clk = 1'b0; beverage_take = 1'b0; change_take = 1'b0;
    #10 rstn = 1;

    /*
        요구사항 1 : 여러 입력이 들어오는 경우 아무런 동작을 수행하지 않는다.

        1. 잔돈 반환과 동전 입력이 동시에 입력으로 들어온 경우
        2. 음료 호출과 잔돈 반환이 동시에 입력으로 들어온 경우
        3. 음료 호출과 동전 입력이 동시에 입력으로 들어온 경우
        4. 음료 호출과 잔돈 반환과 동전 입력이 모두 동시에 입력으로 들어온 경우
    */    
    @(posedge clk) coin_in = 2'b10; beverage_take = 1'b0; change_take = 1'b0;
    @(posedge clk) coin_in = 2'b10; beverage_take = 1'b0; change_take = 1'b0; 
    @(posedge clk) coin_in = 2'b01; beverage_take = 1'b0; change_take = 1'b1;
    @(posedge clk) coin_in = 2'b00; beverage_take = 1'b1; change_take = 1'b1;
    @(posedge clk) coin_in = 2'b01; beverage_take = 1'b1; change_take = 1'b0; 
    @(posedge clk) coin_in = 2'b01; beverage_take = 1'b1; change_take = 1'b1;

    @(posedge clk) coin_in = 2'b00; beverage_take = 1'b0; change_take = 1'b0;
    @(posedge clk) coin_in = 2'b00; beverage_take = 1'b0; change_take = 1'b0;
   

   /*
        요구사항 2 : 자판기에 20,000원을 초과해서 넣을 수 없다. 
                    만약 자판기에 20,000원을 초과하여 돈이 들어온다면 20,000원을 초과하여 오르지 않고 초과된 돈의 양만큼 잔돈으로 반환된다.
   */
   // 자판기에 21,000원이 들어온 경우
    @(posedge clk) coin_in = 2'b10; beverage_take = 1'b0; change_take = 1'b0;
    @(posedge clk) coin_in = 2'b10; beverage_take = 1'b0; change_take = 1'b0;
    @(posedge clk) coin_in = 2'b01; beverage_take = 1'b0; change_take = 1'b0;

    // 자판기에 25,000원이 들어온 경우
    @(posedge clk) coin_in = 2'b10; beverage_take = 1'b0; change_take = 1'b0;

    @(posedge clk) coin_in = 2'b00; beverage_take = 1'b0; change_take = 1'b0;
    @(posedge clk) coin_in = 2'b00; beverage_take = 1'b0; change_take = 1'b0;


    /*
        요구사항 3 : 자판기의 돈이 음료의 가격(10,000원)보다 적을 경우 뽑을 수 없다.
    */
    // 음료 호출 2번
    @(posedge clk) coin_in = 2'b00; beverage_take = 1'b1; change_take = 1'b0;
    @(posedge clk) coin_in = 2'b00; beverage_take = 1'b1; change_take = 1'b0;

    // 5,000원 동전 입력
    @(posedge clk) coin_in = 2'b10; beverage_take = 1'b0; change_take = 1'b0;
    // 자판기의 돈이 10,000원보다 적을 때 음료 호출
    @(posedge clk) coin_in = 2'b00; beverage_take = 1'b1; change_take = 1'b0;


    @(posedge clk) coin_in = 2'b00; beverage_take = 1'b0; change_take = 1'b0;
    @(posedge clk) coin_in = 2'b00; beverage_take = 1'b0; change_take = 1'b0;

    /*
        요구사항 4 : 잔돈을 반환할 때 5,000원이 반환이 가능하면 5,000원을 반환하고, 불가능하다면 1,000원을 반환한다.
    */
    // 자판기의 돈이 13,000원 일 때 음료 호출한 후 잔돈 반환 -> 3,000원이 반환되어야하므로 1,000원이 3번 반환
    @(posedge clk) coin_in = 2'b10; beverage_take = 1'b0; change_take = 1'b0;
    @(posedge clk) coin_in = 2'b01; beverage_take = 1'b0; change_take = 1'b0;
    @(posedge clk) coin_in = 2'b01; beverage_take = 1'b0; change_take = 1'b0;
    @(posedge clk) coin_in = 2'b01; beverage_take = 1'b0; change_take = 1'b0;
    @(posedge clk) coin_in = 2'b00; beverage_take = 1'b1; change_take = 1'b0;
    @(posedge clk) coin_in = 2'b00; beverage_take = 1'b0; change_take = 1'b1;
    @(posedge clk) coin_in = 2'b10; beverage_take = 1'b0; change_take = 1'b0;

    @(posedge clk) coin_in = 2'b00; beverage_take = 1'b0; change_take = 1'b0;
    @(posedge clk) coin_in = 2'b00; beverage_take = 1'b0; change_take = 1'b0;
    @(posedge clk) coin_in = 2'b00; beverage_take = 1'b0; change_take = 1'b0;

    // 자판기의 돈이 18,000원 일 때 음료 호출한 후 잔돈 반환 -> 8,000원이 반환되어야하므로 5,000원 한번과 1,000원이 3번 반환
    @(posedge clk) coin_in = 2'b10; beverage_take = 1'b0; change_take = 1'b0;
    @(posedge clk) coin_in = 2'b10; beverage_take = 1'b0; change_take = 1'b0;
    @(posedge clk) coin_in = 2'b10; beverage_take = 1'b0; change_take = 1'b0;
    @(posedge clk) coin_in = 2'b01; beverage_take = 1'b0; change_take = 1'b0;
    @(posedge clk) coin_in = 2'b01; beverage_take = 1'b0; change_take = 1'b0;
    @(posedge clk) coin_in = 2'b01; beverage_take = 1'b0; change_take = 1'b0;
    @(posedge clk) coin_in = 2'b00; beverage_take = 1'b1; change_take = 1'b0;
    @(posedge clk) coin_in = 2'b00; beverage_take = 1'b0; change_take = 1'b1;


    @(posedge clk) coin_in = 2'b00; beverage_take = 1'b0; change_take = 1'b0;
    @(posedge clk) coin_in = 2'b00; beverage_take = 1'b0; change_take = 1'b0;
    #50$finish;
end

endmodule
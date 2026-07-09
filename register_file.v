module register_file(
input wire reset,
input wire clock,
input wire we3,
input wire [4:0] a1,
input wire [4:0] a2,
input wire [4:0] a3,
input wire [31:0] wd3,
output reg [31:0] rd1,
output reg [31:0] rd2
);

integer i;
reg [31:0] Q[0:31];

always @(posedge clock or posedge reset) begin
    if (reset) begin
        for (i = 0; i < 32; i = i + 1)
            Q[i] <= 32'b0;
    end

    else begin
	if (we3 == 1'b1 && a3!= 5'b0)
		Q[a3] <= wd3;
    end
end

always @(*) begin

    rd1 = (a1 == 5'd0) ? 32'b0 : Q[a1];
    rd2 = (a2 == 5'd0) ? 32'b0 : Q[a2];

end

endmodule 
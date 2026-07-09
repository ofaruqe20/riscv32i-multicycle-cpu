module zero_extend
#(
    parameter WIDTH = 8,
    parameter ZEROS = 24
)
(
    input  wire [WIDTH-1:0] a,
    output wire [WIDTH+ZEROS-1:0] ZeroExt
);

assign ZeroExt = {{ZEROS{1'b0}}, a};

endmodule
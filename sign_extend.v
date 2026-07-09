module sign_extend
#(
 parameter WIDTH = 8, SIGNS = 24
)
(
input wire [WIDTH-1:0] a,
output wire [WIDTH+SIGNS-1:0] SignExt
);

assign SignExt = {{SIGNS{a[WIDTH-1]}}, a};


endmodule
module branch_unit(Branch,flags,funct3,taken);

   input [3:0] flags; //{v, c, n, z}
   input [2:0] funct3;
   input Branch;
   output taken;
   reg Condition;
   assign taken = Branch & Condition;

   always @(*)
   begin
	case(funct3)
		3'b000:
		begin
			if (flags[0] == 1'b1)
				Condition <=1'b1;
			else
				Condition <=1'b0;
		end
		3'b001:
		begin
			if (flags[0] == 1'b0)
				Condition <=1'b1;
			else
				Condition <=1'b0;
		end
		3'b100:
		begin
			if (flags[1] == 1'b1 && flags[3] == 1'b0)
				Condition <= 1'b1;
			else if (flags[1] == 1'b0 && flags[3] == 1'b1)
				Condition <= 1'b1;
			else
				Condition <= 1'b0;
		end
		3'b101:
		begin
			if (flags[1] == 1'b1 && flags[3] == 1'b0)
				Condition <= 1'b0;
			else if (flags[1] == 1'b0 && flags[3] == 1'b1)
				Condition <= 1'b0;
			else
				Condition <= 1'b1;
		end
		3'b110:
		begin
			if (flags[2] == 1'b0)
				Condition <= 1'b1;
			else
				Condition <= 1'b0;
		end
		3'b111:
		begin
			if (flags[2] == 1'b1)
				Condition <= 1'b1;
			else
				Condition <= 1'b0;
		end
		default: Condition <= 1'b0;
	endcase
        end
endmodule

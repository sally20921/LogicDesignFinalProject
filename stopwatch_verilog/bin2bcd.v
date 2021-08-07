module bin2bcd
(
	input [7:0] binary,
	output reg [3:0] Hundreds,
	output reg [3:0] Tens,
	output reg [3:0] Ones
);

integer i;

always @(binary)
begin
	Hundreds = 4'b0;
	Tens = 4'b0;
	Ones = 4'b0;
	
	for(i=7; i>=0; i=i-1)
	begin
		if(Hundreds >= 5)
			Hundreds = Hundreds + 3;
		if(Tens >= 5)
			Tens = Tens + 3;
		if(Ones >= 5)
			Ones = Ones + 3;
		
		Hundreds = Hundreds << 1;
		Hundreds[0] = Tens[3];
		Tens = Tens << 1;
		Tens[0] = Ones[3];
		Ones = Ones << 1;
		Ones[0] = binary[i];
	end
end

endmodule
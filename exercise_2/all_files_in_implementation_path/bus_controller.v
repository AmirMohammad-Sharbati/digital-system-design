module bus_controller (
	input wire req1, req2,		// request of device1 and device2 to drive
	input wire clk, rst,
	output reg grant1, grant2 	// when grant1 = 1, device1 may drive. (similar for grant2)
);


	always @(posedge clk or posedge rst) begin
		if (rst) begin
			grant1 <= 1'b0;
			grant2 <= 1'b0;
		end 
		
		else begin	 // simple priority: if both request, 1 wins
      		if (req1) begin
				grant1 <= 1;
				grant2 <= 0;
			end
      		else if (req2) begin
				grant1 <= 0;
				grant2 <= 1;
			end
      		else begin
				grant1 <= 0;
				grant2 <= 0;
			end
		end
	end
endmodule

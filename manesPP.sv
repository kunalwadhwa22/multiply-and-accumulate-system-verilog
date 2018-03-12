


module part2_mac (a, b, clk, reset, valid_in, valid_out, f, overflow);
	
	input logic signed [7:0] a, b;
	input logic clk, reset, valid_in;

	logic enable_f, overflow0;
	logic signed [7:0] Input1, Input2;
	logic signed [15:0] Feedback, Sum, Product, Product0, Product_prev,f0;

	output logic signed [15:0] f;
	output logic overflow, valid_out;

////// control box


always_ff @(posedge clk) begin
	
	

/*
end
	
// AB_FlipFlop
always_ff @(posedge clk) begin
*/
	if (reset == 1)	begin
		Input1 <= 0;
		Input2 <= 0;
	end
	else  begin
		if (valid_in == 1) begin 
			Input1 <= a;
			Input2 <= b;
			enable_f <= 1;
		end
		else begin
			Input1 <= a;
			Input2 <= b;
			enable_f <= 0;
		end
	end
end

//MAC + Overflow





always_comb begin
	if (reset==1) begin
		//overflow=0;
		//overflow0=0;
		//Sum=0;
		Product_prev=0;
		Product0=0;
		//Feedback=0;
		//f0=0;
	end
	else if (reset==0) begin
			
		if (enable_f == 1) begin
			Product_prev = Input1*Input2;
			//Sum=  Product + Feedback;
			//Feedback = Sum;
			Product0 = Product_prev;
			//f0 = Sum;
			/*
			//if ((Product[15]==0&&Feedback[15]==0)||(Product[15]==1&&Feedback[15]==1))
			//if (Feedback>0 && Product>0&& Sum<0) begin
			//if ((Product>0 && Feedback>0 && Sum<0) || (Product <0 && Feedback<0 && Sum >0) || overflow0==1) begin
			if ((Product[15]==0&& Sum[15]==0&&overflow1==1)||(Product[15]==1&& Sum[15]==1&&overflow1==0)|| overflow0==1) begin
			overflow0 = 1;				
			overflow = 1;
			end
			else
			overflow = 0; */
		end
		else begin
			Product_prev = Product0;
			//Sum = Feedback;
			//overflow = overflow;
		end
	end
end


always_ff@(posedge clk) begin
				if (reset==1)
				begin
					Product<=0; 
				end 
				else if (reset==0 && enable_f ==1)
					
					Product<=Product_prev;
				else 
					Product<=Product;				
				
			end


always_comb begin
	if (reset==1) begin
		//overflow=0;
		//overflow0=0;
		Sum=0;
		//Product=0;
		//Product0=0;
		Feedback=0;
		f0=0;
	end
	else if (reset==0) begin
			
		if (enable_f == 1) begin
		//	Product = Input1*Input2;
			Sum=  Product + Feedback;
			Feedback = Sum;
		//	Product0 = Product;
			f0 = Sum;
			/*
			//if ((Product[15]==0&&Feedback[15]==0)||(Product[15]==1&&Feedback[15]==1))
			//if (Feedback>0 && Product>0&& Sum<0) begin
			//if ((Product>0 && Feedback>0 && Sum<0) || (Product <0 && Feedback<0 && Sum >0) || overflow0==1) begin
			if ((Product[15]==0&& Sum[15]==0&&overflow1==1)||(Product[15]==1&& Sum[15]==1&&overflow1==0)|| overflow0==1) begin
			overflow0 = 1;				
			overflow = 1;
			end
			else
			overflow = 0; */
		end
		else begin
		//	Product = Product0;
			Sum = Feedback;
			//overflow = overflow;
		end
	end
end















/*always_ff @(posedge clk) begin
	if ((Product[15]==0&& Feedback[15]==0&&Sum[15]==1)||(Product[15]==1&& Feedback[15]==1&&Sum[15]==0)|| overflow0==1) begin
	overflow0 <= 1;				
	overflow <= 1;
	end
	else
	overflow <= 0;
end*/

always_ff @(posedge clk) begin
	if(reset==1)
		begin		
		f<=0;
		overflow<=0;
		valid_out=0;
		end
			//else overflow=0;
	else if (enable_f==1 && reset==0)
		begin
 			f<=f0;
			valid_out<=1;
			if ((Product[15]==0&& f[15]==0&&f0[15]==1)||(Product[15]==1&& f[15]==1&&f0[15]==0)|| overflow==1) begin
		 	overflow<=1;
			//overflow0<=1;
			end
			else 
			overflow<=0;
		end 
	else 	begin 
		f<=f;
		valid_out <= 0;
end
end
endmodule




/*
//Overflow detector
always_ff @(posedge clk) begin

		if (reset == 1)	begin
			//overflow0= 0;
			//overflowFB = 0;
			flag=0;
			overflow=0;
				end
		else if ((Overflow0==1 || flag==1) && reset==0) begin
			overflow=1;
			flag=1;
		end
		else
			overflow = 0;
	
	
		end


//output from the last flip flop
	always_ff @(posedge clk) begin
		if (reset == 1)	begin
			f = 0;
			valid_out=0;
				end
		else if (enable_f == 1) begin 
			f=Sum;
			valid_out=1;
					end
		else		begin
			f=f;
			valid_out=0;
			end
end



endmodule

*/



module tb_FF_comb();

	logic signed [7:0] a, b;
	reg clk, reset;
	logic valid_in;
	//logic signed [7:0]  Input1, Input2;
	//logic [15:0] Feedback;
	wire signed[15:0] f;
	wire overflow,valid_out;
 
   FF_comb dut(a, b, clk, reset, valid_in,valid_out, f, overflow);
   
   // Initialize the clock to zero.
   initial
begin
//f=0;
      clk = 0;
	reset=1;
valid_in=1;
end
   // Make the clock oscillate: every 5 time units, it changes its value.
   always
      #2 clk = ~clk;

always 
#256 reset = ~ reset;
//   integer i;

   initial begin
      $monitor($time,,"a = %d, b = %d, clk= %b, reset= %b, valid_in=%d, valid_out=%d, f = %d, overflow= %d", a, b, clk, reset, valid_in, valid_out, f, overflow);
   
      a = -100;
      b = 120;





#1024;
      $finish; // Stop simulation
   end
endmodule



module TBpart2_mac();

   logic clk, reset, valid_in, valid_out, overflow;
   logic signed [7:0] a, b;
   logic signed [15:0] f;



part2_mac dut(.clk(clk), .reset(reset), .a(a), .b(b), .valid_in(valid_in), .f(f), .overflow(overflow), .valid_out(valid_out));

   initial clk = 0;
   always #5 clk = ~clk;

   initial begin

      // Before first clock edge, initialize
      reset = 1;
      {a, b} = {8'b0,8'b0};
      valid_in = 0;

      @(posedge clk);
      #1; // After 1 posedge
      reset = 0; a = 1; b = 1; valid_in = 0;
      @(posedge clk);
      #1; // After 2 posedges
      a = 2; b = 2; valid_in = 1;
      @(posedge clk);
      #1; // After 3 posedges
      a = 3; b = 3; valid_in = 1;
      @(posedge clk);
      #1; // After 4 posedges
      a = 4; b = 4; valid_in = 0;
      @(posedge clk);
      #1; // After 5 posedges
      a = 5; b = 5; valid_in = 0;
      @(posedge clk);
      #1; // After 6 posedges
      a = 6; b = 6; valid_in = 1;
	
	

   end // initial begin

   initial begin
      @(posedge clk);
      #1; // After 1 posedge
	$display("valid_in = %b. ", valid_in);
      $display("valid_out = %b. Expected value is 0.", valid_out);
      $display("f = %d. Expected value is 0.", f);
 
      @(posedge clk);
      #1; // After 2 posedges
$display("valid_in = %b. ", valid_in);
      $display("valid_out = %b. Expected value is 0.", valid_out);
      $display("f = %d. Expected value is 0.", f);

      @(posedge clk);
      #1; // After 3 posedges
$display("valid_in = %b. ", valid_in);
      $display("valid_out = %b. Expected value is 0.", valid_out);
      $display("f = %d. Expected value is 0.", f);

      @(posedge clk);
      #1; // After 4 posedges
$display("valid_in = %b. ", valid_in);
      $display("valid_out = %b. Expected value is 1.", valid_out);
      $display("f = %d. Expected value is 4.", f);

      @(posedge clk);
      #1; // After 5 posedges
$display("valid_in = %b. ", valid_in);
      $display("valid_out = %b. Expected value is 1.", valid_out);
      $display("f = %d. Expected value is 13.", f);

      @(posedge clk);
      #1; // After 6 posedges
$display("valid_in = %b. ", valid_in);
      $display("valid_out = %b. Expected value is 0.", valid_out);
      $display("f = %d. Expected value is don't care (probably will be 13 in your design).", f);

      @(posedge clk);
      #1; // After 7 posedges
$display("valid_in = %b. ", valid_in);
      $display("valid_out = %b. Expected value is 0.", valid_out);
      $display("f = %d. Expected value is is don't care (probably will be 13 in your design).", f);

      @(posedge clk);
      #1; // After 8 posedges
$display("valid_in = %b. ", valid_in);
      $display("valid_out = %b. Expected value is 1.", valid_out);
      $display("f = %d. Expected value is 49.", f);






      $finish;
   end

endmodule // tb_part2_mac










with text_io;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
use text_io;
with sort;
use sort;

procedure main is
	
	num:subArray;
	sum: integer :=0;
	task printer is
		entry print;
		entry printSort;
		entry printSum;
	end printer;
	
	task sorting is	
		entry sort;
	end sorting;
	
	task adder is
		entry startAdd;
	end adder;
	
	task body printer is
	begin
		accept print do
			put("The numbers in the array are as follows:");
			new_line;
			for j in 1..num'length
			loop
				put(num(j));
			end loop;
			sorting.sort;
		end print;
		
		accept printSort do
			new_line;
			put("The numbers in the sorted array are as follows:");
			new_line;
			for j in 1..num'length
			loop
				put(num(j));
			end loop;
		end printSort;
		
		accept printSum do
			--printing the sum
			new_line;
			put("The sum of the array elements is = ");
			put(sum);
		end printSum;
		
	end printer;
	
	task body sorting is 
	startIndex: integer;
	endIndex : integer;
	begin	
		accept sort do
			startIndex := 1;
			endIndex := 30;
			quickSort(num,startIndex,endIndex);
		end sort;
			printer.printSort;
			adder.startAdd;
	end sorting;
	
	task body adder is 
	begin
		accept startAdd do
			for i in 1..num'length
			loop
				sum := sum+num(i);
			end loop;
		end startAdd;
		printer.printSum;
	end adder;	
	
	
	begin	
		for i in 1..30
		loop
			Ada.Integer_Text_IO.Get(num(i));
		end loop;
		printer.print;
end main;

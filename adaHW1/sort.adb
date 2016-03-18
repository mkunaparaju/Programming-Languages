with text_io;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
use text_io;

package body sort is

	procedure quickSort(numbers: in out subArray; startIndex, endIndex :in out integer) is
	m: integer;
	temp: integer;
	middleIndex: integer;
	i: integer;
	j: integer;
	procedure sorting(numbers:in out subArray; startIndex, middleIndex, endIndex: in out integer) is
	
		task sortFirst;
		task sortSecond;
		newIndex:integer;
		task body sortFirst is
		begin
			quickSort(numbers, startIndex, middleIndex);
		end sortFirst;
		
		task body sortSecond is
		begin
			if(middleIndex = endIndex) then -- if there is just one element in the array
				newIndex := endIndex;
			else
				newIndex := middleIndex+1;
			end if;
			newIndex := middleIndex+1;
			quickSort(numbers, newIndex, endIndex);
		end sortSecond; 
	
	begin	
		put("");
	end sorting;
	
	procedure split(startIndex, endIndex :in out integer) is
		begin
			i :=startIndex;
			j := endIndex;
		if endIndex-startIndex = 1 then --if there are just two elements in the array
			if numbers(startIndex) < numbers(endIndex) then
				m := numbers(startIndex);
				middleIndex := startIndex;
			else
				m := numbers(endIndex);
				middleIndex := endIndex;
			end if;
		else
			middleIndex := (i+j)/2;
			
			if(numbers(i)<numbers(middleIndex)) then
				if(numbers(middleIndex)<numbers(j)) then
					m := numbers(middleIndex);
					middleIndex := middleIndex;
				else
					m := numbers(j);
					middleIndex := j;
				end if;
			else
				if(numbers(middleIndex)>numbers(i)) then
					m := numbers(j);
					middleIndex := j;
				else
					m := numbers(middleIndex);
					middleIndex := middleIndex;
				end if;
			end if;
		end if;
	
		while(i < j)
		loop
			while(numbers(i) < m)
			loop
				i := i+1;
			end loop;
			while(numbers(j) > m)
			loop
				j := j-1;
			end loop;
			
			if(i<j) then
				--Swap the elements
				temp := numbers(j);
				numbers(j) := numbers(i);
				numbers(i) := temp;
			end if;
		end loop;
		
		--To correct the index of the median value
		for n in startIndex..endIndex
		loop
			if(numbers(n) = m) then
				middleIndex := n;
			end if;
		end loop;
		
		sorting(numbers, startIndex,middleIndex, endIndex);
	end split;
	  begin	
		if startIndex = endIndex then
			return;
		else
			split(startIndex, endIndex);
		end if;
	end quickSort;
end sort;

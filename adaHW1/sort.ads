package sort is
	type subArray is array(1..30) of integer;
	procedure quickSort(numbers: in out subArray; startIndex, endIndex : in out integer);
end sort;

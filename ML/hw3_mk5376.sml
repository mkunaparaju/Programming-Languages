Control.Print.printDepth := 100;
Control.Print.printLength := 100;

(* Question 1 *)
	fun insertInt n L=
	if null(L) then [n]
	 else if (n < hd(L)) then n::L
	else hd(L) :: insertInt n (tl(L));

					  
(* Question 2*)
fun sortInt L=
if null(L) then L
else insertInt (hd(L)) (sortInt(tl (L)));

			  
(*Question 3*)

fun sort (op <) [] = []
|     sort (op <) (x::xs)=
let fun insert(x, []) = [x]
| insert(x,y::ys)=
      if x<y then x::y::ys
      else y::insert(x,ys)
in insert(x, sort(op < ) xs)
end
;

(* Question 4 *)
fun reduce f b nil=b
| reduce f b (head::tail) = f(head, reduce f b tail)
;

(* Question 5 *)
datatype 'a tree = leaf of 'a | node of 'a tree list;

(*Question 6*)
  fun fringe (leaf x) = [x]
  | fringe (node rest) = reduce (op @) (fringe (hd rest)) (map fringe (tl rest));
  
(*Question 7 *)
      fun mapTree f (node x) = node (map (mapTree f) x)
|     mapTree f (leaf x) = leaf(f x);

(*Question 8 *)
fun sortTree (op < ) (leaf unsortedList) = leaf (sort (op < ) unsortedList)
| sortTree (op <) (node listOfTrees) = node (map (fn x => (sortTree (op <) x))listOfTrees);

(*Question 9*)
(*Helper Function*)
fun helperMerge (op <) [] [] L3 = L3
 | helperMerge (op <) [] L2 L3 = L3 @ L2
 | helperMerge (op <) L1 [] L3 = L3 @ L1
 | helperMerge (op <) (x::xs) (y::ys) L3 = 
     if (x < y) then (helperMerge (op <) xs (y::ys) (L3 @ [x]))
     else (helperMerge (op <) (x::xs) ys (L3 @ [y])) 

(*Call helper "helperMerge" because we want a 3rd list to keep track of
 * everything already sorted through*)
fun merge _ [] L2 = L2
 | merge _ L1 [] = L1
 | merge (op <) L1 L2 = helperMerge (op <) L1 L2 []
 
(*Question 10*)

fun mergeTree (op <) (leaf L1) = sort (op<) L1
| mergeTree (op <) (node rest) = reduce (fn(x,y) => merge(op <) x y )
(mergeTree (op <) (hd rest)) (map (fn x => mergeTree (op <)(sortTree(op <) x )) (tl rest));
	


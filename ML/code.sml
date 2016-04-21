Control.Print.printDepth := 100;
Control.Print.printLength := 100;



val example1 = insertInt 13 [8,10,12,14,16]

val example2 = sortInt [7,3,9,2,1,10,13,6]

val example3 = sort (op <) [1,9, 3, 6, 7]

val example4 = sort (fn(a,b) => length a < length b) [[1, 9, 3, 6], [1], [2,4,6], [5,5]]

val example5 = reduce (op +) 0 [1,2,3,4]

val example6 = reduce (op @) [] [[1,2,3,4],[5,6],[7,8,9]]

val myTree = node [node [node [leaf [4,2,14],leaf [9,83,32],leaf [96,123,4]],
                         node [leaf [47,71,82]],node [leaf [19,27,10],
                                                      leaf [111,77,22,66]],
                         leaf [120,42,16]],
                   leaf [83,13]]
val example7 = fringe (node [leaf 3, node [leaf 4, leaf 5], leaf 6])

val example8 = fringe myTree

val example9 = mapTree (fn x => x+100) (node [leaf 1 ,leaf 2, node [leaf 3,leaf 4]])

val example10 = mapTree (fn L => reduce (op +) 0 L) myTree

val example11 = sortTree (op <) (node [leaf [5,7,3], node [leaf [9,1,4],leaf[6,10,2]]])

val example12 = sortTree (fn (L1,L2) => length L1 < length L2) 
                         (node [leaf [[1,2],[3],[4,5,6]], 
                                leaf [[10,11,12], [13,14],[15]],
                                node [leaf [[17],[18,19,20],[21,22]]]])

val example13 = merge (op <) [2,4,6,8] [1,3,5,7]

val example14 = merge (op >) [8,6,4,2] [7,5,3,1]

val example15 = mergeTree (op <) myTree

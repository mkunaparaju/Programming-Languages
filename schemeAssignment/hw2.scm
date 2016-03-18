;; (everyother n m) returns the list of every other integer starting with n up to m.
;; Base Case: if (n > m), result is the empty list
;; Hypothesis: Assume (everyother (+ n 2) m) returns the list of every other integer from n+2 up to m.
;; Recursive step: (everyother n m) returns (cons n (everyother (+ n 2) m))

(define (eachother n m)
    (cond ((> n m) '())
          (else (cons n (eachother (+ n 2) m)))))

;; (flatten L) returns a flattened list of nestested lists
;; Base Case: If the list L is empty return an empty list; if the list is not a pair of it's car and cdr then we return the list. This will return single numbers.
;; Hypotheses: Assume (flatten (car L)) (flatten (cdr L)) return flattened lists of L's car and cdr.
;; Recusive step: appending the (flatten (car L)) (flatten (cdr L)) which will recusively call the flatten function on the elements. 
(define (flatten L)
    (cond ((null? L) '())
          ((not (pair? L)) (list L))
          (else (append (flatten (car L)) (flatten (cdr L))))))

;;(all-reverse L) returns a list of reversed elemets, even those within nested lists.
;; Base Case: When the list is empty return the empty list
;; Hypothesis: Assume that (all-reverse (car L)) and (all-reverse (cdr L)) will completely reverse the list inclucing the nested lists
;; Recursive Step: If the (car L) is a list then we recursively call the all-reverse on the (car L) and (cdr L) and append them in reverse order.
;; if it not a list then recursively call call the all-reverse on (cdr L) and apend it to (car L)
(define (all-reverse L)
  (cond ((null? L) L)
        ((list? (car L))
         (append (all-reverse (cdr L)) (list (all-reverse (car L)))))
        (else (append (all-reverse (cdr L)) (list (car L))))))

;;(myequal L1 L2) returns whether both the lists(L1, L2) are the same
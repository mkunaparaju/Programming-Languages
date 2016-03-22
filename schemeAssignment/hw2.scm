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
;; base case: when both list empty, return true. when only either is empty return false
;;hypothesis: myequal? works for the seperated lists of l1 and l2 into their car and cdr
;; Recursive step: calling my equal on the car and cdr of the lists
(define (myequal? l1 l2)
  (cond ((and (null? l1) (null? l2)) #t)
        ((or (null? l1) (null? l2)) #f)
        ((not (and (list? l1) (list? l2))) (eq? l1 l2))
        (else (and (myequal? (car l1) (car l2)) (myequal? (cdr l1) (cdr l2))))))


;; (compare-fns f1 fn2 domain) returns whether both the functions will return the same value or not for a set of values.
;;Base case: when the domain is empty, return true
;;hypothesis:: calling the function on the (cdr domain) will return whether there are any non-matching values
;;recursive step: the compare-fns will be called as long as there is no mismatch between the results of the both the functions on the same domain values
(define (compare-fns fn1 fn2 domain)
  (cond ((null? domain) #t)
        ((not (myequal? (fn1 (car domain)) (fn2 (car domain)))) #f)
        (else (compare-fns fn1 fn2 (cdr domain)))))

;;(same-values fn1 fn2 domain) returns a list of all elements x of domain such that (fn1 x) (fn2 x) return the same values
;;base case: if the domain is nnull, we will return that same domain as the output.
;; hypothesis: same-values function will return a list of values for the (cdr domain)
;;recursive step: if the (car domain) is equal add to the listof value and continue with performing same-values on the (cdr domain)
;; else jut continue with same-values on the (cdr-domain)
(define (same-values fn1 fn2 domain)
  (cond ((null? domain) domain)
        ((myequal? (fn1 (car domain)) (fn2 (car domain))) (cons (car domain) (same-values fn1 fn2 (cdr domain))))
        (else (same-values fn1 fn2 (cdr domain)))))


;;(partition x L) calls an auxillary function which which splits the list into 2 lists, one which contains values less than equal to pivot and one which contains values more than the pivot
;;base case: when the list is null, it returns 2 null lists
;;;hypothesis: partitioning on the (cdr list) will split that list into 2 required lists
;; recursive step : partitioning till we reach the end of the list and apending the values to the split lists
(define (partition x ls)
  (partition-aux ls x '() '()))

(define (partition-aux ls pivot smaller larger)
  (cond
    ((null? ls) (list smaller larger))
    ((<= (car ls) pivot)
     (partition-aux (cdr ls) pivot (append smaller (list (car ls))) larger))
    (else (partition-aux (cdr ls) pivot smaller (append larger (list (car ls)) )))))


;;(define quicksort (lambda (l)
    ;;                (cond ((null? l) l)
                          
      ;;               (else (append (quicksort (car (partition (car l) (cdr l)))) (quicksort (cdr (partition (car l) (cdr l)))))))))
(define sort (lambda (l)
                    (cond ((null? (cdr l)) l)
                          (else
                          (let ((lx (partition (car l) (cdr l))))
                             (append (sort (car lx)) (cons (car l)(sort (cdr lx))) ))))))


;;(apply-to-list f) : returns a function that takes a list as a paremeter and applies the given function to it.
(define (apply-to-list f)
  (lambda (l) (map f l)))


;; (new-apply-to-list f): similar to (apply-to-list f) without using a map function

(define (new-apply-to-list f)
  (lambda (l) (letrec ((ownmap (lambda (f x)
                                 (cond ((null? x) '())
                                       (else (cons (f (car l)) (ownmap f (cdr l))))))))
                 ownmap f l)))



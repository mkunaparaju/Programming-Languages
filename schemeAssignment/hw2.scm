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
;;Hypothesis: 
(define (myequal? l1 l2)
  (cond ((and (null? l1) (null? l2)) #t)
        ((or (null? l1) (null? l2)) #f)
        ((not (and (list? l1) (list? l2))) (eq? l1 l2))
        (else (and (myequal? (car l1) (car l2)) (myequal? (cdr l1) (cdr l2))))))


;; (compare-fns f1 fn2 domain) returns whether both the functions will return the same value or not for a set of values.
(define (compare-fns fn1 fn2 domain)
  (cond ((null? domain) #t)
        ((not (myequal? (fn1 (car domain)) (fn2 (car domain)))) #f)
        (else (compare-fns fn1 fn2 (cdr domain)))))

;;(same-values fn1 fn2 domain) returns a list of all elements x of domain such that (fn1 x) (fn2 x) return the same values
;;(define finalList (list '()))
;;(define (same-values fn1 fn2 domain)
  ;;(cond ((null? domain) #t)
    ;;    (myequal? (fn1 (car domain)) (fn2 (car domain))) ((cons finalList (car domain) ) (same-values fn1 fn2 (cdr domain)))
      ;;   (else (same-values fn1 fn2 (cdr domain)))))




;;(partition x L) splits the list into 2 lists one which has nums less equal to x and greater than x
;;(define less (list '()))
;;(define more (list '())
;;(define (partition x L)
  ;;(cond ((null? L) L)
    ;;    ((null? (cdr L))
      ;;   (cond ((<= (car L) x) (cons (car L) less))
        ;;      (else (cons (car L) more))))
  ;;     ((<= (car L) x) (cons (car L) less) (partition x (cdr L)))
;;       (else (cons (car L) more) (partition x (cdr L)))))


(define partition (lambda (x l)
                    (pHelper l x '() '())))

(define pHelper (lambda (all chk l m)
                  (cond ((null? all) (cons l (cons m '())))
                        (else
                        (let ((y (car all)))
                          (if (<= y chk) 
                              (pHelper (cdr all) chk (cons y l) m)
                              (pHelper (cdr all) chk l (cons y m))))))))


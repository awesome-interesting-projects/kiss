;;; -*- mode: lisp; coding: utf-8 -*- 
;;; test_forms_and_evaluation.lisp --- a bunch of forms with which ISLisp processor must return true.

;; Copyright (C) 2017, 2018 Yuji Minejima <yuji@minejima.jp>

;; This file is part of ISLisp processor KISS.

;; KISS is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; KISS is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;;; https://nenbutsu.github.io/ISLispHyperDraft/islisp-v23.html#functions


;;; functionp
(functionp (function car))
(functionp (function create))
(functionp (lambda () t))
(not (functionp 'car))
(block top
  (with-handler (lambda (condition)
		  (if (instancep condition (class <arity-error>))
		      (return-from top t)
                    (signal-condition condition nil)))
                (functionp))
  nil)
(block top
  (with-handler (lambda (condition)
		  (if (instancep condition (class <arity-error>))
		      (return-from top t)
                    (signal-condition condition nil)))
                (functionp 'car 'cdr))
  nil)


;;; function
(= (funcall (function -) 3) -3)
(= (apply #'- '(4 3)) 1)
(block top
  (with-handler (lambda (condition)
		  (if (instancep condition (class <arity-error>))
		      (return-from top t)
                    (signal-condition condition nil)))
                (function))
  nil)
(block top
  (with-handler (lambda (condition)
		  (if (instancep condition (class <arity-error>))
		      (return-from top t)
                    (signal-condition condition nil)))
                (function a b))
  nil)
(block top
  (with-handler (lambda (condition)
		  (if (instancep condition (class <undefined-function>))
		      (return-from top t)
                    (signal-condition condition nil)))
                (function no-such-function))
  nil)
(block top
  (with-handler (lambda (condition)
		  (if (instancep condition (class <domain-error>))
		      (return-from top t)
                    (signal-condition condition nil)))
                (function (love me do)))
  nil)
(block top
  (with-handler (lambda (condition)
		  (if (instancep condition (class <domain-error>))
		      (return-from top t)
                    (signal-condition condition nil)))
                (function "car"))
  nil)


;;; lambda
(= ((lambda (x y) (+ (* x x) (* y y))) 3 4) 25)
(equal ((lambda (x y &rest z) z) 3 4 5 6) '(5 6))
(equal ((lambda (x y :rest z) z) 3 4 5 6) '(5 6))
(= (funcall (lambda (x y) (- y (* x y))) 7 3) -18)
(let ((fun (let* ((a 10)
                  (f (lambda (x) (+ x a))))
             f)))
  (= (funcall fun 1) 11))
(null (funcall (lambda ())))
(= 10 (funcall (lambda () 1 2 3 4 5 6 7 8 9 10)))
(= (funcall (lambda (x y &rest z) (apply #'+ x y z)) 1 2 3 4 5) 15)
(block top
  (with-handler (lambda (condition)
		  (if (instancep condition (class <arity-error>))
		      (return-from top t)
                    (signal-condition condition nil)))
                (funcall (lambda (x) x)))
  nil)
(block top
  (with-handler (lambda (condition)
		  (if (instancep condition (class <arity-error>))
		      (return-from top t)
                    (signal-condition condition nil)))
                (funcall (lambda (x y) (+ x y)) 1))
  nil)
(block top
  (with-handler (lambda (condition)
		  (if (instancep condition (class <arity-error>))
		      (return-from top t)
                    (signal-condition condition nil)))
                (funcall (lambda (x y) (+ x y)) 1 2 3))
  nil)



;;; labels
(eq (labels  ((evenp (n)
                     (if (= n 0)
                         t
                       (oddp (- n 1))))
              (oddp (n)
                    (if (= n 0)
                        nil
                      (evenp (- n 1)))))
      (evenp 88))
    t)
(null (labels ((f (x) x))
        ))
(= (labels ((f (x) x))
     (f 10)
     1)
   1)


;;; flet
(= (flet ((f (x) (+ x 3)))
     (flet ((f (x) (+ x (f x))))
       (f 7)))
   17)
(null (flet ((f (x)))
        ))
(= (flet ((f (x) x))
     (f 10)
     1)
   1)


;;; apply
(= (apply (if (< 1 2) (function max) (function min)) 1 2 (list 3 4)) 4)
(defun compose (f g)
  (lambda (:rest args)
    (funcall f (apply g args))))
(= (funcall (compose (function sqrt) (function *)) 12 75) 30)
(= (apply #'+ '(1 2 3 4 5)) 15)
(= (apply #'+ '()) 0)
(= (apply #'+ 1 2 3 4 5 '()) 15)
(block top
  (with-handler (lambda (condition)
		  (if (instancep condition (class <domain-error>))
		      (return-from top t)
                    (signal-condition condition nil)))
                (apply '+ '(1 2 3)))
  nil)
(block top
  (with-handler (lambda (condition)
		  (if (instancep condition (class <domain-error>))
		      (return-from top t)
                    (signal-condition condition nil)))
                (apply "+" '(1 2 3)))
  nil)
(block top
  (with-handler (lambda (condition)
		  (if (instancep condition (class <error>))
		      (return-from top t)
                    (signal-condition condition nil)))
                (apply #'+ 1 2 #(3 4)))
  nil)
(block top
  (with-handler (lambda (condition)
		  (if (instancep condition (class <error>))
		      (return-from top t)
                    (signal-condition condition nil)))
                (apply #'+ 1 2))
  nil)


;;; funcall
(= (let ((x '(1 2 3)))
     (funcall (cond ((listp x) (function car))
                    (t (lambda (x) (cons x 1))))
              x))
   1)
(= (funcall #'+) 0)
(block top
  (with-handler (lambda (condition)
		  (if (instancep condition (class <domain-error>))
		      (return-from top t)
                    (signal-condition condition nil)))
                (funcall '+ 1 2 3))
  nil)
(block top
  (with-handler (lambda (condition)
		  (if (instancep condition (class <domain-error>))
		      (return-from top t)
                    (signal-condition condition nil)))
                (funcall "+" 1 2 3))
  nil)


;;; defconstant
(eq (defconstant constant-a 10) 'constant-a)
(= constant-a 10)
(= (let ((constant-a 2))
     constant-a)
   2)
(block top
  (with-handler (lambda (condition)
		  (if (instancep condition (class <error>))
		      (return-from top t)
                    (signal-condition condition nil)))
                (defconstant))
  nil)
(block top
  (with-handler (lambda (condition)
		  (if (instancep condition (class <error>))
		      (return-from top t)
                    (signal-condition condition nil)))
                (defconstant constant-b))
  nil)
(block top
  (with-handler (lambda (condition)
		  (if (instancep condition (class <error>))
		      (return-from top t)
                    (signal-condition condition nil)))
                (defconstant constant-b 1 2 3))
  nil)


;;; defglobal
(eq (defglobal global-a 10) 'global-a)
(= global-a 10)
(eq (defglobal today 'wednesday) 'today)
(eq today 'wednesday)
(defun what-is-today () today)
(eq (what-is-today) 'wednesday)
(eq (let ((what-is-today 'thursday))
      (what-is-today))
    'wednesday)
(eq (let ((today 'thursday))
      (what-is-today))
    'wednesday)
(block top
  (with-handler (lambda (condition)
		  (if (instancep condition (class <error>))
		      (return-from top t)
                    (signal-condition condition nil)))
                (defglobal))
  nil)
(block top
  (with-handler (lambda (condition)
		  (if (instancep condition (class <error>))
		      (return-from top t)
                    (signal-condition condition nil)))
                (defglobal global-b))
  nil)
(block top
  (with-handler (lambda (condition)
		  (if (instancep condition (class <error>))
		      (return-from top t)
                    (signal-condition condition nil)))
                (defglobal global-b 1 2 3))
  nil)


;;; defdynamic
(eq (defdynamic *color* 'red) '*color*)
(eq (dynamic *color*) 'red)
(defun what-color ()
  (dynamic *color*))
(eq (what-color) 'red)
(eq (dynamic-let ((*color* 'green))
                 (what-color))
    'green)
(block top
  (with-handler (lambda (condition)
		  (if (instancep condition (class <error>))
		      (return-from top t)
                    (signal-condition condition nil)))
                (defdynamic))
  nil)
(block top
  (with-handler (lambda (condition)
		  (if (instancep condition (class <error>))
		      (return-from top t)
                    (signal-condition condition nil)))
                (defdynamic dynamic-b))
  nil)
(block top
  (with-handler (lambda (condition)
		  (if (instancep condition (class <error>))
		      (return-from top t)
                    (signal-condition condition nil)))
                (defdynamic dynamic-b 1 2 3))
  nil)


;;; defun
(eq (defun car-car (x) (car (car x))) 'car-car)
(eq (car-car '((a) b c)) 'a)
(defun fact (n) (if (= n 0) 1 (* n (fact (- n 1)))))
(= (fact 3) 6)
(defun f ())
(null (f))


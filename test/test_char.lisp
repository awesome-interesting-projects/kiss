;;; -*- mode: lisp; coding: utf-8 -*- 
;;; test_char.lisp --- a bunch of forms with which ISLisp processor must return true.

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


;;; characterp

(eq (characterp #\a) 't)
(eq (characterp #\b) 't)
(eq (characterp #\newline) 't)
(eq (characterp #\space) 't)
(eq (characterp 'a) 'nil)
(eq (characterp "a") 'nil)
(eq (characterp #()) 'nil)
(block top
  (mapc (lambda (x)
          (if (not (characterp x))
              (return-from top nil)))
        '(#\! #\" #\# #\$ #\% #\& #\' #\( #\) #\* #\+ #\, #\- #\. #\/
          #\0 #\1 #\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9 #\: #\; #\< #\= #\> #\? 
          #\@ #\A #\B #\C #\D #\E #\F #\G #\H #\I #\J #\K #\L #\M #\N #\O
          #\P #\Q #\R #\S #\T #\U #\V #\W #\X #\Y #\Z #\[ #\\ #\] #\^ #\_
          #\` #\a #\b #\c #\d #\e #\f #\g #\h #\i #\j #\k #\l #\m #\n #\o
          #\p #\q #\r #\s #\t #\u #\v #\w #\x #\y #\z #\{ #\| #\} #\~
          #\space #\newline))
  t)
(block a
  (with-handler (lambda (condition)
		  (if (instancep condition (class <arity-error>))
		      (return-from a t)
                      (signal-condition condition nil)))
    (characterp))
  nil)
(block a
  (with-handler (lambda (condition)
		  (if (instancep condition (class <arity-error>))
		      (return-from a t)
                      (signal-condition condition nil)))
    (characterp #\a #\b))
  nil)
(block a
  (with-handler (lambda (condition)
		  (if (instancep condition (class <arity-error>))
		      (return-from a t)
                      (signal-condition condition nil)))
    (characterp #\a #\b #\c))
  nil)


;;; char=
(eq (char= #\a #\a) 't)
(eq (char= #\a #\b) 'nil)
(eq (char= #\a #\A) 'nil)
(eq (char= #\space #\space) 't)
(eq (char= #\newline #\newline) 't)
(block a
  (with-handler (lambda (condition)
		  (if (instancep condition (class <arity-error>))
		      (return-from a t)
                      (signal-condition condition nil)))
    (char= #\a #\b #\c))
  nil)
(block a
  (with-handler (lambda (condition)
		  (if (instancep condition (class <arity-error>))
		      (return-from a t)
                      (signal-condition condition nil)))
    (char= #\a))
  nil)
(block a
  (with-handler (lambda (condition)
		  (if (instancep condition (class <arity-error>))
		      (return-from a t)
                      (signal-condition condition nil)))
    (char=))
  nil)
(block a
  (with-handler (lambda (condition)
		  (if (instancep condition (class <domain-error>))
		      (return-from a t)
                      (signal-condition condition nil)))
    (char= #\a 'a))
  nil)
(block a
  (with-handler (lambda (condition)
		  (if (instancep condition (class <domain-error>))
		      (return-from a t)
                      (signal-condition condition nil)))
    (char= 'a "b"))
  nil)

;;; char/=
(eq (char/= #\a #\a) 'nil)
(eq (char/= #\a #\b) 't)
(eq (char/= #\a #\A) 't)
(eq (char/= #\space #\space) 'nil)
(eq (char/= #\newline #\newline) 'nil)
(block a
  (with-handler (lambda (condition)
		  (if (instancep condition (class <arity-error>))
		      (return-from a t)
                      (signal-condition condition nil)))
    (char/= #\a #\b #\c))
  nil)
(block a
  (with-handler (lambda (condition)
		  (if (instancep condition (class <arity-error>))
		      (return-from a t)
                      (signal-condition condition nil)))
    (char/= #\a))
  nil)
(block a
  (with-handler (lambda (condition)
		  (if (instancep condition (class <arity-error>))
		      (return-from a t)
                      (signal-condition condition nil)))
    (char/=))
  nil)
(block a
  (with-handler (lambda (condition)
		  (if (instancep condition (class <domain-error>))
		      (return-from a t)
                      (signal-condition condition nil)))
    (char/= #\a 'a))
  nil)
(block a
  (with-handler (lambda (condition)
		  (if (instancep condition (class <domain-error>))
		      (return-from a t)
                      (signal-condition condition nil)))
    (char/= 'a "b"))
  nil)


;;; char<
(eq (char< #\0 #\1) 't)
(eq (char< #\1 #\2) 't)
(eq (char< #\2 #\3) 't)
(eq (char< #\3 #\4) 't)
(eq (char< #\4 #\5) 't)
(eq (char< #\5 #\6) 't)
(eq (char< #\6 #\7) 't)
(eq (char< #\7 #\8) 't)
(eq (char< #\8 #\9) 't)
(eq (char< #\1 #\0) 'nil)
(eq (char< #\2 #\1) 'nil)
(eq (char< #\3 #\2) 'nil)
(eq (char< #\4 #\3) 'nil)
(eq (char< #\5 #\4) 'nil)
(eq (char< #\6 #\5) 'nil)
(eq (char< #\7 #\6) 'nil)
(eq (char< #\8 #\7) 'nil)
(eq (char< #\9 #\8) 'nil)

(eq (char< #\A #\B) 't)
(eq (char< #\B #\C) 't)
(eq (char< #\C #\D) 't)
(eq (char< #\D #\E) 't)
(eq (char< #\E #\F) 't)
(eq (char< #\F #\G) 't)
(eq (char< #\G #\H) 't)
(eq (char< #\H #\I) 't)
(eq (char< #\I #\J) 't)
(eq (char< #\J #\K) 't)
(eq (char< #\K #\L) 't)
(eq (char< #\L #\M) 't)
(eq (char< #\M #\N) 't)
(eq (char< #\N #\O) 't)
(eq (char< #\O #\P) 't)
(eq (char< #\P #\Q) 't)
(eq (char< #\Q #\R) 't)
(eq (char< #\R #\S) 't)
(eq (char< #\S #\T) 't)
(eq (char< #\T #\U) 't)
(eq (char< #\U #\V) 't)
(eq (char< #\V #\W) 't)
(eq (char< #\W #\X) 't)
(eq (char< #\X #\Y) 't)
(eq (char< #\Y #\Z) 't)
(eq (char< #\B #\A) 'nil)
(eq (char< #\C #\B) 'nil)
(eq (char< #\D #\C) 'nil)
(eq (char< #\E #\D) 'nil)
(eq (char< #\F #\E) 'nil)
(eq (char< #\G #\F) 'nil)
(eq (char< #\H #\G) 'nil)
(eq (char< #\I #\H) 'nil)
(eq (char< #\J #\I) 'nil)
(eq (char< #\K #\J) 'nil)
(eq (char< #\L #\K) 'nil)
(eq (char< #\M #\L) 'nil)
(eq (char< #\N #\M) 'nil)
(eq (char< #\O #\N) 'nil)
(eq (char< #\P #\O) 'nil)
(eq (char< #\Q #\P) 'nil)
(eq (char< #\R #\Q) 'nil)
(eq (char< #\S #\R) 'nil)
(eq (char< #\T #\S) 'nil)
(eq (char< #\U #\T) 'nil)
(eq (char< #\V #\U) 'nil)
(eq (char< #\W #\V) 'nil)
(eq (char< #\X #\W) 'nil)
(eq (char< #\Y #\X) 'nil)
(eq (char< #\Z #\Y) 'nil)

(eq (char< #\a #\b) 't)
(eq (char< #\b #\c) 't)
(eq (char< #\c #\d) 't)
(eq (char< #\d #\e) 't)
(eq (char< #\e #\f) 't)
(eq (char< #\f #\g) 't)
(eq (char< #\g #\h) 't)
(eq (char< #\h #\i) 't)
(eq (char< #\i #\j) 't)
(eq (char< #\j #\k) 't)
(eq (char< #\k #\l) 't)
(eq (char< #\l #\m) 't)
(eq (char< #\m #\n) 't)
(eq (char< #\n #\o) 't)
(eq (char< #\o #\p) 't)
(eq (char< #\p #\q) 't)
(eq (char< #\q #\r) 't)
(eq (char< #\r #\s) 't)
(eq (char< #\s #\t) 't)
(eq (char< #\t #\u) 't)
(eq (char< #\u #\v) 't)
(eq (char< #\v #\w) 't)
(eq (char< #\w #\x) 't)
(eq (char< #\x #\y) 't)
(eq (char< #\y #\z) 't)
(eq (char< #\b #\a) 'nil)
(eq (char< #\c #\b) 'nil)
(eq (char< #\d #\c) 'nil)
(eq (char< #\e #\d) 'nil)
(eq (char< #\f #\e) 'nil)
(eq (char< #\g #\f) 'nil)
(eq (char< #\h #\g) 'nil)
(eq (char< #\i #\h) 'nil)
(eq (char< #\j #\i) 'nil)
(eq (char< #\k #\j) 'nil)
(eq (char< #\l #\k) 'nil)
(eq (char< #\m #\l) 'nil)
(eq (char< #\n #\m) 'nil)
(eq (char< #\o #\n) 'nil)
(eq (char< #\p #\o) 'nil)
(eq (char< #\q #\p) 'nil)
(eq (char< #\r #\q) 'nil)
(eq (char< #\s #\r) 'nil)
(eq (char< #\t #\s) 'nil)
(eq (char< #\u #\t) 'nil)
(eq (char< #\v #\u) 'nil)
(eq (char< #\w #\v) 'nil)
(eq (char< #\x #\w) 'nil)
(eq (char< #\y #\x) 'nil)
(eq (char< #\z #\y) 'nil)
(block a
  (with-handler (lambda (condition)
		  (if (instancep condition (class <arity-error>))
		      (return-from a t)
                      (signal-condition condition nil)))
    (char< #\a #\b #\c))
  nil)
(block a
  (with-handler (lambda (condition)
		  (if (instancep condition (class <arity-error>))
		      (return-from a t)
                      (signal-condition condition nil)))
    (char< #\a))
  nil)
(block a
  (with-handler (lambda (condition)
		  (if (instancep condition (class <arity-error>))
		      (return-from a t)
                      (signal-condition condition nil)))
    (char<))
  nil)
(block a
  (with-handler (lambda (condition)
		  (if (instancep condition (class <domain-error>))
		      (return-from a t)
                      (signal-condition condition nil)))
    (char< #\a 'a))
  nil)
(block a
  (with-handler (lambda (condition)
		  (if (instancep condition (class <domain-error>))
		      (return-from a t)
                      (signal-condition condition nil)))
    (char< 'a "b"))
  nil)


;;; char<=
(eq (char<= #\0 #\1) 't)
(eq (char<= #\1 #\2) 't)
(eq (char<= #\2 #\3) 't)
(eq (char<= #\3 #\4) 't)
(eq (char<= #\4 #\5) 't)
(eq (char<= #\5 #\6) 't)
(eq (char<= #\6 #\7) 't)
(eq (char<= #\7 #\8) 't)
(eq (char<= #\8 #\9) 't)
(eq (char<= #\0 #\0) 't)
(eq (char<= #\1 #\1) 't)
(eq (char<= #\2 #\2) 't)
(eq (char<= #\3 #\3) 't)
(eq (char<= #\4 #\4) 't)
(eq (char<= #\5 #\5) 't)
(eq (char<= #\6 #\6) 't)
(eq (char<= #\7 #\7) 't)
(eq (char<= #\8 #\8) 't)
(eq (char<= #\9 #\9) 't)
(eq (char<= #\1 #\0) 'nil)
(eq (char<= #\2 #\1) 'nil)
(eq (char<= #\3 #\2) 'nil)
(eq (char<= #\4 #\3) 'nil)
(eq (char<= #\5 #\4) 'nil)
(eq (char<= #\6 #\5) 'nil)
(eq (char<= #\7 #\6) 'nil)
(eq (char<= #\8 #\7) 'nil)
(eq (char<= #\9 #\8) 'nil)

(eq (char<= #\A #\B) 't)
(eq (char<= #\B #\C) 't)
(eq (char<= #\C #\D) 't)
(eq (char<= #\D #\E) 't)
(eq (char<= #\E #\F) 't)
(eq (char<= #\F #\G) 't)
(eq (char<= #\G #\H) 't)
(eq (char<= #\H #\I) 't)
(eq (char<= #\I #\J) 't)
(eq (char<= #\J #\K) 't)
(eq (char<= #\K #\L) 't)
(eq (char<= #\L #\M) 't)
(eq (char<= #\M #\N) 't)
(eq (char<= #\N #\O) 't)
(eq (char<= #\O #\P) 't)
(eq (char<= #\P #\Q) 't)
(eq (char<= #\Q #\R) 't)
(eq (char<= #\R #\S) 't)
(eq (char<= #\S #\T) 't)
(eq (char<= #\T #\U) 't)
(eq (char<= #\U #\V) 't)
(eq (char<= #\V #\W) 't)
(eq (char<= #\W #\X) 't)
(eq (char<= #\X #\Y) 't)
(eq (char<= #\Y #\Z) 't)

(eq (char<= #\A #\A) 't)
(eq (char<= #\B #\B) 't)
(eq (char<= #\C #\C) 't)
(eq (char<= #\D #\D) 't)
(eq (char<= #\E #\E) 't)
(eq (char<= #\F #\F) 't)
(eq (char<= #\G #\G) 't)
(eq (char<= #\H #\H) 't)
(eq (char<= #\I #\I) 't)
(eq (char<= #\J #\J) 't)
(eq (char<= #\K #\K) 't)
(eq (char<= #\L #\L) 't)
(eq (char<= #\M #\M) 't)
(eq (char<= #\N #\N) 't)
(eq (char<= #\O #\O) 't)
(eq (char<= #\P #\P) 't)
(eq (char<= #\Q #\Q) 't)
(eq (char<= #\R #\R) 't)
(eq (char<= #\S #\S) 't)
(eq (char<= #\T #\T) 't)
(eq (char<= #\U #\U) 't)
(eq (char<= #\V #\V) 't)
(eq (char<= #\W #\W) 't)
(eq (char<= #\X #\X) 't)
(eq (char<= #\Y #\Y) 't)
(eq (char<= #\Z #\Z) 't)

(eq (char<= #\B #\A) 'nil)
(eq (char<= #\C #\B) 'nil)
(eq (char<= #\D #\C) 'nil)
(eq (char<= #\E #\D) 'nil)
(eq (char<= #\F #\E) 'nil)
(eq (char<= #\G #\F) 'nil)
(eq (char<= #\H #\G) 'nil)
(eq (char<= #\I #\H) 'nil)
(eq (char<= #\J #\I) 'nil)
(eq (char<= #\K #\J) 'nil)
(eq (char<= #\L #\K) 'nil)
(eq (char<= #\M #\L) 'nil)
(eq (char<= #\N #\M) 'nil)
(eq (char<= #\O #\N) 'nil)
(eq (char<= #\P #\O) 'nil)
(eq (char<= #\Q #\P) 'nil)
(eq (char<= #\R #\Q) 'nil)
(eq (char<= #\S #\R) 'nil)
(eq (char<= #\T #\S) 'nil)
(eq (char<= #\U #\T) 'nil)
(eq (char<= #\V #\U) 'nil)
(eq (char<= #\W #\V) 'nil)
(eq (char<= #\X #\W) 'nil)
(eq (char<= #\Y #\X) 'nil)
(eq (char<= #\Z #\Y) 'nil)

(eq (char<= #\a #\b) 't)
(eq (char<= #\b #\c) 't)
(eq (char<= #\c #\d) 't)
(eq (char<= #\d #\e) 't)
(eq (char<= #\e #\f) 't)
(eq (char<= #\f #\g) 't)
(eq (char<= #\g #\h) 't)
(eq (char<= #\h #\i) 't)
(eq (char<= #\i #\j) 't)
(eq (char<= #\j #\k) 't)
(eq (char<= #\k #\l) 't)
(eq (char<= #\l #\m) 't)
(eq (char<= #\m #\n) 't)
(eq (char<= #\n #\o) 't)
(eq (char<= #\o #\p) 't)
(eq (char<= #\p #\q) 't)
(eq (char<= #\q #\r) 't)
(eq (char<= #\r #\s) 't)
(eq (char<= #\s #\t) 't)
(eq (char<= #\t #\u) 't)
(eq (char<= #\u #\v) 't)
(eq (char<= #\v #\w) 't)
(eq (char<= #\w #\x) 't)
(eq (char<= #\x #\y) 't)
(eq (char<= #\y #\z) 't)

(eq (char<= #\a #\a) 't)
(eq (char<= #\b #\b) 't)
(eq (char<= #\c #\c) 't)
(eq (char<= #\d #\d) 't)
(eq (char<= #\e #\e) 't)
(eq (char<= #\f #\f) 't)
(eq (char<= #\g #\g) 't)
(eq (char<= #\h #\h) 't)
(eq (char<= #\i #\i) 't)
(eq (char<= #\j #\j) 't)
(eq (char<= #\k #\k) 't)
(eq (char<= #\l #\l) 't)
(eq (char<= #\m #\m) 't)
(eq (char<= #\n #\n) 't)
(eq (char<= #\o #\o) 't)
(eq (char<= #\p #\p) 't)
(eq (char<= #\q #\q) 't)
(eq (char<= #\r #\r) 't)
(eq (char<= #\s #\s) 't)
(eq (char<= #\t #\t) 't)
(eq (char<= #\u #\u) 't)
(eq (char<= #\v #\v) 't)
(eq (char<= #\w #\w) 't)
(eq (char<= #\x #\x) 't)
(eq (char<= #\y #\y) 't)
(eq (char<= #\z #\z) 't)

(eq (char<= #\b #\a) 'nil)
(eq (char<= #\c #\b) 'nil)
(eq (char<= #\d #\c) 'nil)
(eq (char<= #\e #\d) 'nil)
(eq (char<= #\f #\e) 'nil)
(eq (char<= #\g #\f) 'nil)
(eq (char<= #\h #\g) 'nil)
(eq (char<= #\i #\h) 'nil)
(eq (char<= #\j #\i) 'nil)
(eq (char<= #\k #\j) 'nil)
(eq (char<= #\l #\k) 'nil)
(eq (char<= #\m #\l) 'nil)
(eq (char<= #\n #\m) 'nil)
(eq (char<= #\o #\n) 'nil)
(eq (char<= #\p #\o) 'nil)
(eq (char<= #\q #\p) 'nil)
(eq (char<= #\r #\q) 'nil)
(eq (char<= #\s #\r) 'nil)
(eq (char<= #\t #\s) 'nil)
(eq (char<= #\u #\t) 'nil)
(eq (char<= #\v #\u) 'nil)
(eq (char<= #\w #\v) 'nil)
(eq (char<= #\x #\w) 'nil)
(eq (char<= #\y #\x) 'nil)
(eq (char<= #\z #\y) 'nil)

(block a
  (with-handler (lambda (condition)
		  (if (instancep condition (class <arity-error>))
		      (return-from a t)
                      (signal-condition condition nil)))
    (char<= #\a #\b #\c))
  nil)
(block a
  (with-handler (lambda (condition)
		  (if (instancep condition (class <arity-error>))
		      (return-from a t)
                      (signal-condition condition nil)))
    (char<= #\a))
  nil)
(block a
  (with-handler (lambda (condition)
		  (if (instancep condition (class <arity-error>))
		      (return-from a t)
                      (signal-condition condition nil)))
    (char<=))
  nil)
(block a
  (with-handler (lambda (condition)
		  (if (instancep condition (class <domain-error>))
		      (return-from a t)
                      (signal-condition condition nil)))
    (char<= #\a 'a))
  nil)
(block a
  (with-handler (lambda (condition)
		  (if (instancep condition (class <domain-error>))
		      (return-from a t)
                      (signal-condition condition nil)))
    (char<= 'a "b"))
  nil)


;;; char>=
(eq (char>= #\0 #\1) 'nil)
(eq (char>= #\1 #\2) 'nil)
(eq (char>= #\2 #\3) 'nil)
(eq (char>= #\3 #\4) 'nil)
(eq (char>= #\4 #\5) 'nil)
(eq (char>= #\5 #\6) 'nil)
(eq (char>= #\6 #\7) 'nil)
(eq (char>= #\7 #\8) 'nil)
(eq (char>= #\8 #\9) 'nil)
(eq (char>= #\1 #\0) 't)
(eq (char>= #\2 #\1) 't)
(eq (char>= #\3 #\2) 't)
(eq (char>= #\4 #\3) 't)
(eq (char>= #\5 #\4) 't)
(eq (char>= #\6 #\5) 't)
(eq (char>= #\7 #\6) 't)
(eq (char>= #\8 #\7) 't)
(eq (char>= #\9 #\8) 't)

(eq (char>= #\0 #\0) 't)
(eq (char>= #\1 #\1) 't)
(eq (char>= #\2 #\2) 't)
(eq (char>= #\3 #\3) 't)
(eq (char>= #\4 #\4) 't)
(eq (char>= #\5 #\5) 't)
(eq (char>= #\6 #\6) 't)
(eq (char>= #\7 #\7) 't)
(eq (char>= #\8 #\8) 't)
(eq (char>= #\9 #\9) 't)

(eq (char>= #\A #\B) 'nil)
(eq (char>= #\B #\C) 'nil)
(eq (char>= #\C #\D) 'nil)
(eq (char>= #\D #\E) 'nil)
(eq (char>= #\E #\F) 'nil)
(eq (char>= #\F #\G) 'nil)
(eq (char>= #\G #\H) 'nil)
(eq (char>= #\H #\I) 'nil)
(eq (char>= #\I #\J) 'nil)
(eq (char>= #\J #\K) 'nil)
(eq (char>= #\K #\L) 'nil)
(eq (char>= #\L #\M) 'nil)
(eq (char>= #\M #\N) 'nil)
(eq (char>= #\N #\O) 'nil)
(eq (char>= #\O #\P) 'nil)
(eq (char>= #\P #\Q) 'nil)
(eq (char>= #\Q #\R) 'nil)
(eq (char>= #\R #\S) 'nil)
(eq (char>= #\S #\T) 'nil)
(eq (char>= #\T #\U) 'nil)
(eq (char>= #\U #\V) 'nil)
(eq (char>= #\V #\W) 'nil)
(eq (char>= #\W #\X) 'nil)
(eq (char>= #\X #\Y) 'nil)
(eq (char>= #\Y #\Z) 'nil)

(eq (char>= #\A #\A) 't)
(eq (char>= #\B #\B) 't)
(eq (char>= #\C #\C) 't)
(eq (char>= #\D #\D) 't)
(eq (char>= #\E #\E) 't)
(eq (char>= #\F #\F) 't)
(eq (char>= #\G #\G) 't)
(eq (char>= #\H #\H) 't)
(eq (char>= #\I #\I) 't)
(eq (char>= #\J #\J) 't)
(eq (char>= #\K #\K) 't)
(eq (char>= #\L #\L) 't)
(eq (char>= #\M #\M) 't)
(eq (char>= #\N #\N) 't)
(eq (char>= #\O #\O) 't)
(eq (char>= #\P #\P) 't)
(eq (char>= #\Q #\Q) 't)
(eq (char>= #\R #\R) 't)
(eq (char>= #\S #\S) 't)
(eq (char>= #\T #\T) 't)
(eq (char>= #\U #\U) 't)
(eq (char>= #\V #\V) 't)
(eq (char>= #\W #\W) 't)
(eq (char>= #\X #\X) 't)
(eq (char>= #\Y #\Y) 't)
(eq (char>= #\Z #\Z) 't)

(eq (char>= #\B #\A) 't)
(eq (char>= #\C #\B) 't)
(eq (char>= #\D #\C) 't)
(eq (char>= #\E #\D) 't)
(eq (char>= #\F #\E) 't)
(eq (char>= #\G #\F) 't)
(eq (char>= #\H #\G) 't)
(eq (char>= #\I #\H) 't)
(eq (char>= #\J #\I) 't)
(eq (char>= #\K #\J) 't)
(eq (char>= #\L #\K) 't)
(eq (char>= #\M #\L) 't)
(eq (char>= #\N #\M) 't)
(eq (char>= #\O #\N) 't)
(eq (char>= #\P #\O) 't)
(eq (char>= #\Q #\P) 't)
(eq (char>= #\R #\Q) 't)
(eq (char>= #\S #\R) 't)
(eq (char>= #\T #\S) 't)
(eq (char>= #\U #\T) 't)
(eq (char>= #\V #\U) 't)
(eq (char>= #\W #\V) 't)
(eq (char>= #\X #\W) 't)
(eq (char>= #\Y #\X) 't)
(eq (char>= #\Z #\Y) 't)

(eq (char>= #\a #\b) 'nil)
(eq (char>= #\b #\c) 'nil)
(eq (char>= #\c #\d) 'nil)
(eq (char>= #\d #\e) 'nil)
(eq (char>= #\e #\f) 'nil)
(eq (char>= #\f #\g) 'nil)
(eq (char>= #\g #\h) 'nil)
(eq (char>= #\h #\i) 'nil)
(eq (char>= #\i #\j) 'nil)
(eq (char>= #\j #\k) 'nil)
(eq (char>= #\k #\l) 'nil)
(eq (char>= #\l #\m) 'nil)
(eq (char>= #\m #\n) 'nil)
(eq (char>= #\n #\o) 'nil)
(eq (char>= #\o #\p) 'nil)
(eq (char>= #\p #\q) 'nil)
(eq (char>= #\q #\r) 'nil)
(eq (char>= #\r #\s) 'nil)
(eq (char>= #\s #\t) 'nil)
(eq (char>= #\t #\u) 'nil)
(eq (char>= #\u #\v) 'nil)
(eq (char>= #\v #\w) 'nil)
(eq (char>= #\w #\x) 'nil)
(eq (char>= #\x #\y) 'nil)
(eq (char>= #\y #\z) 'nil)

(eq (char>= #\a #\a) 't)
(eq (char>= #\b #\b) 't)
(eq (char>= #\c #\c) 't)
(eq (char>= #\d #\d) 't)
(eq (char>= #\e #\e) 't)
(eq (char>= #\f #\f) 't)
(eq (char>= #\g #\g) 't)
(eq (char>= #\h #\h) 't)
(eq (char>= #\i #\i) 't)
(eq (char>= #\j #\j) 't)
(eq (char>= #\k #\k) 't)
(eq (char>= #\l #\l) 't)
(eq (char>= #\m #\m) 't)
(eq (char>= #\n #\n) 't)
(eq (char>= #\o #\o) 't)
(eq (char>= #\p #\p) 't)
(eq (char>= #\q #\q) 't)
(eq (char>= #\r #\r) 't)
(eq (char>= #\s #\s) 't)
(eq (char>= #\t #\t) 't)
(eq (char>= #\u #\u) 't)
(eq (char>= #\v #\v) 't)
(eq (char>= #\w #\w) 't)
(eq (char>= #\x #\x) 't)
(eq (char>= #\y #\y) 't)
(eq (char>= #\z #\z) 't)

(eq (char>= #\b #\a) 't)
(eq (char>= #\c #\b) 't)
(eq (char>= #\d #\c) 't)
(eq (char>= #\e #\d) 't)
(eq (char>= #\f #\e) 't)
(eq (char>= #\g #\f) 't)
(eq (char>= #\h #\g) 't)
(eq (char>= #\i #\h) 't)
(eq (char>= #\j #\i) 't)
(eq (char>= #\k #\j) 't)
(eq (char>= #\l #\k) 't)
(eq (char>= #\m #\l) 't)
(eq (char>= #\n #\m) 't)
(eq (char>= #\o #\n) 't)
(eq (char>= #\p #\o) 't)
(eq (char>= #\q #\p) 't)
(eq (char>= #\r #\q) 't)
(eq (char>= #\s #\r) 't)
(eq (char>= #\t #\s) 't)
(eq (char>= #\u #\t) 't)
(eq (char>= #\v #\u) 't)
(eq (char>= #\w #\v) 't)
(eq (char>= #\x #\w) 't)
(eq (char>= #\y #\x) 't)
(eq (char>= #\z #\y) 't)
(block a
  (with-handler (lambda (condition)
		  (if (instancep condition (class <arity-error>))
		      (return-from a t)
                      (signal-condition condition nil)))
    (char>= #\a #\b #\c))
  nil)
(block a
  (with-handler (lambda (condition)
		  (if (instancep condition (class <arity-error>))
		      (return-from a t)
                      (signal-condition condition nil)))
    (char>= #\a))
  nil)
(block a
  (with-handler (lambda (condition)
		  (if (instancep condition (class <arity-error>))
		      (return-from a t)
                      (signal-condition condition nil)))
    (char>=))
  nil)
(block a
  (with-handler (lambda (condition)
		  (if (instancep condition (class <domain-error>))
		      (return-from a t)
                      (signal-condition condition nil)))
    (char>= #\a 'a))
  nil)
(block a
  (with-handler (lambda (condition)
		  (if (instancep condition (class <domain-error>))
		      (return-from a t)
                      (signal-condition condition nil)))
    (char>= 'a "b"))
  nil)

;;; char>
(eq (char> #\0 #\1) 'nil)
(eq (char> #\1 #\2) 'nil)
(eq (char> #\2 #\3) 'nil)
(eq (char> #\3 #\4) 'nil)
(eq (char> #\4 #\5) 'nil)
(eq (char> #\5 #\6) 'nil)
(eq (char> #\6 #\7) 'nil)
(eq (char> #\7 #\8) 'nil)
(eq (char> #\8 #\9) 'nil)
(eq (char> #\1 #\0) 't)
(eq (char> #\2 #\1) 't)
(eq (char> #\3 #\2) 't)
(eq (char> #\4 #\3) 't)
(eq (char> #\5 #\4) 't)
(eq (char> #\6 #\5) 't)
(eq (char> #\7 #\6) 't)
(eq (char> #\8 #\7) 't)
(eq (char> #\9 #\8) 't)

(eq (char> #\A #\B) 'nil)
(eq (char> #\B #\C) 'nil)
(eq (char> #\C #\D) 'nil)
(eq (char> #\D #\E) 'nil)
(eq (char> #\E #\F) 'nil)
(eq (char> #\F #\G) 'nil)
(eq (char> #\G #\H) 'nil)
(eq (char> #\H #\I) 'nil)
(eq (char> #\I #\J) 'nil)
(eq (char> #\J #\K) 'nil)
(eq (char> #\K #\L) 'nil)
(eq (char> #\L #\M) 'nil)
(eq (char> #\M #\N) 'nil)
(eq (char> #\N #\O) 'nil)
(eq (char> #\O #\P) 'nil)
(eq (char> #\P #\Q) 'nil)
(eq (char> #\Q #\R) 'nil)
(eq (char> #\R #\S) 'nil)
(eq (char> #\S #\T) 'nil)
(eq (char> #\T #\U) 'nil)
(eq (char> #\U #\V) 'nil)
(eq (char> #\V #\W) 'nil)
(eq (char> #\W #\X) 'nil)
(eq (char> #\X #\Y) 'nil)
(eq (char> #\Y #\Z) 'nil)

(eq (char> #\B #\A) 't)
(eq (char> #\C #\B) 't)
(eq (char> #\D #\C) 't)
(eq (char> #\E #\D) 't)
(eq (char> #\F #\E) 't)
(eq (char> #\G #\F) 't)
(eq (char> #\H #\G) 't)
(eq (char> #\I #\H) 't)
(eq (char> #\J #\I) 't)
(eq (char> #\K #\J) 't)
(eq (char> #\L #\K) 't)
(eq (char> #\M #\L) 't)
(eq (char> #\N #\M) 't)
(eq (char> #\O #\N) 't)
(eq (char> #\P #\O) 't)
(eq (char> #\Q #\P) 't)
(eq (char> #\R #\Q) 't)
(eq (char> #\S #\R) 't)
(eq (char> #\T #\S) 't)
(eq (char> #\U #\T) 't)
(eq (char> #\V #\U) 't)
(eq (char> #\W #\V) 't)
(eq (char> #\X #\W) 't)
(eq (char> #\Y #\X) 't)
(eq (char> #\Z #\Y) 't)

(eq (char> #\a #\b) 'nil)
(eq (char> #\b #\c) 'nil)
(eq (char> #\c #\d) 'nil)
(eq (char> #\d #\e) 'nil)
(eq (char> #\e #\f) 'nil)
(eq (char> #\f #\g) 'nil)
(eq (char> #\g #\h) 'nil)
(eq (char> #\h #\i) 'nil)
(eq (char> #\i #\j) 'nil)
(eq (char> #\j #\k) 'nil)
(eq (char> #\k #\l) 'nil)
(eq (char> #\l #\m) 'nil)
(eq (char> #\m #\n) 'nil)
(eq (char> #\n #\o) 'nil)
(eq (char> #\o #\p) 'nil)
(eq (char> #\p #\q) 'nil)
(eq (char> #\q #\r) 'nil)
(eq (char> #\r #\s) 'nil)
(eq (char> #\s #\t) 'nil)
(eq (char> #\t #\u) 'nil)
(eq (char> #\u #\v) 'nil)
(eq (char> #\v #\w) 'nil)
(eq (char> #\w #\x) 'nil)
(eq (char> #\x #\y) 'nil)
(eq (char> #\y #\z) 'nil)

(eq (char> #\b #\a) 't)
(eq (char> #\c #\b) 't)
(eq (char> #\d #\c) 't)
(eq (char> #\e #\d) 't)
(eq (char> #\f #\e) 't)
(eq (char> #\g #\f) 't)
(eq (char> #\h #\g) 't)
(eq (char> #\i #\h) 't)
(eq (char> #\j #\i) 't)
(eq (char> #\k #\j) 't)
(eq (char> #\l #\k) 't)
(eq (char> #\m #\l) 't)
(eq (char> #\n #\m) 't)
(eq (char> #\o #\n) 't)
(eq (char> #\p #\o) 't)
(eq (char> #\q #\p) 't)
(eq (char> #\r #\q) 't)
(eq (char> #\s #\r) 't)
(eq (char> #\t #\s) 't)
(eq (char> #\u #\t) 't)
(eq (char> #\v #\u) 't)
(eq (char> #\w #\v) 't)
(eq (char> #\x #\w) 't)
(eq (char> #\y #\x) 't)
(eq (char> #\z #\y) 't)
(block a
  (with-handler (lambda (condition)
		  (if (instancep condition (class <arity-error>))
		      (return-from a t)
                      (signal-condition condition nil)))
    (char> #\a #\b #\c))
  nil)
(block a
  (with-handler (lambda (condition)
		  (if (instancep condition (class <arity-error>))
		      (return-from a t)
                      (signal-condition condition nil)))
    (char> #\a))
  nil)
(block a
  (with-handler (lambda (condition)
		  (if (instancep condition (class <arity-error>))
		      (return-from a t)
                      (signal-condition condition nil)))
    (char>))
  nil)
(block a
  (with-handler (lambda (condition)
		  (if (instancep condition (class <domain-error>))
		      (return-from a t)
                      (signal-condition condition nil)))
    (char> #\a 'a))
  nil)
(block a
  (with-handler (lambda (condition)
		  (if (instancep condition (class <domain-error>))
		      (return-from a t)
                      (signal-condition condition nil)))
    (char> 'a "b"))
  nil)

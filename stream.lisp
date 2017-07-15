;;; -*- mode: lisp; coding: utf-8 -*- 
;;; stream.lisp --- defines the stream handling mechanism of ISLisp processor KISS.

;; Copyright (C) 2017 Yuji Minejima.

;; This file is part of ISLisp processor KISS.

;; KISS is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; KISS is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

(defdynamic *kiss::standard-input* *kiss::standard-input*)
(defdynamic *kiss::standard-output* *kiss::standard-output*)
(defdynamic *kiss::error-output* *kiss::error-output*)

(defmacro with-standard-input (stream-form &rest forms)
  `(dynamic-let ((*kiss::standard-input* ,stream-form))
      ,@forms))

(defmacro with-standard-output (stream-form &rest forms)
  `(dynamic-let ((*kiss::standard-output* ,stream-form))
      ,@forms))

(defmacro with-error-output (stream-form &rest forms)
  `(dynamic-let ((*kiss::error-output* ,stream-form))
      ,@forms))

/*  -*- coding: utf-8 -*-
  sequence.c --- defines the sequence handling mechanism of ISLisp processor KISS.

  Copyright (C) 2017 Yuji Minejima.

  This file is part of ISLisp processor KISS.

  KISS is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  KISS is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

*/
#include "kiss.h"

size_t kiss_clength(kiss_obj* p) {
     p = Kiss_Sequence(p);
     switch (KISS_OBJ_TYPE(p)) {
     case KISS_SYMBOL:
	  assert(p == KISS_NIL);
	  return 0;
     case KISS_CONS: {
	  size_t n = 0;
	  for (; KISS_IS_CONS(p); p = KISS_CDR(p)) { n++; }
	  return n;
     }
     case KISS_STRING: return ((kiss_string_t*)p)->n;
     case KISS_GENERAL_VECTOR: return ((kiss_general_vector_t*)p)->n;
     default:
	  fwprintf(stderr, L"kiss_clength: unknown primitive type %d", KISS_OBJ_TYPE(p));
	  exit(EXIT_FAILURE);
     }
}

/* function: (length sequence) -> <integer> 
   Returns the length of sequence as an integer greater than or equal to 0.
   When sequence is a vector, length returns its dimension.
   When sequence is a list, the result is the number of elements in the list;
   if an element is itself a list, the elements within this sublist are not
   counted. In the case of dotted lists, length returns the number of
   conses at the uppermost level of the list. For example,
   (length ’(a b . c)) ⇒ 2,
   since ’(a b . c) ≡ (cons ’a (cons ’b ’c)).
   An error shall be signaled if sequence is not a basic-vector or a list
   (error-id. domain-error ).
 */
kiss_obj* kiss_length(kiss_obj* sequence) {
    return (kiss_obj*)kiss_make_integer(kiss_clength(sequence));
}

/* function: (elt sequence z) -> <object>
   Given a sequence and an integer z satisfying 0 <= z < (length sequence),
   elt returns the element of sequence that has index z. Indexing is
   0-based; i.e., z = 0 designates the first element. An error shall be
   signaled if z is an integer outside of the mentioned range
   (error-id. index-out-of-range).
   An error shall be signaled if sequence is not a basic-vector or a list or
   if z is not an integer (error-id. domain-error). */
kiss_obj* kiss_elt(kiss_obj* sequence, kiss_obj* z) {
     z = Kiss_Valid_Sequence_Index(sequence, z);
     size_t i = ((kiss_integer_t*)z)->i;
     switch (KISS_OBJ_TYPE(sequence)) {
     case KISS_SYMBOL: {
	  assert(sequence == KISS_NIL);
	  fwprintf(stderr, L"elt: nil has no elements.");
	  // Kiss_Valid_Sequence_Index(sequence, z) above must have signaled error
	  exit(EXIT_FAILURE);
     }
     case KISS_CONS: {
	  kiss_obj* list = sequence;
	  for (; i > 0; i--) { list = KISS_CDR(list); }
	  return KISS_CAR(list);
     }
     case KISS_STRING: {
	  kiss_string_t* string = ((kiss_string_t*)sequence);
	  return (kiss_obj*)kiss_make_character(string->str[i]);
     }
     case KISS_GENERAL_VECTOR: {
	  kiss_general_vector_t* vector = ((kiss_general_vector_t*)sequence);
	  return vector->v[i];
     }
     default:
	  fwprintf(stderr, L"elt: unknown primitive type = %d", KISS_OBJ_TYPE(sequence));
	  exit(EXIT_FAILURE);
     }
    
}

/* function: (set-elt obj sequence z) -> <object>
   Replace the object obtainable by elt with obj.
   The returned value is obj. 
   An error shall be signaled if z is an integer outside of the valid range of indices 
   (error-id. index-out-of-range).
   An error shall be signaled if sequence is not a basic-vector or a list or 
   if z is not an integer (error-id. domain-error).
   obj may be any ISLISP object.
*/
kiss_obj* kiss_set_elt(kiss_obj* obj, kiss_obj* sequence, kiss_obj* z) {
     z = Kiss_Valid_Sequence_Index(sequence, z);
     size_t i = ((kiss_integer_t*)z)->i;
     switch (KISS_OBJ_TYPE(sequence)) {
     case KISS_SYMBOL: {
	  assert(sequence == KISS_NIL);
	  fwprintf(stderr, L"set-elt: nil has no elements.");
	  // Kiss_Valid_Sequence_Index(sequence, z) above must have signaled error
	  exit(EXIT_FAILURE);
     }
     case KISS_CONS: {
	  kiss_obj* list = sequence;
	  for (; i > 0; i--) { list = KISS_CDR(list); }
	  kiss_set_car(obj, list);
	  break;
     }
     case KISS_STRING: {
	  kiss_string_t* string = ((kiss_string_t*)sequence);
	  wchar_t c = Kiss_Character(obj)->c;
	  string->str[i] = c;
	  break;
     }
     case KISS_GENERAL_VECTOR: {
	  kiss_general_vector_t* vector = ((kiss_general_vector_t*)sequence);
	  vector->v[i] = obj;
	  break;
     }
     default:
	  fwprintf(stderr, L"set-elt:unknown sequence type = %d", KISS_OBJ_TYPE(sequence));
	  exit(EXIT_FAILURE);
     }
     return obj;
}

/* function: (subseq sequence z1 z2) -> sequence
   Given a sequence SEQUENCE and two integers Z1 and Z2 satisfying 
   0 <= Z1 <= Z2 <= (length SEQUENCE), this function returns the subsequence of length
   Z2 − Z1, containing the elements with indices from Z1 (inclusive) to Z2(exclusive).
   The subsequence is newly allocated, and has the same class as SEQUENCE.
   An error shall be signaled if the requested subsequence cannot be allocated
   (error-id. cannot-create-sequence).
   An error shall be signaled if Z1 or Z2 are outside of the bounds mentioned
   (error-id. index-out-of-range).
   An error shall be signaled if sequence is not a basic-vector or a list, 
   or if Z1 is not an integer, or if Z2 is not an integer (error-id. domain-error).
 */
kiss_obj* kiss_subseq(kiss_obj* sequence, kiss_obj* z1, kiss_obj* z2) {
     long int i1 = Kiss_Integer(z1)->i;
     long int i2 = Kiss_Integer(z2)->i;
     size_t n = kiss_clength(sequence);
     if (i1 < 0) {
	  Kiss_Err(L"Invalid sequence index = ~S", z1);
     }
     if (i2 > n) {
	  Kiss_Err(L"Invalid sequence index = ~S", z2);
     }
     if (i1 > i2) {
	  Kiss_Err(L"Index1 ~S must be less than or equal to Index2 ~S", z1, z2);
     }
     switch (KISS_OBJ_TYPE(sequence)) {
     case KISS_SYMBOL: {
	  assert(sequence == KISS_NIL);
	  assert(i1 == 0 && i2 == 0);
	  return KISS_NIL;
     }
     case KISS_CONS: {
	  kiss_obj* list = sequence;
	  kiss_obj* p = KISS_NIL;
	  size_t i;
	  for (i = 0; i < i1; i++) { list = KISS_CDR(list); }
	  for (i = i1; i < i2; i++) {
	       kiss_push(KISS_CAR(list), &p);
	       list = KISS_CDR(list);
	  }
	  return kiss_nreverse(p);
     }
     case KISS_STRING: {
	  kiss_string_t* string = (kiss_string_t*)sequence;
	  kiss_obj* n = (kiss_obj*)kiss_make_integer(i2 - i1);
	  kiss_string_t* p = (kiss_string_t*)kiss_create_string(n, KISS_NIL);
	  for (long int i = i1; i < i2; i++) {
	       p->str[i - i1] = string->str[i];
	  }
	  return (kiss_obj*)p;
     }
     case KISS_GENERAL_VECTOR: {
	  kiss_general_vector_t* vector = (kiss_general_vector_t*)sequence;
	  kiss_general_vector_t* p = kiss_make_general_vector(i2 - i1, KISS_NIL);
	  long int i;
	  for (i = i1; i < i2; i++) {
	       p->v[i - i1] = vector->v[i];
	  }
	  return (kiss_obj*)p;
     }
     default:
	  fwprintf(stderr, L"subseq: unknown sequence = %d", KISS_OBJ_TYPE(sequence));
	  exit(EXIT_FAILURE);
     }
}

/* function: (map-into destination function sequence*) -> sequence
   Destructively modifies destination to contain the results of applying function
   to successive elements in the sequences. 
   The destination is returned.
   If destination and each element of sequences are not all the same length, 
   the iteration terminates when the shortest sequence (of any of the sequences or
   the destination) is exhausted.
   The calls to function proceed from left to right, so that if function has side-effects,
   it can rely upon being called first on all of the elements with index 0,
   then on all of those numbered 1, and so on.
   An error shall be signaled if destination is not a basic-vector or a list
   (error-id. domain-error).
   An error shall be signaled if any sequence is not a basic-vector or a list
   (error-id. domain-error).
 */
kiss_obj* kiss_map_into(kiss_obj* destination, kiss_obj* function, kiss_obj* rest) {
     size_t n = kiss_clength(destination);
     for (kiss_obj* p = rest; p != KISS_NIL; p = KISS_CDR(p)) {
	  size_t a = kiss_clength(kiss_car(p));
	  if (a < n) { n = a; }
     }
     size_t i;
     kiss_integer_t* integer;
     kiss_obj* args;
     for (i = 0; i < n; i++) {
	  args = KISS_NIL;
	  integer = kiss_make_integer(i);
	  for (kiss_obj* p = rest; p != KISS_NIL; p = kiss_cdr(p)) {
	       kiss_push(kiss_elt(kiss_car(p), (kiss_obj*)integer), &args);
	  }
	  args = kiss_nreverse(args);
	  kiss_obj* result = kiss_funcall(function, args);
	  kiss_set_elt(result, destination, (kiss_obj*)integer);
     }
     return destination;
}

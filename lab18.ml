(*
                              CS51 Lab 18
                         Environment Semantics

Objective:

This lab practices concepts of environment semantics.
 *)

(*====================================================================
Part 1: An environment semantics derivation

In this part, you'll work out the formal derivation of the environment
semantics for the expression

    let x = 3 + 5 in
    (fun x -> x * x) (x - 2)

according to the semantic rules presented in Chapter 19, Figure 19.1,
just as you did in Lab 9, Part 1 for substitution semantics.

Before beginning, what should this expression evaluate to? Test out
your prediction in the OCaml REPL. *)

(* The exercises will take you through the derivation stepwise, so
that you can use the results from earlier exercises in the later
exercises.

By way of example, we do the first couple of exercises for you to give
you the idea.

......................................................................
Exercise 1. Carry out the derivation for the semantics of the
expression 3 + 5 in an empty environment.
....................................................................*)

(* ANSWER:

    {} ⊢ 3 + 5 ⇒
               | {} ⊢ 3 ⇒ 3       (R_int)
               | {} ⊢ 5 ⇒ 5       (R_int)
               ⇒ 8                (R_+)
*)

(*....................................................................
Exercise 2. What is the result of evaluating the following expression
in the environment {x -> 3}?

    (x + 5)
....................................................................*)

(* ANSWER: Carrying out each step in the derivation:

    {x -> 3} ⊢ x + 5 ⇒
                     | {x -> 3} ⊢ x ⇒ 3    (R_var)
                     | {x -> 3} ⊢ 5 ⇒ 5    (R_int)
                     ⇒ 8                   (R_+)

   Again, we've labeled each line with the number of the equation that
   was used from the set of equations in Figure 19.1.
   You should do that too. *)

(*....................................................................
Exercise 3. Carry out the derivation for the semantics of the
expression let x = 3 in x + 5 in an empty environment.
....................................................................*)

(* ANSWER:

  {} ⊢ let x = 3 in x + 5 ⇒
                          | {} ⊢ 3 ⇒ 3              (R_int)
                          | {x -> 3} ⊢ x + 5 ⇒ 8    (Exercise 2)
                          ⇒ 8                       (R_let)

   Note the labeling of one of the steps with the prior result from a
   previous exercise. *)

(* Now it's your turn. We recommend doing these exercises with pencil
on paper, rather than typing them in. Call over a staff member for
help and to check your answers. *)

(*....................................................................
Exercise 4. Carry out the derivation for the semantics of the
expression x * x in the environment mapping x to 6, following the
rules in Figure 19.1.

{x -> 6} ⊢ (x * x) ⇒
                   | {x -> 6} ⊢ x ⇒ 6
                   | {x -> 6} ⊢ x ⇒ 6
                   36
....................................................................*)

(*....................................................................
Exercise 5. Carry out the derivation for the semantics of the
expression x - 2 in the environment mapping x to 8, following the
rules in Figure 19.1.

{x -> 8} ⊢ (x * x) ⇒
                   | {x -> 8} ⊢ x ⇒ 8
                   | {x -> 8} ⊢ 2 ⇒ 2
                   6
....................................................................*)

(*....................................................................
Exercise 6. Carry out the derivation for the semantics of the
expression (fun x -> x * x) (x - 2) in the environment mapping
x to 8, following the rules in Figure 19.1.

{x -> 8} ⊢ (fun x -> x * x) (x - 2) ⇒
                                    | {x -> 8} ⊢ (fun x -> x * x)
                                    | {x -> 8} ⊢ (x - 2) ⇒
                                                         | {x -> 8} ⊢ x ⇒ 8
                                                         | {x -> 8} ⊢ 2 ⇒ 2
                                                         6
                                    | {x -> 6} ⊢ x * x ⇒
                                                       |{x -> 6} ⊢ x ⇒ 6
                                                       |{x -> 6} ⊢ x ⇒ 6
                                                       36
                                    36
....................................................................*)

(*....................................................................
Exercise 7. Finally, carry out the derivation for the semantics of the
expression

    let x = 3 + 5 in (fun x -> x * x) (x - 2)

in the empty environment.

{} ⊢ let x = 3 + 5 in (fun x -> x * x) (x - 2) ⇒
                                               | {} ⊢ 3 + 5 ⇒
                                                            | {} ⊢ 3 ⇒ 3
                                                            | {} ⊢ 5 ⇒ 5
                                                            8
                                               | {x -> 8} ⊢ (fun x -> x * x) (x - 2) ⇒
                                                                                   | {x -> 8} ⊢ (fun x -> x * x)
                                                                                   | {x -> 8} ⊢ (x - 2) ⇒
                                                                                                        | {x -> 8} ⊢ x ⇒ 8
                                                                                                        | {x -> 8} ⊢ 2 ⇒ 2
                                                                                                        6
                                                                                   | {x -> 6} ⊢ x * x ⇒
                                                                                                      |{x -> 6} ⊢ x ⇒ 6
                                                                                                      |{x -> 6} ⊢ x ⇒ 6
                                                                                                      36
                                                                                   36
                                               36
....................................................................*)

(*====================================================================
Part 2: Pen and paper exercises, dynamic vs. lexical semantics
*)

(*....................................................................
Exercise 8: For each of the following expressions, derive its final
value using the evaluation rules in Figure 19.1. Show all steps using
pen and paper, and label them with the name of the evaluation rule
used. Where an expression makes use of the evaluation of an earlier
expression, you don't need to rederive the earlier expression's value;
just use it directly. Each expression should be evaluated in an
initially empty environment.

1. 2 * 25

{} ⊢ 2 * 25 ⇒
            | {} ⊢ 2 ⇒ 2
            | {} ⊢ 25 ⇒ 25
            50

2. let x = 2 * 25 in x + 1

{} ⊢ let x = 2 * 25 in x + 1 ⇒
                             | {} ⊢ 2 * 25 ⇒ 50
                             | {x -> 50} ⊢ x + 1 ⇒
                                                 | {x -> 50} ⊢ x ⇒ 50
                                                 | {x -> 50} ⊢ 1 ⇒ 1
                                                 51
                             51


3. let x = 2 in x * x

{} ⊢ let x = 2 in x * x ⇒
                         | {} ⊢ 2 ⇒ 2
                         | {x -> 2} ⊢ x * x ⇒
                                             | {x -> 2} ⊢ x ⇒ 2
                                             | {x -> 2} ⊢ x ⇒ 2
                                             4
                         4

4. let x = 51 in let x = 124 in x

{} ⊢ let x = 51 in let x = 124 in x ⇒
                                     | {} ⊢ 51 ⇒ 51
                                     | {x -> 51} ⊢ let x = 124 in x ⇒
                                                                     | {x -> 51} 124 ⇒ 124
                                                                     | {x -> 124} ⊢ x ⇒ 124
                                                                     124
                                     124


....................................................................*)

(*....................................................................
Exercise 9: Evaluate the following expression using the DYNAMIC
environment semantic rules in Figure 19.1. Use an initially empty
environment.

let x = 2 in let f = fun y -> x + y in let x = 8 in f x

{} ⊢ let x = 2 in
      let f = fun y -> x + y in
      let x = 8 in f x ⇒
                       | {} ⊢ 2 ⇒ 2
                       | {x -> 2} ⊢ let f = fun y -> x + y in
                                      let x = 8 in f x ⇒
                                                       | {x -> 2} ⊢ fun y -> x + y ⇒ fun y -> x + y
                                                       | {x -> 2} ⊢ let x = 8 in f x ⇒
                                                                                     | {x -> 2} ⊢ 8 ⇒ 8
                                                                                     | {x -> 8} ⊢ f x ⇒
                                                                                                    | {x -> 8} ⊢ f ⇒ fun y -> x + y
                                                                                                    | {x -> 8} ⊢ x + y ⇒
                                                                                                                        | {x -> 8} ⊢ x ⇒ 8
                                                                                                                        | {x -> 8} ⊢ y ⇒ y
                                                                                                                        8 + y
                                                                                                    | {x -> 8}{y -> 8} ⊢ 8 + y ⇒
                                                                                                                               | {x -> 8}{y -> 8} ⊢ 8 ⇒ 8
                                                                                                                               | {x -> 8}{y -> 8} ⊢ y ⇒ 8
                                                                                                                               16
                                                                                                    16
                                                                                      16
                                                        16
                        16


....................................................................*)


(*....................................................................
Exercise 10: For each of the following expressions, derive its final
value using the LEXICAL evaluation rules in Figure 19.2. Show all
steps using pen and paper, and label them with the name of the
evaluation rule used. Where an expression makes use of the evaluation
of an earlier expression, you don't need to rederive the earlier
expression's value; just use it directly. Each expression should be
evaluated in an initially empty environment.

1. (fun y -> y + y) 10

2. let f = fun y -> y + y in f 10

3. let x = 2 in let f = fun y -> x + y in f 8
....................................................................*)

(*....................................................................
Exercise 11: Evaluate the following expression using the LEXICAL
environment semantic rules in Figure 19.2. Use an initially
empty environment.

let x = 2 in let f = fun y -> x + y in let x = 8 in f x
....................................................................*)


(*....................................................................
Exercise 12: For the following expression, derive its value using the
lexical evaluation rules for imperative programming in Figure 19.4.
Show all steps using pen and paper, and label them with the name of
the evaluation rule used. The expression should be evaluated in an
initially empty environment and an initially empty store.

let x = ref 42 in (x := !x - 21; !x) + !x ;;

How does your result compare with the value of this expression as
computed by the ocaml interpreter?
....................................................................*)

(*====================================================================
Part 3: Implementing environments

To represent an environment, we need to maintain a mapping from
variable names to their values. For simplicity, we will consider only
integer values here. In this part, you'll work on an especially simple
implementation of environments. (Something like this may prove useful
in implementing the final project.) A variable will be represented as
a string, and an environment will be represented as an "association
list" made of pairs of variables and their integer values.
....................................................................*)

type varid = string ;;
type value = int ;;
type env = (varid * value) list ;;

(*....................................................................
Exercise 13: Fill in the implementation of the empty environment.
....................................................................*)

let empty : env = failwith "empty not implemented" ;;

(*....................................................................
Exercise 14: Write a function extend : env -> varid -> value -> env
that extends an environment; that is, extend e x v should extend the
environment e to map x to v. Make sure to handle the case where x is
already in the environment.
....................................................................*)

let extend (e : env) (x : varid) (v : value) : env =
  failwith "extend not implemented" ;;

(*....................................................................
Exercise 15: Write a function lookup : env -> varid -> value that
returns the value of a variable in the given environment, raising a
Not_found exception if the variable has no value in the environment.
....................................................................*)

let lookup (x : varid) (e : env) : value =
  failwith "lookup not implemented" ;;

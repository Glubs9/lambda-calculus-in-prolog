%todo:
	%I would like some pretty printing or something like that
	%i would also like to put a cut somewhere in the reduce / run to stop it from doing more than one result

notclean(C) :-
	C = ' ';
	C = '\n'; 
	C = '\t'.

expr(App) --> app(App).
expr(Ab) --> ab(Ab).
expr(A) --> a(A).
app(app(E1, E2)) --> o, expr(E1), expr(E2), c.
ab(ab(Var, E)) --> o, f, a(Var), d, expr(E), c.
a(var(X)) --> [X].
f --> ['/'].
d --> ['.'].
o --> ['('].
c --> [')'].

%this replace code isn't the nicest thing in the world but it's ok for a first try
%reduce(Ast, Var, Replacement, Result)
replace(var(X), X, Y, Y).
replace(var(X), _, _, var(X)). %might have to change to test for non unification
replace(ab(var(X), E), X, _, ab(var(X), E)). %might have to cut to prevent backtracking with below
replace(ab(var(X), E), _, X, ab(var(X), E)).
replace(ab(var(X), E), Y, Z, ab(var(X), Res)) :- 
	X \= Y, X \= Z, %might not be necersarry
	replace(E, Y, Z, Res).
replace(app(E1, E2), Y, Z, app(Res1, Res2)) :- 
	replace(E1, Y, Z, Res1),
	replace(E2, Y, Z, Res2).
%next clause shouldn't be necersarry
replace(expr(E), Y, Z, expr(Res)) :-
	replace(E, Y, Z, Res).

%i'm a big fan of this reduce code. but variables are shitly named
%also it continues ot evaluate after not finishing which is a bit weird
%reduce(Ast, Res)
reduce(var(X), var(X)).
reduce(expr(X), expr(Y)) :- reduce(X,Y). %this clause mihgtn ot be necersarry
reduce(ab(var(X), E1), ab(var(X), E2)) :- reduce(E1,E2).
reduce(app(ab(var(X), E1), E2), E3) :-  
	%might have to put cut after this
	%here's where the evaluation order comes into it
	reduce(E2, E4), %evals the argument first, (I think this is eager eval)
	replace(E1, X, E4, E5),
	reduce(E5, E3). %might be unecersarry?
reduce(app(E1, E2), app(E3, E4)) :- reduce(E1,E3), reduce(E2,E4).
%oh what do i do about reduce?

lex(Str, Out) :-
	atom_chars(Str, Arr),
	exclude(notclean, Arr, Out).

parse(Arr, Tree) :- expr(Tree, Arr, []).

%this run predicate is very very slow but i kinda like it tbh (looks cool).
%run didn't work for some reason
run(Ast, Res) :- 
	reduce(Ast, Res2),
	Ast \= Res2,
	run(Res2, Res).
run(Ast, Ast).

main(Str, Out) :-
	lex(Str, Arr),
	parse(Arr, Ast),
	run(Ast, Out).

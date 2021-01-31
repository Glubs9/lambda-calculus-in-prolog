# lambda-calculus-in-prolog
a small little lambda calculus interpreter i made in prolog after discovering dcgs

# motivation
I was learning prolog and discovered dcgs and flipped my shit. craziest thing ever. so i wanted to test it out on a quick little program and figured this could be a bit of fun. Especially cause like i'm so shit at programming that it took my like 4 or 5 tries to get it done the first time and it was like way long after i finished so with this i could like golf the interpreter and it was crazy man got it done real short and in like an afternoon. sorry for rambling i just discovered prolog and it's so fantastic.

# use
just download and run, uhhh i forgot to make it a module but i guess you could if you want.                   
The file included has the predicate main/2 which takes a string and an expression (as defined in the dcg near the top of the file) and suceededs if the expression is the string's lambda calculus fully reducded. The string is required to be fully instantiated otherwise the predicate will not work. 

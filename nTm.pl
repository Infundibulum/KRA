glue([],R,R).

glue([H|L],R,Out):-
	glue(L,[H|R],Out).

strip_left([A|T],[A|T]):-
	\+ A = b-k.
strip_left([b-k|T],Out):-
	strip_left(T,Out).

strip(In, Out):-
	strip_left(In,LeftStripped),
	reverse(LeftStripped, Tfel),
	strip_left(Tfel, Reversed),
	reverse(Reversed, Out).

finish(L,R,Output):-
	glue(L,R,Out),
	strip(Out, Output).

nTm(MoveRight, MoveLeft, WriteList, HaltList, Input, Output) :-
  nTm_(MoveRight, MoveLeft, WriteList, HaltList, [[],Input,q0], [L,R]),
	finish(L,R,Output).


resolve([],[b-k]).
resolve([H|T],[H|T]).

nTm_(_,_,_,Halt,[L,[H|R],Q],[L,[H|R]]):-
	member([Q,H],Halt).

nTm_(MR,ML,WriteList,HL,[L,[H|R],Q],Out):-
	member([Q,H,W,Qn],WriteList),
	nTm_(MR,ML,WriteList,HL,[L,[W|R],Qn],Out).

nTm_(MoveRight,ML,WL,HL,[L,[H|R],Q],Out):-
	member([Q,H,Qn],MoveRight),
	resolve(R,Right),
	nTm_(MoveRight,ML,WL,HL,[[H|L],Right,Qn],Out).

nTm_(MR,MoveLeft,WL,HL,[L,[H|R],Q],Out):-
	member([Q,H,Qn],MoveLeft),
	resolve(L,[HeadL|Left]),
	nTm_(MR,MoveLeft,WL,HL,[Left,[HeadL|[H|R]],Qn],Out).


test :-
	findall(A,test(A),Coll).

test(a):-
	nTm([],[],[],[[q0,X]],[b-k,i,n,b-k,p,u,t,b-k,b-k],Out),
	writeln(Out).

test(b):-
	findall(Out,nTm([[q1,1,q2],[q1,0,q2],[q1,b-k,q2]],[],[[q0,0,1,q1], [q2,0,b-k,q1]],[[q1,b-k]],
[0,0,0,0,0],
Out),Outs),
	writeln(Outs).

test(c):-
	once(findnsols(2,Out,nTm([[mr1,h,we],[mr1,e,wl],[mr1,l,wp],[mr1,p,hbk],
[mr,l,wo],[mr,o,wo],[mp,o,wp]],
[[q0,0,lbk],[lbk,b-k,lbk]],
[[q0,0,h,mr1],[we,1,e,mr1],[wl,0,l,mr1],[wp,1,p,mr1],
[q0,0,l,mr],[wo,1,o,mr],[wo,0,o,mp]],
[[hbk,b-k]],
[0,1,0,1],
Out),Outs)),
	writeln(Outs).

%Trabajo final de Taller de Nuevas Tecnologias - UNPSJB
%Integrantes
%	Cobo Medvedsky, Elias Daniel
%	Ligorria, Alexis Enrique
%	Suazo, Leonardo Ezequiel
%---------------------------------------------------------------------------------------------------%
:- dynamic
        kb/1.
:- dynamic
        ee/2.
ee(X,X):-
	!,
	fail.
%---------------------------------------------------------------------------------------------------%
								   %---------- LIMPIAR BC ----------%
% Limpiar la base de conocimiento
limpiarBC:-
	retractall(kb(_)),
	retractall(ee(_,_)).
%---------------------------------------------------------------------------------------------------%
								      %---------- MOSTRAR ----------%
% Mostrar las clausulas y sus relaciones de importancia
mostrarBC(KB, EE):-
	findall(X,kb(X),KB),
	findall([Y,Z], ee(Y,Z),	EE).
%---------------------------------------------------------------------------------------------------%
								     %---------- EXPANDIR ----------%
% Inserta A en la BC y las relaciones de importancia asociadas
expandirBC(A,[B,C]):-
	expandirBC(A),
	insertarSuEE(B,A),
	insertarMaEE(C,A).
%---------------------------------------------------------------------------------------------------%
% Inserta A en la BC
expandirBC(A):-
	kb(A),!.
expandirBC(A):-
	asserta(kb(A)).
%---------------------------------------------------------------------------------------------------%
% Inserta las relaciones de importancia que contien las creencias a lo sumo tan importanes como A
insertarSuEE([],_):-!.
insertarSuEE([B|C],A):-
	insertarSuEE(C,A),
	insertarEE(A,B),!.
insertarSuEE(B,A):-
	insertarEE(A,B),!.
%---------------------------------------------------------------------------------------------------%
% Inserta las relaciones de importancia que contien las creencias mas importanes que A
insertarMaEE([],_):-!.
insertarMaEE([B|C],A):-
	insertarMaEE(C,A),
	insertarEE(B,A),!.
insertarMaEE(B,A):-
	insertarEE(B,A),!.
%---------------------------------------------------------------------------------------------------%
% Inserta una ralacion de importancia particular
insertarEE(A,B):-
	ee(A,B),!.
insertarEE(A,B):-
	asserta(ee(A,B)).
%---------------------------------------------------------------------------------------------------%
								   % ---------- CONTRAER ---------- %
% Presenta las diferentes opciones por las cuales se puede contraer
opcionesContraccion(A, EMImp, CMImp, EMCant):-
	findall(K0,deduce(A,K0),K),
	listaNoVacia(K),
	menosImportantes(K, EMImp),
	masImportantes(K, CMImp),
	minimosDeCadaUno(K,EMCant).
%---------------------------------------------------------------------------------------------------%
contraccionPorMinimaCantidad(A):-
	findall(K0,deduce(A,K0),K),
	minimosDeCadaUno(K,Min),
	eliminarDeBC(Min).
%---------------------------------------------------------------------------------------------------%
contraccionPorMenosImportantes(A):-
	findall(K0,deduce(A,K0),K),
	menosImportantes(K,MenImp),
	eliminarDeBC(MenImp).
%---------------------------------------------------------------------------------------------------%
contraccionPorMantenerMasImportantes(A):-
	findall(K0,deduce(A,K0),K),
	masImportantes(K,MasImp),
	eliminarDeBC(MasImp).
%---------------------------------------------------------------------------------------------------%
% verifica que la longitud de una determinada lista sea mayor a cero
listaNoVacia(K):-
	longLista(K,0),
	!,
	fail.
listaNoVacia(_).
%---------------------------------------------------------------------------------------------------%
								 % ---------- CONSOLIDAR ---------- %
% Presenta las diferentes opciones por las cuales se puede consolidar
opcionesConsolidar(EMImp, ConsMasImp, ElimMinCant):-
	opcionesContraccion(false, EMImp, ConsMasImp, ElimMinCant),
	!.
opcionesConsolidar([], [], []).
%---------------------------------------------------------------------------------------------------%
consolidarPorMinimaCantidad:-
	contraccionPorMinimaCantidad(false).
%---------------------------------------------------------------------------------------------------%
consolidarPorMenosImportantes:-
	contraccionPorMenosImportantes(false).
%---------------------------------------------------------------------------------------------------%
consolidarPorMantenerMasImportantes:-
	contraccionPorMantenerMasImportantes(false).
%---------------------------------------------------------------------------------------------------%
								    % ---------- REVISAR ---------- %
% Presenta las diferentes opciones por las cuales se puede revisar
opcionesRevision(A, EMImp, ConsMasImp, ElimMinCant):-
	opcionesContraccion(no(A), EMImp, ConsMasImp, ElimMinCant),
	!.
opcionesRevision(_,[], [], []).
%---------------------------------------------------------------------------------------------------%
revisarPorMenosImportantes(A):-
	contraccionPorMenosImportantes(no(A)),
	expandirBC(A).
%---------------------------------------------------------------------------------------------------%
revisarPorMantenerMasImportantes(A):-
	contraccionPorMantenerMasImportantes(no(A)),
	expandirBC(A).
%---------------------------------------------------------------------------------------------------%
revisarPorMinimaCantidad(A):-
	contraccionPorMinimaCantidad(no(A)),
	expandirBC(A).
%---------------------------------------------------------------------------------------------------%
								   % ---------- KERNELS  ---------- %
%% subconjuntos minimales de K  que deriban X
deduce(X,K):-
	posiblesSubconjuntos(L),
	unificarSubconjunto(L,K),
	deduceEn(X,K),
	subconjuntoMinimo(X,K).
%---------------------------------------------------------------------------------------------------%
% genera todos los posibles subconjuntos minimmales de la BC
posiblesSubconjuntos(L):-
	findall(X,kb(X),KB),
	findall(Y, posiblesSubconjuntosL(KB,Y),L0),
	eliminarRepetidosLista(L0,L).
%---------------------------------------------------------------------------------------------------%
posiblesSubconjuntosL(X,X).
posiblesSubconjuntosL(K,L):-
	eliminarUno(K,K1),
	posiblesSubconjuntosL(K1,L).
%---------------------------------------------------------------------------------------------------%
eliminarUno([_|Xs],Xs).
eliminarUno([X|Xs],[X|Y]):-
	eliminarUno(Xs,Y).
%---------------------------------------------------------------------------------------------------%
%elimina los repetidos de una lista
eliminarRepetidosLista([X|Y],[X|Z]):-
	tieneRepetidoLista(X,Y),
	noElemEnLista(X,Y,L1),
	eliminarRepetidosLista(L1,Z),!.
eliminarRepetidosLista([X|Y],[X|Z]):-
	eliminarRepetidosLista(Y,Z),!.
eliminarRepetidosLista(X,X).
%---------------------------------------------------------------------------------------------------%
%verifica si una lista tiene elementos repetidos
tieneRepetidoLista(X, X):-
	!.
tieneRepetidoLista(X, [X|_]):-
	!.
tieneRepetidoLista(X, [_|Y]):-
	tieneRepetidoLista(X,Y).
%---------------------------------------------------------------------------------------------------%
%verifica si una lista no contiene a un elemento en particular
noElemEnLista(X, [Y|X], Y):-
	!.
noElemEnLista(X, [X|Y], Z):-
	noElemEnLista(X, Y, Z),
	!.
noElemEnLista(X, [W|Y], [W|Z]):-
	noElemEnLista(X, Y, Z),
	!.
noElemEnLista(_, Z, Z).
%---------------------------------------------------------------------------------------------------%
% Se unifica la BC con alguno de los subconjuntos de la lista
unificarSubconjunto([Y|_], Y).
unificarSubconjunto([_|Ys], Z):-
	unificarSubconjunto(Ys,Z).
%---------------------------------------------------------------------------------------------------%
deduceSubc([X|[]], X1):-
	fnc(X,X1),!.
deduceSubc([X|Xs], Z):-
	deduceSubc(Xs,Y1),fnc(X,X1),
	unirConj(X1,Y1, Z),!.
deduceSubc(X, X1):-
	fnc(X,X1).
%---------------------------------------------------------------------------------------------------%
% Verifica si el subconjunto deduce Alpha(X)
deduceEn(X,Y):-
	fnc(no(X),X1),
	deduceSubc(Y,Y0),
	resolverYSimplificar(Y0 -y- X1,false).
%---------------------------------------------------------------------------------------------------%
% verifica si el subconjunto es minimo
subconjuntoMinimo(X,Y):-
	findall(Z0,unaSubListaDeduc(X,Y,Z0),Z),
	longLista(Z,0).
%---------------------------------------------------------------------------------------------------%
unaSubListaDeduc(X,Y,Ys):-
	eliminarUno(Y,Ys),
	deduceEn(X,Ys).
%---------------------------------------------------------------------------------------------------%
resolverYSimplificar(X,Z):-
	resolver(X,X1),
	simplificar(X1, X2),
	simplificar(X2,X3),
	simplificarConjunciones(X3,Z).
%---------------------------------------------------------------------------------------------------%
resolver(X-y-Y,Z):-
	resolver(X,X1),
	resolver(Y,Y1),
	resolverDos([X1]-y-[Y1],Z0),
	aplanarSimple(Z0,Z),
	!.
resolver([X],Z):-
	resolver(X,Z0),
	aplanarSimple(Z0,Z),
	!.
resolver(X,X).
%---------------------------------------------------------------------------------------------------%
resolverDos([X],[Z]):-
	resolverDos(X,Z),
	!.
resolverDos(X -y- Y,Z):-
	resolverDos(X,X1),
	resolverConj(X1,Y,Z0),
	aplanarUnirDisj(Z0,Z),
	!.
resolverDos(X, Z):-
	aplanarUnirDisj(X,Z),!.
%---------------------------------------------------------------------------------------------------%
resolverConj([Y],[X1 -o- X2], Z):-
	resolverConj([X1],[Y], Z0),
	resolverDos(Z0,Z1),
	unirConj([X2],[Y], Z2),
	resolverDos(Z2,Z3),
	unirDisj(Z1,Z3,Z4),
	resolverDos(Z4,Z),
	!.
resolverConj([X1 -o- X2],[Y], Z):-
	resolverConj([X1],[Y], Z0),
	resolverDos(Z0,Z1),
	unirConj([X2],[Y], Z2),
	resolverDos(Z2,Z3),
	unirDisj(Z1,Z3,Z4),
	resolverDos(Z4,Z),
	!.
resolverConj(X,Y, Z):-
	unirConj(X,Y, Z).
%---------------------------------------------------------------------------------------------------%
aplanarUnirDisj(X,Z):-
	aplanarLastDisj(X, X1, Z0),
	aplanarUnirDisj(X1,Z2),
	unirDisj(Z2,[Z0],Z),
	!.
aplanarUnirDisj(X,X).
%---------------------------------------------------------------------------------------------------%
aplanarLastDisj(X -y- [Y], X0, Z):-
	aplanarLastDisj(X, X0, X1),
	unirConj(X1,Y,Z),!.
aplanarLastDisj(X -o- [Y], X, Y):-
	!.
aplanarLastDisj([X],[],X).
%---------------------------------------------------------------------------------------------------%
aplanarSimple(X,Z):-
	aplanarConjSimple(X,Z0),
	aplanarDisjSimple(Z0,Z).
%---------------------------------------------------------------------------------------------------%
aplanarConjSimple([X],Z):-
	aplanarConjSimple(X,Z),!.
aplanarConjSimple([X -o- Y],Z):-
	aplanarConjSimple(X-o-Y,Z),!.
aplanarConjSimple(X -o- Y,Z):-
	aplanarConjSimple(X,X1),
	aplanarConjSimple(Y,Y1),
	unirDisj([X1],[Y1],Z),
	!.
aplanarConjSimple(X -y- Y,Z):-
	aplanarConjSimple(X,X1),
	aplanarConjSimple(Y,Y1),
	unirConj(X1,Y1,Z),
	!.
aplanarConjSimple(X,X).
%---------------------------------------------------------------------------------------------------%
aplanarDisjSimple([X -o- Y],Z):-
	aplanarDisjSimple(X,X1),
	aplanarTotalSimple(Y,Y1),
	unirDisj(X1,Y1,Z0),
	aplanarTotalSimple(Z0,Z),
	!.
aplanarDisjSimple(X -o- Y,Z):-
	aplanarDisjSimple(X,X1),
	aplanarTotalSimple(Y,Y1),
	unirDisj(X1,Y1,Z0),
	aplanarTotalSimple(Z0,Z),!.
aplanarDisjSimple(X,Z):-
	aplanarTotalSimple(X,Z).
%---------------------------------------------------------------------------------------------------%
aplanarTotalSimple([X -o- Y],Z):-
	aplanarTotalSimple(X-o-Y,Z),
	!.
aplanarTotalSimple(X,X).
%---------------------------------------------------------------------------------------------------%
% elimina las sentencias falsas de la disjuncion
simplificar(false -o- X, X1):-
	simplificar(X,X1),
	!.
simplificar(X -o- false, X1):-
	simplificar(X,X1),
	!.
simplificar(X -o- Y, X1):-
	esContradiccion(Y),
	simplificar(X,X1),
	!.
simplificar(X -o- Y, X1 -o- Y):-
	simplificar(X,X1),
	!.
simplificar(X, false):-
	esContradiccion(X),
	!.
simplificar(X, X).
%---------------------------------------------------------------------------------------------------%
%Verifica si el los valores ingresado son contradictorios
esContradiccion([X]):-
	esContradiccion(X),
	!.
esContradiccion(X -y- X1):-
	complementarios(X,X1),
	!.
esContradiccion(Y -y- X):-
	tieneComplementarioConj(X,Y),
	!.
esContradiccion(Y -y- _):-
	esContradiccion(Y),
	!.
%---------------------------------------------------------------------------------------------------%
tieneComplementarioConj(X, X1):-
	complementarios(X,X1),!.
tieneComplementarioConj(X, _ -y- X1):-
	complementarios(X,X1),!.
tieneComplementarioConj(X, Y -y- _):-
	tieneComplementarioConj(X,Y).
%---------------------------------------------------------------------------------------------------%
% elimina las sentencias repetidas en las conjunciones
simplificarConjunciones(X -o- Y, X1 -o- Y1):-
	eliminarConjRepetidas(X,X1),
	simplificarConjunciones(Y, Y1),
	!.
simplificarConjunciones(X , X1):-
	eliminarConjRepetidas(X,X1).
%---------------------------------------------------------------------------------------------------%
eliminarConjRepetidas(X -y- X,X):-
	!.
eliminarConjRepetidas(Y -y- X,Z -y- X):-
	tieneConjRepetido(X,Y),
	sinConjX(X,Y,L1),
	eliminarConjRepetidas(L1,Z),
	!.
eliminarConjRepetidas(Y -y- X,Z -y- X):-
	eliminarConjRepetidas(Y,Z),
	!.
eliminarConjRepetidas([X] , [Z]):-
	eliminarConjRepetidas(X,Z),
	!.
eliminarConjRepetidas(X , X).
%---------------------------------------------------------------------------------------------------%
%Verifica si tiene 2 elementos repetidos
tieneConjRepetido(X, X):-
	!.
tieneConjRepetido(X, _ -y- X):-
	!.
tieneConjRepetido(X, Y -y- _):-
	tieneConjRepetido(X,Y).
%---------------------------------------------------------------------------------------------------%
sinConjX(X, X -y- Y, Y):-
	!.
sinConjX(X, Y -y- X, Z):-
	sinConjX(X, Y, Z),
	!.
sinConjX(X, Y -y- W, Z -y- W):-
	sinConjX(X, Y, Z),
	!.
sinConjX(_, Z, Z).
%---------------------------------------------------------------------------------------------------%
								% ---------- Que eliminar---------- %
% minima cantidad a descartar
minimosDeCadaUno(X,Y):-
	findall(L,unoDeCadaUnoSinRep(X,L), L2),
	listaNoVacia(L2),
	minimaLista(L2,Y),
	!.
minimosDeCadaUno(_,[]).
%---------------------------------------------------------------------------------------------------%
unoDeCadaUnoSinRep(X,Y):-
	unoDeCadaUno(X, W),
	eliminarRepetidosLista(W,Y).
%---------------------------------------------------------------------------------------------------%
unoDeCadaUno([X|Xs],[X1|L]):-
	unificarSubconjunto(X,X1),
	unoDeCadaUno(Xs,L).
unoDeCadaUno([X],[X1]):-
	unificarSubconjunto(X,X1).
%---------------------------------------------------------------------------------------------------%
minimaLista(L,X):-
	minimaListaCantidad(L,0,X),
	!.
%---------------------------------------------------------------------------------------------------%
minimaListaCantidad(L,C,Lz):-
	minimaListaCantidadC(L,C,Lz),
	!.
minimaListaCantidad(L,C,Lz):-
	succ(C, C2),
	minimaListaCantidad(L,C2,Lz),
	!.
minimaListaCantidadC([L|_], C, L):-
	longLista(L,C),
	!.
minimaListaCantidadC([_|Ls], C, Lz):-
	minimaListaCantidadC(Ls,C,Lz),
	!.
%---------------------------------------------------------------------------------------------------%
% Longitd de una lista
longLista([],0):-
	!.
longLista([_|Xs],C2):-
	longLista(Xs,C),
	succ(C,C2),
	!.
%---------------------------------------------------------------------------------------------------%
% menos importantes a descartar
menosImportantes(La,Lz):-
	findall(X,menosImportantes0(La,X), Ln),
	listaNoVacia(Ln),
	eliminarRepetidosLista(Ln,Lz),
	!.
%---------------------------------------------------------------------------------------------------%
menosImportantes(La,Lp):-
	aplanarTodosLista(La, Lp).

menosImportantes0(La,Lz):-
	unificarSubconjunto(La,Ln),
	menosImportante(Ln, Lz).
%---------------------------------------------------------------------------------------------------%
menosImportante(L,X):-
	unificarSubconjunto(L,X),
	noHayAlgunoMenosImportante(X,L).
%---------------------------------------------------------------------------------------------------%
noHayAlgunoMenosImportante(X,L):-
	hayAlgunoMenosImportante(X,L),
	!,
	fail.
noHayAlgunoMenosImportante(_,_).
%---------------------------------------------------------------------------------------------------%
hayAlgunoMenosImportante(Y,[Y|Xs]):-
	hayAlgunoMenosImportante(Y,Xs),
	!.
hayAlgunoMenosImportante(Y,[X|_]):-
	ee(X,Y),
	!.
hayAlgunoMenosImportante(Y,[_|Xs]):-
	hayAlgunoMenosImportante(Y,Xs),
	!.
hayAlgunoMenosImportante(Y,X):-
	ee(X,Y),
	!.
%---------------------------------------------------------------------------------------------------%
% más importantes a preservar
masImportantes(La,Lz):-
	findall(X,masImportantes0(La,X), Ln),
	aplanarTodosLista(Ln, Lp),
    listaNoVacia(Lp),
	eliminarRepetidosLista(Lp,Lz),
	!.
masImportantes(La,Lp):-
	aplanarTodosLista(La, Lp).
%---------------------------------------------------------------------------------------------------%
masImportantes0(La,Lz):-
	unificarSubconjunto(La,Ln),
	masImportante(Ln, Lp),
	borrarTodos(Lp,Ln,Lz).
%---------------------------------------------------------------------------------------------------%
masImportante(L,X):-
	unificarSubconjunto(L,X),
	noHayAlgunoMasImportante(X,L).
%---------------------------------------------------------------------------------------------------%
noHayAlgunoMasImportante(X,L):-
	hayAlgunoMasImportante(X,L),
	!,
	fail.
noHayAlgunoMasImportante(_,_).
%---------------------------------------------------------------------------------------------------%
hayAlgunoMasImportante(Y,[Y|Xs]):-
	hayAlgunoMasImportante(Y,Xs),
	!.
hayAlgunoMasImportante(Y,[Y|_]):-
	ee(Y,Y),
	!,
	fail.
hayAlgunoMasImportante(Y,[X|_]):-
	ee(Y,X),
	!.
hayAlgunoMasImportante(Y,[_|Xs]):-
	hayAlgunoMasImportante(Y,Xs),
	!.
hayAlgunoMasImportante(Y,X):-
	ee(Y,X),
	!.
%---------------------------------------------------------------------------------------------------%
					     % ---------- ELIMINAR CONOCIMIENTO DE LA BC ---------- %
eliminarDeBC([X|Xs]):-
	kb(X),
	retract(kb(X)),
	retractall(ee(_,X)),
	retractall(ee(X,_)),
	eliminarDeBC(Xs),
	!.
eliminarDeBC(X):-
	kb(X),
	retract(kb(X)),
	retractall(ee(_,X)),
	retractall(ee(X,_)),
	!.
eliminarDeBC(_).
%---------------------------------------------------------------------------------------------------%
									% ---------- FNC ---------- %
fnc(X,Z):-
	normalizarDisjuncion(X,X1),
	agregarParentesis(X1,X2),
	formaConj(X2,X3),
	aplanarConj(X3,X4),
	eliminarRedundancias(X4,X5),
	eliminarRedundancias(X5,X6),
	eliminarTautologias(X6,Z).
%---------------------------------------------------------------------------------------------------%
%Transforma una sentencia utilizando reglas de equivalencias
normalizarDisjuncion(X -> Y,Z):-
	normalizarDisjuncion(X, X1),
	normalizarDisjuncion(Y,Y1),
	normalizarDisjuncion(no(X1) -o- Y1,Z),
	!.
normalizarDisjuncion(no(no(X)),Z):-
	normalizarDisjuncion(X,Z),
	!.
normalizarDisjuncion(no(X -o- Y),Z):-
	normalizarDisjuncion(X, X1),
	normalizarDisjuncion(Y,Y1),
	normalizarDisjuncion(no(X1) -y- no(Y1),Z),
	!.
normalizarDisjuncion(no(X -y- Y),Z):-
	normalizarDisjuncion(X, X1),
	normalizarDisjuncion(Y,Y1),
	normalizarDisjuncion(no(X1) -o- no(Y1),Z),
	!.
normalizarDisjuncion(no(X -> Y),Z):-
	normalizarDisjuncion(X, X1),
	normalizarDisjuncion(Y,Y1),
	normalizarDisjuncion(X1 -y- no(Y1),Z),
	!.
normalizarDisjuncion(no(no(X)),Z):-
	normalizarDisjuncion(X,Z),
	!.
normalizarDisjuncion(X -o- (Y),Z):-
	normalizarDisjuncion(X, X1),
	normalizarDisjuncion(Y,Y1),
	unirDisj(X1,Y1, Z),
	!.
normalizarDisjuncion(X -o- Y,Z):-
	normalizarDisjuncion(X, X1),
	normalizarDisjuncion(Y,Y1),
	unirDisj(X1,Y1, Z),
	!.
normalizarDisjuncion(X -y- Y,Z):-
	normalizarDisjuncion(X, X1),
	normalizarDisjuncion(Y,Y1),
	unirConj(X1,Y1, Z),
	!.
normalizarDisjuncion(X,X).
%---------------------------------------------------------------------------------------------------%
%Utilizado para mantener la forma conjuntiva en la expresion
formaConj([X] -y- [Y],Z):-
	formaConj(X ,X1) ,
	formaConj(Y ,Y1) ,
	unirConj(X1,Y1, Z),
	!.
formaConj(true -o- Z, Z1):-
	formaConj(Z ,Z1) ,
	!.
formaConj(Y -o- X, W1):-
	formaConj(X ,X1),
	formaConj(Y ,Y1),
	normalizarConj2(Y1, X1, W),
	formaConj(W ,W1) ,
	!.
formaConj(X,[X]):-
	atom(X),
	!.
formaConj(X,X).
%---------------------------------------------------------------------------------------------------%
normalizarConj2(Y1 -y- Y2 , X, Z1 -y- Z2):-
	normalizarConj2(Y1,X,Z1),
	normalizarConj2(Y2,X,Z2),
	!.
normalizarConj2(X, Y1 -y- Y2 , Z1 -y- Z2):-
	normalizarConj2(Y1,X,Z1),
	normalizarConj2(Y2,X,Z2),
	!.
normalizarConj2(Y, X, [X -o- Y]).
%---------------------------------------------------------------------------------------------------%
esConj(_ -y- _).
%---------------------------------------------------------------------------------------------------%
%Elimina las expresiones redundantes
eliminarRedundancias(X -y- [Y],Z):-
	eliminarRedundancias(X,X1),
	eliminarRedundancias(Y,Y1),
	unirConj(X1,[Y1], Z),
	!.
eliminarRedundancias(X -o- Y,Z):-
	eliminarRepetidos(X -o- Y,L1),
	eliminarComplementarios(L1,Z),
	!.
eliminarRedundancias([X],[X1]):-
	eliminarRedundancias(X,X1),
	!.
eliminarRedundancias(X, X).
%---------------------------------------------------------------------------------------------------%
%Elimina las expresiones repetidas
eliminarRepetidos(X -o- X,X):-
	!.
eliminarRepetidos(Y -o- X,Z -o- X):-
	tieneRepetido(X,Y),
	sinX(X,Y,L1),
	eliminarRepetidos(L1,Z),
	!.
eliminarRepetidos(Y -o- X,Z -o- X):-
	eliminarRepetidos(Y,Z),
	!.
eliminarRepetidos(X , X).
%---------------------------------------------------------------------------------------------------%
tieneRepetido(X, X):-
	!.
tieneRepetido(X, _ -o- X):-
	!.
tieneRepetido(X, Y -o- _):-
	tieneRepetido(X,Y).
%---------------------------------------------------------------------------------------------------%
sinX(X, X -o- Y, Y):-
	!.
sinX(X, Y -o- X, Z):-
	sinX(X, Y, Z),
	!.
sinX(X, Y -o- W, Z -o- W):-
	sinX(X, Y, Z),
	!.
sinX(_, Z, Z).
%---------------------------------------------------------------------------------------------------%
eliminarComplementarios(X -o- X1, true):-
	complementarios(X,X1),!.
eliminarComplementarios(Y -o- X,Z-o- true):-
	tieneComplementario(X,Y),
	sinComplementario(X,Y,L1),
	eliminarComplementarios(L1,Z ),
	!.
eliminarComplementarios(Y -o- X,Z -o- X):-
	eliminarComplementarios(Y,Z),
	!.
eliminarComplementarios(true -o- true, true):-
	!.
eliminarComplementarios(X , X).
%---------------------------------------------------------------------------------------------------%
complementarios(no(X),X).
complementarios(X,no(X)).
%---------------------------------------------------------------------------------------------------%
tieneComplementario(X, X1):-
	complementarios(X,X1),
	!.
tieneComplementario(X, _ -o- X1):-
	complementarios(X,X1),
	!.
tieneComplementario(X, Y -o- _):-
	tieneComplementario(X,Y).
%---------------------------------------------------------------------------------------------------%
sinComplementario(X, X1 -o- Y, Y):-
	complementarios(X,X1),
	!.
sinComplementario(X, Y -o- X1, Z):-
	complementarios(X,X1),
	sinComplementario(X, Y, Z),
	!.
sinComplementario(X, Y -o- W, Z -o- W):-
	sinComplementario(X, Y, Z),!.
sinComplementario(_, Z, Z).
%---------------------------------------------------------------------------------------------------%
%Elimina las tautologias
eliminarTautologias(X -y- [Y],X1):-
	esTautologia(Y),
	eliminarTautologias(X,X1),
	!.
eliminarTautologias(X -y- [Y],X1 -y- [Y]):-
	eliminarTautologias(X,X1),!.
eliminarTautologias(X,X).
%---------------------------------------------------------------------------------------------------%
%Verifica si una construccion logica es siempre verdadera
esTautologia(_ -o- X):-
	esTautologia(X),
	!.
esTautologia(X -o- _):-
	esTautologia(X),
	!.
esTautologia(true).
%---------------------------------------------------------------------------------------------------%
agregarParentesis(true, true):-
	!.
agregarParentesis(X, C2 -o- (C1)):-
	ultimoConj(X,B1,C1),
	agregarParentesis(B1,C2),
	!.
agregarParentesis(X,(X)):-
	ultimoConj(X,true,X),
	!.
%---------------------------------------------------------------------------------------------------%
ultimoConj(X -o- Y, X, Y):-
	!.
ultimoConj(X -y- Y, X1, Y1 -y- Y):-
	ultimoConj(X, X1, Y1),
	!.
ultimoConj(X ,true, X).
%---------------------------------------------------------------------------------------------------%
									% ---------- PREDICADOS PARA APLANAR ---------- %
aplanar([[X]], [X1]):-
	aplanar(X,X1),
	!.
aplanar([X], [X1]):-
	aplanar(X,X1),
	!.
aplanar(X -y- Y, Z):-
	aplanar(X,X1),
	aplanar(Y,Y1),
	unirConj(X1,Y1, Z),
	!.
aplanar(X -o- Y,Z):-
	aplanar(X,X1),
	aplanar(Y,Y1),
	unirDisj(X1,Y1, Z),
	!.
aplanar(X, X).
%---------------------------------------------------------------------------------------------------%
aplanarConj(X -y- Y, Z):-
	aplanarDisj(X,X1),
	aplanarDisj(Y,Y1),
	aplanarConj(X1,X2),
	aplanarConj(Y1,Y2),
    unirConj(X2,Y2, Z),
	!.
aplanarConj(X, X1):-
	aplanarDisj(X,X1).
%---------------------------------------------------------------------------------------------------%
aplanarDisj([[X] -o- [Y]], [Z]):-
	aplanarDisj(X,X1),
	aplanarDisj(Y,Y1),
	unirDisj(X1,Y1, Z),
	!.
aplanarDisj([X -o- [Y]], [Z]):-
	aplanarDisj(X,X1),
	aplanarDisj(Y,Y1),
	unirDisj(X1,Y1, Z),
	!.
aplanarDisj([[X] -o- Y], [Z]):-
	aplanarDisj(X,X1),
	aplanarDisj(Y,Y1),
	unirDisj(X1,Y1, Z),
	!.
aplanarDisj([X -o- Y], [Z]):-
	aplanarDisj(X,X1),
	aplanarDisj(Y,Y1),
	unirDisj(X1,Y1, Z),
	!.
aplanarDisj(X -o- [Y], Z):-
	aplanarDisj(X,X1),
	aplanarDisj(Y,Y1),
	unirDisj(X1,Y1, Z),
	!.
aplanarDisj([X] -o- Y, Z):-
	aplanarDisj(X,X1),
	aplanarDisj(Y,Y1),
	unirDisj(X1,Y1, Z),
	!.
aplanarDisj(X, X).
%---------------------------------------------------------------------------------------------------%
unirConj(X, Y1 -y- Y2,  Z -y- Y2):-
	unirConj(X, Y1, Z),
	!.
unirConj(X, Y1 -o- Y2,  Z):-
	unirConj(X, Y1, Z1),
	unirDisj(Z1,Y2, Z),
	!.
unirConj([],X,X):-
	!.
unirConj(X,[],X):-
	!.
unirConj(X, Y,  X -y- Y):-
	!.
%---------------------------------------------------------------------------------------------------%
unirDisj(X, Y1 -o- Y2,  Z -o- Y2):-
	unirDisj(X, Y1, Z),
	!.
unirDisj(X, Y1 -y- Y2,  Z):-
	unirDisj(X, Y1, Z1), unirConj(Z1,Y2, Z),
	!.
unirDisj([],X,X):-
	!.
unirDisj(X,[],X):-
	!.
unirDisj(X, Y,  X -o- Y):-
	!.
%---------------------------------------------------------------------------------------------------%
%Borra la primer ocurrencia de un elemento dentro de una lista
borrarUn(_,[],[]):-
	!.
borrarUn(X,[X|Xs],Xs):-
	!.
borrarUn(X,[Y|Xs],[Y|Z]):-
	borrarUn(X,Xs,Z).

borrarTodos([],Y,Y):-!.
borrarTodos([X|Xs],Y,Z):-
	borrarUn(X,Y,Zo),
	borrarTodos(Xs,Zo,Z),
	!.
borrarTodos(X,Y,Z):-
	borrarUn(X,Y,Z).
%---------------------------------------------------------------------------------------------------%
aplanarTodosLista([],[]):-
	!.
aplanarTodosLista([X|Xs],Y):-
	aplanarTodosLista(Xs,Ys),
	concatenarListas(X,Ys,Y),
	!.
aplanarTodosLista(X,X).
%---------------------------------------------------------------------------------------------------%
% concatena 2 listas
concatenarListas([],L,L):-
	!.
concatenarListas([X|Xs],Ys,[X|Zs]):-
	concatenarListas(Xs,Ys,Zs).
%---------------------------------------------------------------------------------------------------%
								% ---------- PHP  ---------- %
imprimirPorPHP :- mostrarBC(KB,EE), write('KB= '),write(KB),write(' <br>EE= '),write(EE), write('<br><br>').

expandirPorPHP(Conocimiento,'','') :-
	expandirBC(Conocimiento,[[],[]]).

expandirPorPHP(Conocimiento,'',MenImpQue) :-
	expandirBC(Conocimiento,[[],MenImpQue]).

expandirPorPHP(Conocimiento,TanImpComo,'') :-
	expandirBC(Conocimiento,[TanImpComo,[]]).

expandirPorPHP(Conocimiento,TanImpComo,MenImpQue) :-
	expandirBC(Conocimiento,[TanImpComo,MenImpQue]).

opcionesContraccionPHP(A) :-
	opcionesContraccion(A, Emi, Cmi, Emc).
%	write('Eliminar por menos importante= '),
%	write(Emi),
%	write('<br><br>'),
%	write('Eliminar conservando mas importantes= '),
%	write(Cmi),
%	write('<br><br>'),
%	write('Eliminar por minima cantidad= '),
%	write(Emc),
%	write('<br><br>').

contraerPorMenosImportantePHP(A):-
	contraccionPorMenosImportantes(A).

contraerPorMantenerMasImportantesPHP(A):-
	contraccionPorMantenerMasImportantes(A).

contraerPorMinimaCantidadPHP(A):-
	contraccionPorMinimaCantidad(A).

opcionesRevisarPHP(A) :-
	opcionesRevision(A, Rmi, Rmai, Rmc).
%	write('Revisar por menos importante= '),
%	write(Rmi),
%	write('<br><br>'),
%	write('Revisar por mas importantes= '),
%	write(Rmai),
%	write('<br><br>'),
%	write('Revisar por minima cantidad= '),
%	write(Rmc),
%	write('<br><br>').

revisarPorMenosImportantePHP(A):-
	revisarPorMenosImportantes(A).

revisarPorMantenerMasImportantesPHP(A):-
	revisarPorMantenerMasImportantes(A).

revisarPorMinimaCantidadPHP(A):-
	revisarPorMinimaCantidad(A).

opcionesConsolidarPHP :-
	opcionesConsolidar(ElimMenImp, ConsMasImp, ElimMinCant).
%	write('Consolidar por menos importante= '),
%	write(ElimMenImp),
%	write('<br><br>'),
%	write('Consolidar conservando mas importantes= '),
%	write(ConsMasImp),
%	write('<br><br>'),
%	write('Consolidar por minima cantidad= '),
%	write(ElimMinCant),
%	write('<br><br>').

consolidarPorMenosImportantePHP:-
	consolidarPorMenosImportantes.

consolidarPorMantenerMasImportantesPHP:-
	consolidarPorMantenerMasImportantes.

consolidarPorMinimaCantidadPHP:-
	consolidarPorMinimaCantidad.



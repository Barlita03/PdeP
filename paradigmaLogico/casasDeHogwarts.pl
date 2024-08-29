%persona(Nombre, [Caracteristicas], statusSangre, casaQueOdia).
persona(harry, [corajudo, amistoso, orgulloso, inteligente], mestiza, slytherin).
persona(draco, [orgulloso, inteligente], pura, hufflepuff).
persona(hermione, [responsable, orgulloso, inteligente], impura, _).

%caracteristicaImportante(Casa, Caracteristica).
caracteristicaImportante(gryffindor, corajudo).
caracteristicaImportante(slytherin, orgulloso).
caracteristicaImportante(slytherin, inteligente).
caracteristicaImportante(ravenclaw, inteligente).
caracteristicaImportante(ravenclaw, responsable).
caracteristicaImportante(hufflepuff, amistoso).

casa(Casa) :-
    caracteristicaImportante(Casa, _).

mago(Mago) :-
    persona(Mago, _, _, _).

%%%%%%%%%%%%%%%%
%%%%%PARTE1%%%%%
%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%
%%%%%PUNTO1%%%%%
%%%%%%%%%%%%%%%%

noPuedeEntar(Mago, slytherin) :-
    persona(Mago, _, impura, _).

puedeEntrar(Mago, Casa) :-
    casa(Casa),
    mago(Mago),
    not(noPuedeEntar(Mago, Casa)).

%%%%%%%%%%%%%%%%
%%%%%PUNTO2%%%%%
%%%%%%%%%%%%%%%%

caracterApropiado(Mago, Casa) :-
    casa(Casa),
    persona(Mago, Caracteristicas, _, _),
    forall(caracteristicaImportante(Casa, Caracteristica), member(Caracteristica, Caracteristicas)).

%%%%%%%%%%%%%%%%
%%%%%PUNTO3%%%%%
%%%%%%%%%%%%%%%%

podriaQuedar(hermione, gryffindor).

podriaQuedar(Mago, Casa) :-
    caracterApropiado(Mago, Casa),
    puedeEntrar(Mago, Casa),
    not(persona(Mago, _, _, Casa)).

%%%%%%%%%%%%%%%%
%%%%%PUNTO4%%%%%
%%%%%%%%%%%%%%%%

cadenaDeAmistades(Magos) :-
    sonTodosAmistosos(Magos),
    cadenaDeCasas(Magos).

sonTodosAmistosos(Magos) :-
    forall(member(Mago, Magos), esAmistoso(Mago)).

esAmistoso(Mago) :-
    persona(Mago, Caracteristicas, _, _),
    member(amistoso, Caracteristicas).

cadenaDeCasas(Mago1 | Mago2 | Siguientes) :-
    podriaQuedar(Mago1, Casa),
    podriaQuedar(Mago2, Casa),
    cadenaDeCasas(Mago2 | Siguientes).

%%%%%%%%%%%%%%%%
%%%%%PARTE2%%%%%
%%%%%%%%%%%%%%%%

%accion(Mago, Accion, puntos).
accion(harry, registro(irAlBosque, -50)).
accion(harry, registro(irAlTercerPiso, -75)).
accion(harry, registro(vencerAVoldemort, 60)).
accion(harry, registro(andarFueraDeLaCama, -50)).
accion(hermione, registro(salvarAmigos, 50)).
accion(hermione, registro(irAlTercerPiso, -75)).
accion(hermione, registro(irALaSeccionRestringida, -10)).
accion(ron, registro(ganarAjedrez, 50)).

%pregunta(Pregunta, Dificultad, Profesor).
accion(hermione, pregunta("Dónde se encuentra un Bezoar", 20, snape)).
accion(hermione, pregunta("Como hacer levitar una pluma", 25, flitwick)).

%esDe(Mago, Casa).
esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).

%%%%%%%%%%%%%%%%
%%%%%PUNTO1%%%%%
%%%%%%%%%%%%%%%%

esBuenAlumno(Mago) :-
    accion(Mago, _),
    forall(accion(Mago, Accion), esUnaBuenaAccion(Accion)).

esUnaBuenaAccion(registro(_, Puntaje)) :-
    Puntaje > 0.

esUnaBuenaAccion(pregunta(_, _, _)).

accionRecurrente(Accion) :-
    accion(Mago, Accion),
    accion(OtroMago, Accion),
    Mago \= OtroMago.

%%%%%%%%%%%%%%%%
%%%%%PUNTO2%%%%%
%%%%%%%%%%%%%%%%

puntajeCasa(Casa, Puntaje) :-
    casa(Casa),
    findall(Puntos, (esDe(Mago, Casa), puntajeMago(Mago, Puntos)), ListaPuntos),
    sumlist(ListaPuntos, Puntaje).

puntajeMago(Mago, Puntaje) :-
    findall(Puntos, (accion(Mago, Accion), puntosPorAccion(Accion, Puntos)), ListaPuntos),
    sumlist(ListaPuntos, Puntaje).

puntosPorAccion(registro(_, Puntos), Puntos).

puntosPorAccion(pregunta(_, Puntos, snape), Puntaje) :- 
    Puntaje is Puntos // 2.

puntosPorAccion(pregunta(_, Puntos, Profesor), Puntos) :-
    Profesor \= snape.

%%%%%%%%%%%%%%%%
%%%%%PUNTO3%%%%%
%%%%%%%%%%%%%%%%

casaGanadora(Casa) :-
    puntajeCasa(Casa, Puntaje),
    forall(puntajeCasa(_, OtroPuntaje), OtroPuntaje =< Puntaje).

%%%%%%%%%%%%%%%%
%%%%%PUNTO4%%%%%
%%%%%%%%%%%%%%%%

%Lo movi a la linea 72 para que prolog no rompa las pelotas
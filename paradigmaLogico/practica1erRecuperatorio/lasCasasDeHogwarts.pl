%! %%%%%%%%%%%%%
%! %%%Parte 1%%%
%! %%%%%%%%%%%%%

%sangre(Nombre, Sangre)
sangre(harry, mestiza).
sangre(draco, pura).
sangre(hermione, impura).

%caracteristica(Nombre, Caracteristica)
caracteristica(harry, corajudo).
caracteristica(harry, amistoso).
caracteristica(harry, orgulloso).

caracteristica(draco, inteligente).
caracteristica(draco, orgulloso).

caracteristica(hermione, inteligente).
caracteristica(hermione, orgulloso).
caracteristica(hermione, responsable).

%odiaria(Nombre, Casa)
odiaria(harry, slytherin).
odiaria(draco, hufflepuff).

%mago(Nombre)
mago(Nombre) :-
    sangre(Nombre, _).

%criterioDeEleccion(Casa, Caracteristica)
criterioDeEleccion(gryffindor, corajudo).
criterioDeEleccion(slytherin, orgulloso).
criterioDeEleccion(slytherin, inteligente).
criterioDeEleccion(ravenclaw, inteligente).
criterioDeEleccion(ravenclaw, responsable).
criterioDeEleccion(hufflepuff, amistoso).

%casa(Casa)
casa(Casa) :-
    criterioDeEleccion(Casa, _).

%%%%%%%%%%%%%%%%%
%%%Ejercicio 1%%%
%%%%%%%%%%%%%%%%%

permiteEntrar(Mago, Casa) :-
    casa(Casa),
    mago(Mago),
    not(noPermiteEntrar(Mago, Casa)).

noPermiteEntrar(Mago, slytherin) :-
    sangre(Mago, impura).

%%%%%%%%%%%%%%%%%
%%%Ejercicio 2%%%
%%%%%%%%%%%%%%%%%

tieneElCaracterApropiado(Mago, Casa) :-
    casa(Casa),
    mago(Mago),
    forall(criterioDeEleccion(Casa, Criterio), caracteristica(Mago, Criterio)).

%%%%%%%%%%%%%%%%%
%%%Ejercicio 3%%%
%%%%%%%%%%%%%%%%%

puedeQuedarSeleccionado(hermione, gryffindor).

puedeQuedarSeleccionado(Mago, Casa) :-
    tieneElCaracterApropiado(Mago, Casa),
    permiteEntrar(Mago, Casa),
    not(odiaria(Mago, Casa)).

%%%%%%%%%%%%%%%%%
%%%Ejercicio 4%%%
%%%%%%%%%%%%%%%%%

cadenaDeAmistades(Magos) :-
    forall(member(Mago, Magos), caracteristica(Mago, amistoso)),
    podriaEstarEnLaMismaCasaQueElSiguiente(Magos).

podriaEstarEnLaMismaCasaQueElSiguiente( [ PrimerMago | [ SegundoMago | [] ] ] ).

podriaEstarEnLaMismaCasaQueElSiguiente( [ PrimerMago | [ SegundoMago | OtrosMagos ] ] ) :-
    podrianEstarEnLaMismaCasa(PrimerMago, SegundoMago),
    podriaEstarEnLaMismaCasaQueElSiguiente( [ SegundoMago | OtrosMagos ] ).

podrianEstarEnLaMismaCasa(UnMago, OtroMago) :-
    puedeQuedarSeleccionado(UnMago, Casa),
    puedeQuedarSeleccionado(OtroMago, Casa).

%! %%%%%%%%%%%%%
%! %%%Parte 2%%%
%! %%%%%%%%%%%%%

%accion(Mago, mala|buena(Acion, Puntos))
accion(harry, mala(andarFueraDeLaCama, 50)).
accion(harry, mala(irAlTercerPiso, 75)).
accion(harry, mala(irAlBosque, 50)).
accion(harry, buena(ganarleAVoldemort, 60)).

accion(hermione, mala(irAlTercerPiso, 75)).
accion(hermione, mala(irALaSeccionRestringida, 10)).
accion(hermione, buena(salvarAmigos, 50)).
accion(hermione, respuesta('Bezoar', snape, 20)).
accion(hermione, respuesta('Pluma', flitwick, 25)).

accion(draco, mala(irALasMazmorras, 0)).

accion(ron, buena(ganarPartida, 50)).

%esDe(Mago, Casa)
esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).

%%%%%%%%%%%%%%%%%
%%%Ejercicio 1%%%
%%%%%%%%%%%%%%%%%

esBuenAlumno(Mago) :-
    accion(Mago, _),
    not(accion(Mago, mala(_, _))).

esRecurrente(Accion) :-
    accion(UnMago, Accion),
    accion(OtroMago, Accion),
    UnMago \= OtroMago.

%%%%%%%%%%%%%%%%%
%%%Ejercicio 2%%%
%%%%%%%%%%%%%%%%%

puntosPorAccion(mala(_, Puntos), PuntosOtorgados) :-
    PuntosOtorgados is Puntos * -1.

puntosPorAccion(mala(_, Puntos), Puntos).

puntosPorAccion(respuesta(_, snape, Puntos), PuntosOtorgados) :-
    PuntosOtorgados is Puntos / 2.

puntosPorAccion(respuesta(_, Profesor, Puntos), Puntos) :-
    Profesor \= snape.

puntajeTotal(Casa, Puntaje) :-
    casa(Casa),
    findall(Puntos, puntosDeSusMagos(Casa, Puntos), ListaDePuntos),
    sumlist(ListaDePuntos, Puntaje).

puntosDeSusMagos(Casa, Puntos) :-
    esDe(Casa, Mago),
    accion(Mago, Accion),
    puntosPorAccion(Accion, Puntos).

%%%%%%%%%%%%%%%%%
%%%Ejercicio 3%%%
%%%%%%%%%%%%%%%%%

ganadoraDeLaCopa(Casa) :-
    puntajeTotal(Casa, Puntaje),
    forall(puntajeTotal(_, OtroPuntaje), OtroPuntaje =< Puntaje).

%%%%%%%%%%%%%%%%%
%%%Ejercicio 4%%%
%%%%%%%%%%%%%%%%%

%!Modificaciones realizadas a lo largo del codigo
%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%VOCALOIDS%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Base de conocimiento%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%

%vocaloid(Nombre)
vocaloid(megurineLuka).
vocaloid(hatsuneMiku).
vocaloid(gumi).
vocaloid(seeU).
vocaloid(kaito).

%canta(Vocaloid, Cancion)
canta(megurineLuka, cancion(nightFever, 4)).
canta(megurineLuka, cancion(foreverYoung, 5)).
canta(hatsuneMiku, cancion(tellYourWorld, 4)).
canta(gumi, cancion(foreverYoung, 4)).
canta(gumi, cancion(tellYourWorld, 5)).
canta(seeU, cancion(novemberRain, 6)).
canta(seeU, cancion(nightFever, 5)).

%%%%%%%%%%%%%%%%%
%%%Ejercicio 1%%%
%%%%%%%%%%%%%%%%%

novedoso(Vocaloid) :-
    sabeAlMenosDosCanciones(Vocaloid),
    duracionTotalDeSusCanciones(Vocaloid, Duracion),
    Duracion < 15.

sabeAlMenosDosCanciones(Vocaloid) :-
    canta(Vocaloid, UnaCancion),
    canta(Vocaloid, OtraCancion),
    UnaCancion \= OtraCancion.

duracionTotalDeSusCanciones(Vocaloid, DuracionTotal) :-
    findall(Duracion, canta(Vocaloid, cancion(_, Duracion)), Duraciones),
    sumlist(Duraciones, DuracionTotal).

%%%%%%%%%%%%%%%%%
%%%Ejercicio 2%%%
%%%%%%%%%%%%%%%%%

acelerado(Vocaloid) :-
    vocaloid(Vocaloid),
    not(cantaUnaCancionLarga(Vocaloid)).

cantaUnaCancionLarga(Vocaloid) :-
    canta(Vocaloid, cancion(_, Duracion)),
    Duracion > 4.

%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%CONCIERTOS%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%
%%%Ejercicio 1%%%
%%%%%%%%%%%%%%%%%

%concierto(Nombre, Pais, CantidadDeFama, Tipo)
% Tipo:
%     gigante(CantidadDeCanciones, DuracionTotalMinima)
%     mediano(DuracionTotalMaxima)
%     pequenio(DuracionMinima)

concierto(mikuExpo, estadosUnidos, 2000, gigante(2, 6)).
concierto(magicalMirai, japon, 3000, gigante(3, 10)).
concierto(vocalektVisions, estadosUnidos, 1000, mediano(9)).
concierto(mikuFest, argentina, 100, pequenio(4)).

%%%%%%%%%%%%%%%%%
%%%Ejercicio 2%%%
%%%%%%%%%%%%%%%%%

%puedeParticipar(Vocaloid, Concierto)
puedeParticipar(hatsuneMiku, _).

puedeParticipar(Vocaloid, Concierto) :-
    vocaloid(Vocaloid),
    concierto(Concierto, _, _, Requisitos),
    cumpleLosRequisitos(Vocaloid, Requisitos).

cumpleLosRequisitos(Vocaloid, gigante(CantidadMinimaDeCanciones, DuracionTotalMinima)) :-
    findall(Duracion, canta(Vocaloid, cancion(_, Duracion)), ListaDuraciones),
    length(ListaDuraciones, CantidadDeCanciones),
    sumlist(ListaDuraciones, DuracionTotal),
    CantidadDeCanciones >= CantidadMinimaDeCanciones,
    DuracionTotal >= DuracionTotalMinima.

cumpleLosRequisitos(Vocaloid, mediano(DuracionTotalMaxima)) :-
    findall(Duracion, canta(Vocaloid, cancion(_, Duracion)), ListaDuraciones),
    sumlist(ListaDuraciones, DuracionTotal),
    DuracionTotal =< DuracionTotalMaxima.

cumpleLosRequisitos(Vocaloid, pequenio(DuracionMinima)) :-
    canta(Vocaloid, cancion(_, Duracion)),
    Duracion >= DuracionMinima.


%%%%%%%%%%%%%%%%%
%%%Ejercicio 3%%%
%%%%%%%%%%%%%%%%%

famaTotal(Vocaloid, FamaTotal) :-
    vocaloid(Vocaloid),
    findall(Fama, famaPorConcierto(Vocaloid, Fama), FamaPorConcierto),
    sumlist(FamaPorConcierto, FamaTotal).

famaPorConcierto(Vocaloid, Fama) :-
    puedeParticipar(Vocaloid, Concierto),
    concierto(Concierto, _, Fama, _).

elMasFamoso(Vocaloid) :-
    famaTotal(Vocaloid, Fama),
    forall(famaTotal(_, OtraFama), OtraFama =< Fama).

%%%%%%%%%%%%%%%%%
%%%Ejercicio 4%%%
%%%%%%%%%%%%%%%%%

%conoce(UnVocaloid, OtroVocaloid)
conoce(megurineLuka, hatsuneMiku).
conoce(megurineLuka, gumi).
conoce(gumi, seeU).
conoce(seeU, kaito).

%esConocido(UnVocaloid, OtroVocaloid)
esConocido(UnVocaloid, OtroVocaloid) :-
    conoce(UnVocaloid, OtroVocaloid).

esConocido(UnVocaloid, OtroVocaloid) :-
    conoce(UnVocaloid, TercerVocaloid),
    esConocido(TercerVocaloid, OtroVocaloid).

esElUnico(Vocaloid, Concierto) :-
    puedeParticipar(Vocaloid, Concierto),
    esConocido(Vocaloid, OtroVocaloid),
    not(puedeParticipar(OtroVocaloid, Concierto)).

%%%%%%%%%%%%%%%%%
%%%Ejercicio 5%%%
%%%%%%%%%%%%%%%%%

%Nos lo permite el polimorfismo, habria que agregarlo en conciertos con el nuevo funtor correspondiente y su informacion y agregar su relacion "cumpleRequisitos/2"
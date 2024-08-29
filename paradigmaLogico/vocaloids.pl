%vocaloid(Nombre, cancion(Nombre, Duracion)).

vocaloid(megurineLuka, cancion(nightFever, 4)).
vocaloid(megurineLuka, cancion(foreverYoung, 5)).
vocaloid(hatsuneMiku, cancion(tellYourWorld, 4)).
vocaloid(gumi, cancion(foreverYoung, 4)).
vocaloid(gumi, cancion(tellYourWorld, 5)).
vocaloid(seeU, cancion(novemberRain, 6)).
vocaloid(seeU, cancion(nightFever, 5)).

novedoso(Cantante) :- 
    vocaloid(Cantante, _),
    tieneMasDeDosCanciones(Cantante),
    duracionTotalMayorA(Cantante, 15).

tieneMasDeDosCanciones(Cantante) :-
    vocaloid(Cantante, cancion(UnaCancion, _)),
    vocaloid(Cantante, cancion(OtraCancion, _)),
    UnaCancion \= OtraCancion.

duracionTotalMayorA(Cantante, DuracionTotalMinima) :-
    findall(Duracion, duracionCancion(Cantante, Duracion), DuracionCanciones),
    sumlist(DuracionCanciones, DuracionTotal),
    DuracionTotal >= DuracionTotalMinima.

duracionCancion(Cantante, Duracion) :-
    vocaloid(Cantante, Cancion).
    duracion(Cancion, Duracion).

duracion(cancion(_, Duracion), Duracion). 

acelerado(Cantante) :- 
    vocaloid(Cantante, Cancion),
    not(duraMasDe4Minutos(Cancion)).

duraMasDe4Minutos(cancion(_, Duracion)) :-
    Duracion > 4.

%concierto(Nombre, Pais, CantidadDeFama, TipoDeConcierto).
%gigante(cantidadMinimaDeCanciones, DuracionTotalMinima).
%mediano(DuracionTotalMaxima).
%pequenio(DuracionMinimaDeAlgunaCancion).

concierto(mikuExpo, estadosUnidos, 2000, gigante(2, 6)).
concierto(magicalMirai, japon, 3000, gigante(3, 10)).
concierto(vocalecktVisons, estadosUnidos, 1000, mediano(9)).
concierto(mikuFest, argentina, 100, pequenio(4)).

puedeParticipar(_, hatsuneMiku).

puedeParticipar(Concierto, Cantante) :-
    vocaloid(Cantante, _),
    concierto(Concierto, _, _, Requisitos),
    cumpleRequisitos(Cantante, Requisitos).

cumpleRequisitos(Cantante, gigante(CantidadMinimaDeCanciones, DuracionTotalMinima)) :-
    findall(Cancion, vocaloid(Cantante, Cancion), Canciones),
    length(Canciones, Cantidad),
    Cantidad >= CantidadMinimaDeCanciones,
    duracionTotalMayorA(Cantante, DuracionTotalMinima).

cumpleRequisitos(Cantante, mediano(DuracionTotalMaxima)) :-
    not(duracionTotalMayorA(Cantante, DuracionTotalMaxima)).

cumpleRequisitos(Cantante, pequenio(DuracionMinimaDeAlgunaCancion)) :-
    vocaloid(Cantante, Cancion),
    duracionCancion(Cantante, Duracion),
    Duracion > DuracionMinimaDeAlgunaCancion.

fama(Cantante, FamaTotal) :-
    vocaloid(Cantante, _),
    findall(Fama, famaTotal(Cantante, Fama), ListaDeFamaOtorgada),
    sumList(ListaDeFamaOtorgada, FamaPorConciertos),
    forall(vocaloid(Cantante, _), FamaTotal is FamaTotal + FamaPorConciertos).

famaTotal(Cantante, Fama) :-
    puedeParticipar(Cantante, Concierto),
    concierto(Concierto, _, Fama, _).

esElMasFamoso(Cantante) :-
    vocaloid(Cantante, _).
    forall(vocaloid(OtroCantante, _), tieneMasFamaQue(Cantante, OtroCantante)).

tieneMasFamaQue(Cantante, OtroCantante) :-
    fama(Cantante, FamaUno),
    fama(OtroCantante, FamaDos),
    FamaUno > FamaDos.

conoce(megurineLuka, hatsuneMiku).
conoce(megurineLuka, gumi).
conoce(gumi, seeU).

esElUnicoParticipante(Concierto, Cantante) :-
    vocaloid(Cantante, _),
    not(conoceAOtroParticipante(Concierto, Cantante)).

conoceAOtroParticipante(Concierto, Cantante) :-
    conocido(Cantante, Conocido),
    puedeParticipar(Concierto, Conocido).

conocido(Cantante, Conocido) :-
    conoce(Cantante, Conocido).

conocido(Cantante, Conocido) :-
    conoce(Cantante, Conocido),
    conocido(Conocido, OtroConocido).

%Solo tendria que agregar un predicado cumpleRequisitos(Cantante, Requisitos) para ese nuevo tipo de concierto, los conceptos que facilitaron esto fueron los functores y el
%polimorfismo
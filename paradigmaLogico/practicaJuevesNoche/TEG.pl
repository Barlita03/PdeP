%jugador(Jugador)

%ubicadoEn(Pais, Continente)

%aliados(UnJugador, OtroJugador)

%ocupa(Jugador, País)

%limítrofes(UnPaís, OtroPaís)

%Punto1
tienePresenciaEn(Jugador, Continente) :-
    ocupa(Jugador, Pais),
    ubicadoEn(Pais, Continente).

%Punto2
puedenAtacarse(UnJugador, OtroJugador) :-
    ocupa(UnJugador, UnPais),
    ocupa(OtroJugador, OtroPais),
    limitrofes(UnPais, OtroPais).

%Punto3
sinTensiones(UnJugador, OtroJugador) :-
    aliados(UnJugador, OtroJugador).

sinTensiones(UnJugador, OtroJugador) :-
    jugador(UnJugador),
    jugador(OtroJugador),
    not(puedenAtacarse(UnJugador, OtroJugador)).

%Punto4
perdio(Jugador) :-
    jugador(Jugador),
    not(ocupa(Jugador, _)).

%Punto5
controla(Jugador, Continente) :-
    jugador(Jugador),
    ubicadoEn(_, Continente),
    forall(ubicadoEn(Pais, Continente), ocupa(Jugador, Pais)).

%Punto6
renido(Continente) :-
    ubicadoEn(_, Continente),
    forall(jugador(Jugador), tienePresenciaEn(Jugador, Continente)).

%Punto7
atrincherado(Jugador) :-
    jugador(Jugador),
    not(tienePresenciaEnMasDeUnContinente(Jugador)).

tienePresenciaEnMasDeUnContinente(Jugador) :-
    tienePresenciaEn(Jugador, UnContinente),
    tienePresenciaEn(Jugador, OtroContinente),
    UnContinente \= OtroContinente.

atrincherado2(Jugador) :-
    tienePresenciaEn(Jugador, Continente),
    forall(ocupa(Jugador, Pais), ubicadoEn(Pais, Continente)).

%Punto8
puedeConquistar(Jugador, Continente) :-
    jugador(Jugador),
    ubicadoEn(_, Continente),
    not(controla(Jugador, Continente)),
    forall(leFaltaPais(Jugador, Continente, Pais), esLimitrofeYMePuedoDesconocer(Jugador, Pais)).

leFaltaPais(Jugador, Continente, Pais) :-
    ubicadoEn(Pais, Continente),
    not(ocupa(Jugador, Pais)).

esLimitrofeYMePuedoDesconocer(UnJugador, UnPais) :-
    ocupa(OtroJugador, UnPais),
    not(aliados(UnJugador, OtroJugador)),
    ocupa(UnJugador, OtroPais),
    limitrofes(UnPais, OtroPais).
    
paisContinente(americaDelSur, argentina).
paisContinente(americaDelSur, bolivia).
paisContinente(americaDelSur, brasil).
paisContinente(americaDelSur, chile).
paisContinente(americaDelSur, ecuador).
paisContinente(europa, alemania).
paisContinente(europa, espania).
paisContinente(europa, francia).
paisContinente(europa, inglaterra).
paisContinente(asia, aral).
paisContinente(asia, china).
paisContinente(asia, india).
paisContinente(asia, afganistan).
paisContinente(asia, nepal).

paisImportante(argentina).
paisImportante(alemania).

limitrofes(argentina, brasil).
limitrofes(bolivia, brasil).
limitrofes(bolivia, argentina).
limitrofes(argentina, chile).
limitrofes(espania, francia).
limitrofes(alemania, francia).
limitrofes(nepal, india).
limitrofes(china, india).
limitrofes(nepal, china).
limitrofes(afganistan, china).

ocupa(argentina, azul).
ocupa(bolivia, rojo).
ocupa(brasil, verde).
ocupa(chile, negro).
ocupa(ecuador, rojo).
ocupa(alemania, azul).
ocupa(espania, azul).
ocupa(francia, azul).
ocupa(inglaterra, azul).
ocupa(aral, verde).
ocupa(china, negro).
ocupa(india, verde).
ocupa(afganistan, verde).

continente(americaDelSur).
continente(europa).
continente(asia).

%%%%%%%%%%EJERCICIO1%%%%%%%%%%

%estaEnContinente/2 (Jugador, Continente) | relaciona un jugador y un continente si el jugador ocupa al menos un país en el continente.
estaEnContinente(Jugador, Continente) :-
    paisContinente(Continente, Pais),
    ocupa(Pais, Jugador).

%ocupaElContinente/2 (Jugador, Continente) | relaciona un jugador y un continente si el jugador ocupa totalmente el continente.
ocupaElContinente(Jugador, Continente) :-
    estaEnContinente(Jugador, Continente),
    forall(paisContinente(Continente, Pais), ocupa(Pais, Jugador)).

%cubaLibre/1 (Pais) | es verdadero para un país si nadie lo ocupa.
cubaLibre(Pais) :-
    paisContinente(_, Pais),
    not(ocupa(Pais, _)).

%jugador/1 (Jugador) | Una persona es jugador si ocupa algun pais
jugador(Jugador) :-
    ocupa(_, Jugador).

%leFaltaMucho/2 (Jugador, Continente) | relaciona a un jugador si está en un continente pero le falta ocupar otros 2 países o más.
leFaltaMucho(Jugador, Continente) :-
    estaEnContinente(Jugador, Continente),
    forall(paisContinente(Continente, Pais), not(ocupa(Pais, Jugador))),
    forall(paisContinente(Continente, OtroPais), not(ocupa(OtroPais, Jugador))),
    Pais \= OtroPais.

%sonLimitrofes/2 (UnPais, OtroPais) | relaciona dos países si son limítrofes considerando que si A es limítrofe de B, entonces B también es limítrofe de A.
sonLimitrofes(UnPais, OtroPais) :-
    limitrofes(UnPais, OtroPais).

sonLimitrofes(UnPais, OtroPais) :-
    limitrofes(OtroPais, UnPais).

%tipoImportante/1 (Jugador) | un jugador es importante si ocupa todos los países importantes.
tipoImportante(Jugador) :-
    jugador(Jugador),
    forall(paisImportante(Pais), ocupa(Pais, Jugador)).

%estaEnElHorno/1 (Pais) | un país está en el horno si todos sus países limítrofes están ocupados por el mismo jugador que no es el mismo que ocupa ese país.
estaEnElHorno(Pais) :-
    ocupa(Pais, Jugador),
    jugador(OtroJugador),
    forall(sonLimitrofes(Pais, PaisLimitrofe), ocupa(PaisLimitrofe, OtroJugador)),
    Jugador \= OtroJugador.

%esCompartido/1 (Continente) | un continente es compartido si hay dos o más jugadores en él.
esCompartido(Continente) :-
    estaEnContinente(Jugador, Continente),
    estaEnContinente(OtroJugador, Continente),
    Jugador \= OtroJugador.
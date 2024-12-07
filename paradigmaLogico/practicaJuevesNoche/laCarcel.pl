%%%%%%%%%%%%%%%%%
%%%BASE ARMADA%%%
%%%%%%%%%%%%%%%%%

% guardia(Nombre)
guardia(bennett).
guardia(mendez).
guardia(george).

% prisionero(Nombre, Crimen)
prisionero(piper, narcotráfico([metanfetaminas])).
prisionero(alex, narcotráfico([heroína])).
prisionero(alex, homicidio(george)).
prisionero(red, homicidio(rusoMafioso)).
prisionero(suzanne, robo(450000)).
prisionero(suzanne, robo(250000)).
prisionero(suzanne, robo(2500)).
prisionero(dayanara, narcotráfico([heroína, opio])).
prisionero(dayanara, narcotráfico([metanfetaminas])).

%%%%%%%%%%%%%%%%%
%%%Ejercicio 1%%%
%%%%%%%%%%%%%%%%%

% controla(Controlador, Controlado)
controla(piper, alex).
controla(bennett, dayanara).

controla(Guardia, Otro):- prisionero(Otro,_), not(controla(Otro, Guardia)).

%! Es inversible para "Otro" pero no para "Guardia"

%%%%%%%%%%%%%%%%%
%%%Ejercicio 2%%%
%%%%%%%%%%%%%%%%%

conflictoDeIntereses(UnaPersona, OtraPersona) :-
    controla(UnaPersona, UnTercero),
    controla(OtraPersona, UnTercero),
    not(controla(UnaPersona, OtraPersona)),
    not(controla(OtraPersona, UnaPersona)).

%%%%%%%%%%%%%%%%%
%%%Ejercicio 3%%%
%%%%%%%%%%%%%%%%%

peligroso(Prisionero) :-
    prisionero(Prisionero, _),
    forall(prisionero(Prisionero, Crimen), esGrave(Crimen)).

esGrave(homicidio(_)).

esGrave(narcotráfico(Drogas)) :-
    member(metanfetaminas, Drogas).

esGrave(narcotráfico(Drogas)) :-
    length(Drogas, Cantidad),
    Cantidad >= 5.

%%%%%%%%%%%%%%%%%
%%%Ejercicio 4%%%
%%%%%%%%%%%%%%%%%

ladronDeGuanteBlanco(Prisionero) :-
    prisionero(Prisionero, _),
    forall(prisionero(Prisionero, Crimen), esUnGranRobo(Crimen)).

esUnGranRobo(robo(Cantidad)) :-
    Cantidad >= 100000.

%%%%%%%%%%%%%%%%%
%%%Ejercicio 5%%%
%%%%%%%%%%%%%%%%%

cantidadDeAnios(robo(Cuanto), Anios) :-
    Anios is Cuanto / 10.

cantidadDeAnios(homicidio(_), 7).

cantidadDeAnios(homicidio(Persona), 2) :-
    guardia(Persona).

cantidadDeAnios(narcotráfico(Drogas), Anios) :-
    length(Drogas, Cantidad),
    Anios is Cantidad * 2.

condena(Prisionero, Condena) :-
    prisionero(Prisionero, _),
    forEach(Anios, ( prisionero(Prisionero, Crimen), cantidadDeAnios(Crimen, Anios) ), CantidadDeAnios),
    sumlist(CantidadDeAnios, Condena).

%%%%%%%%%%%%%%%%%
%%%Ejercicio 6%%%
%%%%%%%%%%%%%%%%%

persona(Persona) :-
    guardia(Persona).

persona(Persona) :-
    prisionero(Persona, _).

capoDiTutiLiCapi(Prisionero) :-
    prisionero(Prisionero, _),
    not(controla(_, Prisionero)),
    forall(persona(Persona), estaBajoSuControl(Prisionero, Persona)).

estaBajoSuControl(Prisionero, Presona) :-
    controla(Prisionero, Persona).

estaBajoSuControl(Prisionero, Presona) :-
    controla(Prisionero, OtraPersona),
    estaBajoSuControl(OtraPersona, Persona).
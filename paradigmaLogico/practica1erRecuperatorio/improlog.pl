%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Base de conocimiento%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%

%integrante(Grupo, Nombre, Instrumento)
integrante(sophieTrio, sophie, violin).
integrante(sophieTrio, santi, guitarra).
integrante(vientosDelEste, lisa, saxo).
integrante(vientosDelEste, santi, voz).
integrante(vientosDelEste, santi,  guitarra).
integrante(jazzmin, santi, bateria).

%nivelQueTiene(Nombre, Instrumento, Nivel)
nivelQueTiene(sophie, violin, 5).
nivelQueTiene(santi, guitarra, 2).
nivelQueTiene(santi, voz, 3).
nivelQueTiene(santi, bateria, 4).
nivelQueTiene(lisa, saxo, 4).
nivelQueTiene(lore, violin, 4).
nivelQueTiene(luis, trompeta, 1).
nivelQueTiene(luis, contrabajo, 4).

%instrumento(Instrumento, Tipo)
instrumento(violin, melodico(cuerdas)).
instrumento(guitarra, armonico).
instrumento(bateria, ritmico).
instrumento(saxo, melodico(viento)).
instrumento(trompeta, melodico(viento)).
instrumento(contrabajo, armonico).
instrumento(bajo, armonico).
instrumento(piano, armonico).
instrumento(pandereta, ritmico).
instrumento(voz, melodico(vocal)).

%%%%%%%%%%%%%%%%%
%%%Ejercicio 1%%%
%%%%%%%%%%%%%%%%%

tieneBuenaBase(Grupo) :-
    integrante(Grupo, UnIntegrante, UnInstrumento),
    integrante(Grupo, OtroIntegrante, OtroInstrumento),
    instrumento(UnInstrumento, ritmico),
    instrumento(OtroInstrumento, armonico),
    UnIntegrante \= OtroIntegrante.

%%%%%%%%%%%%%%%%%
%%%Ejercicio 2%%%
%%%%%%%%%%%%%%%%%

seDestaca(Persona, Grupo) :-
    integrante(Grupo, Persona, Instrumento),
    nivelQueTiene(Persona, Instrumento, Nivel),
    forall( ( integrante(Grupo, Integrante, OtroInstrumento), Integrante \= Persona ), tocaDosNivelesMasAbajo(Nivel, Integrante, OtroInstrumento) ).

tocaDosNivelesMasAbajo(Nivel, Persona, Instrumento) :-
    NivelDeComparacion is Nivel - 2,
    nivelQueTiene(Persona, Instrumento, OtroNivel),
    OtroNivel =< NivelDeComparacion.

%!SE PODRIA HABER MEJORADO DE LA SIGUIENTE FORMA

%! seDestaca(PersonaDestacada, Grupo):-
%!     nivelConElQueToca(PersonaDestacada, Grupo, Nivel),
%!     forall((nivelConElQueToca(OtraPersona, Grupo, NivelMenor), OtraPersona \= Persona),
%!             Nivel >= NivelMenor + 2).

%! nivelConElQueToca(Persona, Grupo, Nivel):-
%!     integrante(Grupo, Persona, Instrumento),
%!     nivelQueTiene(Persona, Instrumento, Nivel).

%%%%%%%%%%%%%%%%%
%%%Ejercicio 3%%%
%%%%%%%%%%%%%%%%%

%grupo(Nombre, Tipo)
grupo(vientosDelEste, bigBand).
grupo(sophieTrio, formacionParticular([ contrabajo, violin, guitarra ])).
grupo(jazzmin, formacionParticular([ bateria, bajo, trompeta, piano, guitarra ])).
grupo(fedeYSusAyudantes, ensamble(5)).

%%%%%%%%%%%%%%%%%
%%%Ejercicio 4%%%
%%%%%%%%%%%%%%%%%

%hayCupo(Grupo, Instrumento)
hayCupo(Grupo, Instrumento) :-
    grupo(Grupo, bigBand),
    instrumento(Instrumento, melodico(viento)).

hayCupo(Grupo, _) :-
    grupo(Grupo, ensamble(_)).

hayCupo(Grupo, Instrumento) :-
    grupo(Grupo, _),
    sirve(Instrumento, Grupo),
    noHayNadieQueLoToque(Instrumento, Grupo).

noHayNadieQueLoToque(Instrumento, Grupo) :-
    not(integrante(Grupo, _, Instrumento)).

sirve(bateria, Grupo) :-
    grupo(Grupo, bigBand).

sirve(bajo, Grupo) :-
    grupo(Grupo, bigBand).

sirve(piano, Grupo) :-
    grupo(Grupo, bigBand).

sirve(Instrumento, Grupo) :-
    grupo(Grupo, formacionParticular(Instrumentos)),
    member(Instrumento, Instrumentos).

%%%%%%%%%%%%%%%%%
%%%Ejercicio 5%%%
%%%%%%%%%%%%%%%%%

puedeIncorporarse(Persona, Instrumento, Grupo) :-
    hayCupo(Grupo, Instrumento),
    nivelQueTiene(Persona, Instrumento, Nivel),
    not(integrante(Grupo, Persona, _)),
    esNivelSuficiente(Nivel, Grupo).

esNivelSuficiente(Nivel, Grupo) :-
    grupo(Grupo, bigBand),
    Nivel >= 1.

esNivelSuficiente(Nivel, Grupo) :-
    grupo(Grupo, formacionParticular(Instrumentos)),
    length(Instrumentos, CantidadDeInstrumentos),
    NivelBuscado is 7 - CantidadDeInstrumentos,
    Nivel >= NivelBuscado.

esNivelSuficiente(Nivel, Grupo) :-
    grupo(Grupo, ensamble(NivelNecesario)),
    Nivel >= NivelNecesario.

%%%%%%%%%%%%%%%%%
%%%Ejercicio 6%%%
%%%%%%%%%%%%%%%%%

seQuedaEnBanda(Persona) :-
    nivelQueTiene(Persona, _, _),
    not(integrante(_, Persona, _)),
    not(puedeIncorporarse(_, _, Persona)).

%%%%%%%%%%%%%%%%%
%%%Ejercicio 7%%%
%%%%%%%%%%%%%%%%%

puedeTocar(Grupo) :-
    grupo(Grupo, bigBand),
    tieneBuenaBase(Grupo),
    tienePorLoMenos5InstrumentosDeViento(Grupo).

puedeTocar(Grupo) :-
    grupo(Grupo, formacionParticular(Instrumentos)),
    todosLosPuestosEstanCubiertos(Grupo, Instrumentos).

puedeTocar(Grupo) :-
    grupo(Grupo, ensamble(_)),
    tieneBuenaBase(Grupo),
    alMenosUnoTocaUnInstrumentoMelodico(Grupo).

tienePorLoMenos5InstrumentosDeViento(Grupo) :-
    findall(Instrumento, (integrante(Grupo, _, Instrumento), instrumento(Instrumento, melodico(viento))), InstrumentosDeViento),
    length(InstrumentosDeViento, CantidadDeInstrumentosDeViento),
    CantidadDeInstrumentosDeViento >= 5.

todosLosPuestosEstanCubiertos(Grupo, Instrumentos) :-
    forall(member(Instrumento, Instrumentos), integrante(Grupo, _, Instrumento)).

alMenosUnoTocaUnInstrumentoMelodico(Grupo) :-
    integrante(Grupo, _, Instrumento),
    instrumento(Instrumento, melodico(_)).

%%%%%%%%%%%%%%%%%
%%%Ejercicio 8%%%
%%%%%%%%%%%%%%%%%

%! Esta resuelto a lo largo de todo el parcial
persona(sophie).
persona(santi).
persona(lisa).
persona(barla).

integrante(sophieTrio, sophie, violin).
integrante(sophieTrio, barla, contrabajo).
integrante(sophieTrio, santi, guitarra).
integrante(vientosDelEste, lisa, saxo).
integrante(vientosDelEste, santi, voz).
integrante(vientosDelEste, santi, guitarra).
integrante(vientosDelEste, barla, trompeta).
integrante(vientosDelEste, barla, bateria).
integrante(jazzmin, santi, bateria).
%integrante(jazzmin, barla, guitarra).

nivelQueTiene(barla, bateria, 4).
nivelQueTiene(sophie, violin, 5).
nivelQueTiene(santi, guitarra, 2).
nivelQueTiene(santi, voz, 3).
nivelQueTiene(santi, bateria, 4).
nivelQueTiene(lisa, saxo, 4).
nivelQueTiene(lore, violin, 4).
nivelQueTiene(luis, trompeta, 1).
nivelQueTiene(luis, contrabajo, 4).

instrumento(bateria, ritmico).
instrumento(pandereta, ritmico).
instrumento(bajo, armonico).
instrumento(piano, armonico).
instrumento(guitarra, armonico).
instrumento(contrabajo, armonico).
instrumento(voz, melodico(vocal)).
instrumento(saxo, melodico(viento)).
instrumento(violin, melodico(cuerdas)).
instrumento(trompeta, melodico(viento)).

instrumento(Instrumento) :-
    instrumento(Instrumento, _).

%%%%%%%%%%%%%%%%%
%%%%%PUNTO 1%%%%%
%%%%%%%%%%%%%%%%%

tieneBuenaBase(Grupo) :-
    grupo(Grupo),
    integrante(Grupo, Integrante, Instrumento),
    integrante(Grupo, OtroIntegrante, OtroInstrumento),
    Integrante \= OtroIntegrante,
    esRitmico(Instrumento),
    esArmonico(OtroInstrumento).

esRitmico(Instrumento) :-
    instrumento(Instrumento, ritmico).

esArmonico(Instrumento) :-
    instrumento(Instrumento, armonico).

%%%%%%%%%%%%%%%%%
%%%%%PUNTO 2%%%%%
%%%%%%%%%%%%%%%%%

%Asumi como que tiene que ser SU propio grupo
seDestaca(Persona, Grupo) :-
    grupo(Grupo),
    persona(Persona),
    integrante(Grupo, Persona, Instrumento),
    forall(integrante(Grupo, OtraPersona, OtroInstrumento), supera(Persona, Instrumento, OtraPersona, OtroInstrumento, Grupo)).

supera(PersonaUno, InstrumentoUno, PersonaDos, InstrumentoDos, Grupo) :-
    puntos(PersonaUno, InstrumentoUno, PuntosUno, Grupo),
    puntos(PersonaDos, InstrumentoDos, PuntosDos, Grupo),
    Comparativa is PuntosDos + 2,
    PuntosUno >= Comparativa.

supera(Persona, _, Persona, _, _).

puntos(Persona, Instrumento, Puntos, Grupo) :-
    integrante(Grupo, Persona, Instrumento),
    nivelQueTiene(Persona, Instrumento, Puntos).

%%%%%%%%%%%%%%%%%
%%%%%PUNTO 3%%%%%
%%%%%%%%%%%%%%%%%

grupo(vientosDelEste, bigBand).
grupo(sophieTrio, formacionParticular([contrabajo, guitarra, violin])).
grupo(jazzmin, formacionParticular([bateria, guitarra, bajo, trompeta, piano])).
grupo(estudio1, ensamble(3)).

grupo(Grupo) :-
    grupo(Grupo, _).

%%%%%%%%%%%%%%%%%
%%%%%PUNTO 4%%%%%
%%%%%%%%%%%%%%%%%

hayCupo(Grupo, Instrumento) :-
    grupo(Grupo, Tipo),
    instrumento(Instrumento),
    sirve(Tipo, Instrumento),
    nadieLoToca(Grupo, Instrumento).

nadieLoToca(Grupo, Instrumento) :-
    not(integrante(Grupo, _, Instrumento)).

sirve(bigBand, Instrumento) :-
    instrumento(Instrumento, melodico(viento)).

sirve(bigBand, bateria).
sirve(bigBand, piano).
sirve(bigBand, bajo).

sirve(formacionParticular(Instrumentos), Instrumento) :-
    member(Instrumento, Instrumentos).

sirve(ensamble(_), _).

%%%%%%%%%%%%%%%%%
%%%%%PUNTO 5%%%%%
%%%%%%%%%%%%%%%%%

puedeIncorporarse(Persona, Instrumento, Grupo) :-
    grupo(Grupo),
    persona(Persona),
    instrumento(Instrumento),
    not(integrante(Grupo, Persona, _)),
    hayCupo(Grupo, Instrumento),
    grupo(Grupo, Tipo),
    leDaElNivel(Persona, Instrumento, Tipo).

leDaElNivel(Persona, Instrumento, bigBand) :-
    nivelQueTiene(Persona, Instrumento, Puntos),
    Puntos >= 1.

leDaElNivel(Persona, Instrumento, formacionParticular(Instrumentos)) :-
    nivelQueTiene(Persona, Instrumento, Puntos),
    length(Instrumentos, Cantidad),
    Comparativa is 7 - Cantidad,
    Puntos >= Comparativa.

leDaElNivel(Persona, Instrumento, ensamble(Nivel)) :-
    nivelQueTiene(Persona, Instrumento, Puntos),
    Puntos >= Nivel.

%%%%%%%%%%%%%%%%%
%%%%%PUNTO 6%%%%%
%%%%%%%%%%%%%%%%%

seQuedoEnBanda(Persona) :-
    persona(Persona),
    not(tieneGrupo(Persona)),
    not(puedeIncorporarse(Persona, _, _)).

tieneGrupo(Persona) :-
    integrante(_, Persona, _).

%%%%%%%%%%%%%%%%%
%%%%%PUNTO 7%%%%%
%%%%%%%%%%%%%%%%%

puedeTocar(Grupo) :-
    grupo(Grupo, Tipo),
    cumpleConNecesidades(Grupo, Tipo).

cumpleConNecesidades(Grupo, bigBand) :-
    tieneBuenaBase(Grupo),
    findall(Instrumento, instrumentosDeViento(Grupo, Instrumento), ListaInstrumentos),
    length(ListaInstrumentos, Cantidad),
    Cantidad >= 2.

cumpleConNecesidades(Grupo, formacionParticular(Instrumentos)) :-
    forall(member(Instrumento, Instrumentos), integrante(Grupo, _, Instrumento)).

cumpleConNecesidades(Grupo, ensamble(_)) :-
    tieneBuenaBase(Grupo),
    integrante(Grupo, _, Instrumento),
    instrumento(Instrumento, melodico(_)).

instrumentosDeViento(Grupo, Instrumento) :-
    integrante(Grupo, _, Instrumento),
    instrumento(Instrumento, melodico(viento)).

%%%%%%%%%%%%%%%%%
%%%%%PUNTO 8%%%%%
%%%%%%%%%%%%%%%%%

%agrego cada predicado en su respectivo lugar para que el compilador no rompa las bolas
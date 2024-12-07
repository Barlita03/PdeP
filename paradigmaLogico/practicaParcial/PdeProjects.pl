%%%%%%%%%%%%%%%%
%%%%%PARTE1%%%%%
%%%%%%%%%%%%%%%%

%miembro(nombre, rol).
miembro(emi, devOps).
miembro(gus, administrador).
miembro(manu, administrador).
miembro(lucas, desarrollador(junior)).
miembro(juani, desarrollador(senior)).
miembro(tomi, desarrollador(semiSenior)).
miembro(dante, desarrollador(semiSenior)).

miembro(Nombre) :-
    miembro(Nombre, _).

%tarea(nombre, estado, tipo).
tarea("Como alumno quiero programar en Haskell con los pies", enProgreso, historiaDeUsuario(5)).
tarea("Como docente quiero actualizar a Wollok TS", terminada, historiaDeUsuario(3)).
tarea("ChatGPT se presentó a rendir un parcial", paraHacer, bug).
tarea("Reescribir Linux en Prolog", paraHacer, spike(infraestructura)).
tarea("Parciales", enProgreso, epica).
tarea("Como alumno quiero rendir el parcial de funcional", terminada, historiaDeUsuario(4)).
tarea("Como alumno quiero rendir el parcial de lógico", enProgreso, historiaDeUsuario(3)).
tarea("Como alumno quiero rendir el parcial de objetos", paraHacer, historiaDeUsuario(6)).
tarea("Elegir un dominio para el parcial de objetos", paraHacer, spike(bibliotecas)).
tarea("Estudiar el libro de Gamma", paraHacer, spike(bibliotecas)).
tarea("Como docente quiero cambiar el TP 4 de lógico", enProgreso, historiaDeUsuario(2)).
tarea("Pensar consignas para el desafío del café con leche", enProgreso, spike(bibliotecas)).
tarea("Como docente quiero tener un repositorio para los desafíos", paraHacer, historiaDeUsuario(1)).

asignada("Como alumno quiero programar en Haskell con los pies", lucas).
asignada("Como docente quiero actualizar a Wollok TS", juani).
asignada("Reescribir Linux en Prolog", emi).
asignada("Parciales", gus).
asignada("Como alumno quiero rendir el parcial de funcional", tomi).
asignada("Como alumno quiero rendir el parcial de lógico", lucas).
asignada("Como docente quiero cambiar el TP 4 de lógico", dante).
asignada("Pensar consignas para el desafío del café con leche", juani).
asignada("Como docente quiero tener un repositorio para los desafíos", emi).

tarea(Tarea) :-
    tarea(Tarea, _, _).

%%%%%%%%%%%%%%%%
%%%%%PUNTO A%%%%
%%%%%%%%%%%%%%%%

estaDisponible(Tarea) :-
    tarea(Tarea, paraHacer, _),
    not(asignada(Tarea, _)).

%%%%%%%%%%%%%%%%
%%%%%PUNTO B%%%%
%%%%%%%%%%%%%%%%

dificultad(Tarea, Persona, Dificultad) :- 
    tarea(Tarea, _, historiaDeUsuario(Tiempo)),
    miembro(Persona),
    dificultadHistoriaDeUsuario(Tiempo, Dificultad).

dificultad(Tarea, Persona, Dificultad) :-
    tarea(Tarea, _, bug),
    miembro(Persona),
    dificultadBug(Persona, Dificultad).

dificultad(Tarea, Persona, Dificultad) :- 
    tarea(Tarea, _, spike(Area)),
    miembro(Persona),
    dificultadSpike(Persona, Area, Dificultad).

dificultad(Tarea, _, dificil) :-
    tarea(Tarea, _, epica).

%dificultad historia de usuario
dificultadHistoriaDeUsuario(Tiempo, facil) :-
    between(1, 3, Tiempo).

dificultadHistoriaDeUsuario(Tiempo, normal) :-
    Tiempo = 4.

dificultadHistoriaDeUsuario(Tiempo, dificil) :-
    Tiempo >= 5.

%dificultad bug
dificultadBug(Persona, facil) :-
    esSenior(Persona).

dificultadBug(Persona, dificil) :-
    not(esSenior(Persona)).

esSenior(Persona) :-
    miembro(Persona, desarrollador(senior)).

%dificultad spike
dificultadSpike(Persona, infraestructura, facil) :-
    miembro(Persona, devOps).

dificultadSpike(Persona, bibliotecas, facil) :-
    miembro(Persona, desarrollador(_)).

dificultadSpike(Persona, triggers, facil) :-
    miembro(Persona, administrador).

dificultadSpike(Persona, Area, dificil) :-
    not(dificultadSpike(Persona, Area, facil)).

%%%%%%%%%%%%%%%%
%%%%%PUNTO C%%%%
%%%%%%%%%%%%%%%%

puedeTomarTarea(Tarea, Persona) :-
    miembro(Persona),
    estaDisponible(Tarea),
    not(dificultad(Tarea, Persona, dificil)).

%%%%%%%%%%%%%%%%
%%%%%PARTE2%%%%%
%%%%%%%%%%%%%%%%

squad(hoolingans, [juani, emi, tomi]).
squad(isotopos, [dante, manu]).
squad(cools, [lucas, gus]).

squad(Squad) :-
    squad(Squad, _).

%%%%%%%%%%%%%%%%
%%%%%PUNTO A%%%%
%%%%%%%%%%%%%%%%

puntosSquad(Squad, Puntos) :- 
    squad(Squad, Miembros),
    findall(Horas, horasDeLasHistoriasDeUsuario(Miembros, Horas), ListaHoras),
    sumlist(ListaHoras, Puntos).

horasDeLasHistoriasDeUsuario(Miembros, Puntos) :-
    member(Miembro, Miembros),
    findall(Horas, horasDelMiembro(Miembro, Horas), ListaHoras),
    sumlist(ListaHoras, Puntos).

horasDelMiembro(Miembro, Horas) :-
    asignada(Tarea, Miembro),
    tarea(Tarea, terminada, historiaDeUsuario(Horas)).

%%%%%%%%%%%%%%%%
%%%%%PUNTO B%%%%
%%%%%%%%%%%%%%%%

estaOcupado(Miembro) :-
    asignada(Tarea, Miembro),
    not(tarea(Tarea, terminada, _)).

estaOcupado(Miembro) :-
    puedeTomarTarea(_, Miembro).

todosTienenTrabajo(Squad) :-
    squad(Squad, Miembros),
    forall(member(Miembro, Miembros), estaOcupado(Miembro)).

%%%%%%%%%%%%%%%%
%%%%%PUNTO C%%%%
%%%%%%%%%%%%%%%%

esElMasTrabajador(Squad) :-
    puntosSquad(Squad, Puntaje),
    forall(puntosDeSquadsLaburantes(_, Puntos), Puntaje >= Puntos).

puntosDeSquadsLaburantes(Squad, Puntos) :-
    squad(Squad),
    todosTienenTrabajo(Squad),
    puntosSquad(Squad, Puntos).

%%%%%%%%%%%%%%%%
%%%%%PARTE3%%%%%
%%%%%%%%%%%%%%%%

subtareas("Parciales", "Como alumno quiero rendir el parcial de funcional").
subtareas("Parciales", "Como alumno quiero rendir el parcial de lógico").
subtareas("Parciales", "Como alumno quiero rendir el parcial de objetos").
subtareas("Como alumno quiero rendir el parcial de objetos", "Elegir un dominio para el parcial de objetos").
subtareas("Como alumno quiero rendir el parcial de objetos", "Estudiar el libro de Gamma").
subtareas("Pensar consignas para el desafío del café con leche", "Como docente quiero tener un repositorio para los desafíos").

%%%%%%%%%%%%%%%%
%%%%%PUNTO A%%%%
%%%%%%%%%%%%%%%%

cantidadSubtareas(Tarea, Cantidad) :-
    tarea(Tarea),
    findall(Subtarea, subtarea(Tarea, Subtarea), Subtareas),
    length(Subtareas, Cantidad).

subtarea(Tarea, OtraSubtarea) :-
    subtareas(Tarea, Subtarea),
    subtareas(Subtarea, OtraSubtarea).

subtarea(Tarea, Subtarea) :-
    subtareas(Tarea, Subtarea).

%%%%%%%%%%%%%%%%
%%%%%PUNTO B%%%%
%%%%%%%%%%%%%%%%

malCatalogada(Tarea) :-
    subtareas(Tarea, _),
    not(tarea(Tarea, _, historiaDeUsuario(_))),
    not(tarea(Tarea, _, epica)).

malCatalogada(Tarea) :-
    cantidadSubtareas(Tarea, Cantidad),
    Cantidad >= 5,
    not(tarea(Tarea, _, epica)).
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%PARTE 1%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

%pokemon(nombre, tipo).
pokemon(picachu, electrico).
pokemon(charizard, fuego).
pokemon(venusaur, planta).
pokemon(blastoise, agua).
pokemon(totodile, agua).
pokemon(snorlax, normal).
pokemon(rayquaza, dragon).
pokemon(rayquaza, volador).

%entrenador(nombre, pokemons).
entrenador(ash, [picachu, charizard]).
entrenador(brock, [snorlax]).
entrenador(misty, [balstoise, venusaur, arceus]).

pokemon(Pokemon) :-
    pokemon(Pokemon, _).

%%%%%%%%%%%%%%%%%
%%%%%PUNTO 1%%%%%
%%%%%%%%%%%%%%%%%

tipoMultiple(Pokemon) :-
    pokemon(Pokemon, UnTipo),
    pokemon(Pokemon, OtroTipo),
    UnTipo \= OtroTipo.

%%%%%%%%%%%%%%%%%
%%%%%PUNTO 2%%%%%
%%%%%%%%%%%%%%%%%

esLegendario(Pokemon) :-
    pokemon(Pokemon),
    tipoMultiple(Pokemon),
    not(alguienLoTiene(Pokemon)).

alguienLoTiene(Pokemon) :-
    pokemon(Pokemon),
    entrenador(_, Pokemons),
    member(Pokemon, Pokemons).

%%%%%%%%%%%%%%%%%
%%%%%PUNTO 3%%%%%
%%%%%%%%%%%%%%%%%

esMisterioso(Pokemon) :-
    pokemon(Pokemon),
    not(estaRepe(Pokemon)).

esMisterioso(Pokemon) :-
    pokemon(Pokemon),
    not(alguienLoTiene(Pokemon)).

estaRepe(Pokemon) :-
    pokemon(Pokemon, Tipo),
    pokemon(OtroPokemon, Tipo),
    Pokemon \= OtroPokemon.

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%PARTE 2%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

%fisicos(nombre, potencia).
%especial(nombre, potencia, tipo).
%defensivo(nombre, porcentajeDeReduccion).

%movimiento(pokemon, tipo).
movimiento(picachu, fisico(mordedura, 95)).
movimiento(picachu, especial(impactrueno, 40, electrico)).
movimiento(charizard, especial(garraDragon, 100, dragon)).
movimiento(charizard, fisico(mordedura, 95)).
movimiento(blastoise, defensivo(proteccion, 10)).
movimiento(blastoise, fisico(placaje, 50)).
movimiento(arceus, fisico(placaje, 50)).
movimiento(arceus, defensivo(proteccion, 10)).
movimiento(arceus, especial(impactrueno, 40, electrico)).
movimiento(arceus, especial(garraDragon, 100, dragon)).
movimiento(arceus, defensivo(alivio, 100)).

movimiento(Movimiento) :-
    movimiento(_, fisico(Movimiento, _)).

movimiento(Movimiento) :-
    movimiento(_, defensivo(Movimiento, _)).

movimiento(Movimiento) :-
    movimiento(_, especial(Movimiento, _, _)).

%%%%%%%%%%%%%%%%%
%%%%%PUNTO 1%%%%%
%%%%%%%%%%%%%%%%%

danioDeAtaque(Movimiento, Danio) :-
    movimiento(Movimiento),
    movimiento(_, fisico(Movimiento, Danio)).

danioDeAtaque(Movimiento, 0) :-
    movimiento(Movimiento),
    movimiento(_, defensivo(Movimiento, _)).

danioDeAtaque(Movimiento, Danio) :-
    movimiento(Movimiento),
    movimiento(_, especial(Movimiento, Potencia, TipoDeAtaque)),
    tipo(TipoDeAtaque, Tipo),
    danioSegunTipo(Potencia, Tipo, Danio).

danioDeAtaque(Movimiento, Danio) :-
    movimiento(Movimiento),
    movimiento(_, especial(Movimiento, Danio, TipoDeAtaque)),
    not(tipo(TipoDeAtaque, _)).

%tipo(tipo, tipoDeAtaque)
tipo(agua, basico).
tipo(fuego, basico).
tipo(planta, basico).
tipo(normal, basico).
tipo(dragon, dragon).

danioSegunTipo(Potencia, basico, Danio) :-
    Danio is Potencia * 1.5.

danioSegunTipo(Potencia, dragon, Danio) :-
    Danio is Potencia * 3.

%%%%%%%%%%%%%%%%%
%%%%%PUNTO 2%%%%%
%%%%%%%%%%%%%%%%%

%capacidadOfensiva(Pokemon, Capacidad) :-
capacidadOfensiva(Pokemon, Capacidad) :-
    findall(Danio, danio(Pokemon, Danio), DanioTotal),
    sumlist(DanioTotal, Capacidad).

danio(Pokemon, Danio) :-
    movimiento(Pokemon, Movimiento),
    nombreMovimiento(Movimiento, Nombre),
    danioDeAtaque(Nombre, Danio).

nombreMovimiento(fisico(Nombre, _), Nombre).
nombreMovimiento(defensivo(Nombre, _), Nombre).
nombreMovimiento(especial(Nombre, _, _), Nombre).

%%%%%%%%%%%%%%%%%
%%%%%PUNTO 3%%%%%
%%%%%%%%%%%%%%%%%

esPicante(Entrenador) :-
    entrenador(Entrenador, Pokemons),
    forall(member(Pokemon, Pokemons), pokemonPicante(Pokemon)).

pokemonPicante(Pokemon) :-
    capacidadOfensiva(Pokemon, Capacidad),
    Capacidad > 200.

pokemonPicante(Pokemon) :-
    esMisterioso(Pokemon).
%%%%%%%%%%%%%%%%%
%%%%%PUNTO 1%%%%%
%%%%%%%%%%%%%%%%%

%jockey(nombre, caracteristicas(altura(cm), peso(kg)))
jockey(valdivieso, caracteristicas(155, 52)).
jockey(leguisamo, caracteristicas(161, 49)).
jockey(lezcano, caracteristicas(149, 50)).
jockey(baratucci, caracteristicas(153, 55)).
jockey(falero, caracteristicas(157, 52)).

jockey(Nombre) :-
    jockey(Nombre, _).

%caballo(nombre)
caballo(botafogo).
caballo(oldMan).
caballo(energica).
caballo(yatasto).
caballo(matBoy).

%prefiere(caballo, jockey)
prefiere(Caballo, Jockey) :-
    jockey(Jockey),
    caballo(Caballo),
    quienPrefiere(Caballo, Jockey).

%quienPrefiere(caballo, jockey)
quienPrefiere(botafogo, Jockey) :-
    peso(Jockey, Peso),
    Peso < 52.

quienPrefiere(botafogo, baratucci).

quienPrefiere(oldMan, Jockey) :-
    tamanioNombre(Jockey, Tamanio),
    Tamanio > 7.

quienPrefiere(energica, Jockey) :-
    not(prefiere(botafogo, Jockey)).

quienPrefiere(matBoy, Jockey) :-
    altura(Jockey, Altura),
    Altura > 170.

altura(Jockey, Altura) :-
    jockey(Jockey, caracteristicas(Altura, _)).

peso(Jockey, Peso) :-
    jockey(Jockey, caracteristicas(_, Peso)).

tamanioNombre(Jockey, Tamanio) :-
    atom_length(Jockey, Tamanio).

%no se agrego a Yatasto por el principio de universo cerrado

%stud(stud, integrantes)
stud(elTute, [valdivieso, falero]).
stud(lasHormigas, [lezcano]).
stud(elCharabon, [baratucci, leguisamo]).

stud(Caballeriza) :-
    stud(Caballeriza, _).

%premios(caballo, premios)
premios(botafogo, [granPremioNacional, granPremioRepublica]).
premios(oldMan, [granPremioRepublica, campeonatoPalermoDeOro]).
premios(matBoy, [granPremioCriadores]).

%no se agregaron energica y yatasto por el principio de universo cerrado

%%%%%%%%%%%%%%%%%
%%%%%PUNTO 2%%%%%
%%%%%%%%%%%%%%%%%

prefiereAMasDeUnJockey(Caballo) :-
    prefiere(Caballo, UnJockey),
    prefiere(Caballo, OtroJockey),
    UnJockey \= OtroJockey.

%%%%%%%%%%%%%%%%%
%%%%%PUNTO 3%%%%%
%%%%%%%%%%%%%%%%%

aborrece(Caballo, Caballeriza) :-
    stud(Caballeriza),
    caballo(Caballo),
    not(leGustaAlguno(Caballo, Caballeriza)).

leGustaAlguno(Caballo, Caballeriza) :-
    stud(Caballeriza, Jockeys),
    member(Jockey, Jockeys),
    prefiere(Caballo, Jockey).

%%%%%%%%%%%%%%%%%
%%%%%PUNTO 4%%%%%
%%%%%%%%%%%%%%%%%

piolin(Jockey) :-
    jockey(Jockey),
    forall(ganoPremioImportante(Caballo), prefiere(Caballo, Jockey)).

ganoPremioImportante(Caballo) :-
    caballo(Caballo),
    premios(Caballo, Premios),
    algunoEsImportante(Premios).

algunoEsImportante(Premios) :-
    member(granPremioNacional, Premios).

algunoEsImportante(Premios) :-
    member(granPremioRepublica, Premios).

%%%%%%%%%%%%%%%%%
%%%%%PUNTO 5%%%%%
%%%%%%%%%%%%%%%%%

%ganador(tipoDeApuesta, Resultado).
ganador(aGanadorPorUnCaballo(Caballo), Resultado) :-
    nth0(0, Resultado, Caballo).

ganador(aSegundoPorUnCaballo(Caballo), Resultado) :-
    member(Caballo, Resultado).

ganador(exacta(CaballoUno, CaballoDos), Resultado) :-
    CaballoUno \= CaballoDos,
    nth0(0, Resultado, CaballoUno),
    nth0(1, Resultado, CaballoDos).

ganador(imperfecta(CaballoUno, CaballoDos), Resultado) :-
    CaballoUno \= CaballoDos,
    member(CaballoUno, Resultado),
    member(CaballoDos, Resultado).

%%%%%%%%%%%%%%%%%
%%%%%PUNTO 6%%%%%
%%%%%%%%%%%%%%%%%

color(botafogo, negro).
color(oldMan, marron).
color(energica, gris).
color(energica, negro).
color(matBoy, marron).
color(matBoy, blanco).
color(yatasto, marron).
color(yatasto, blanco).

puedeComprar(Color, Caballos) :-
    findall(Caballo, esDeColor(Caballo, Color), ListaCaballos).

%Me rendi
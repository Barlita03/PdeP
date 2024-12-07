%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Base de conocimiento%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%

% Recorridos en GBA:
recorrido(17, gba(sur), mitre).
recorrido(24, gba(sur), belgrano).
recorrido(247, gba(sur), onsari).
recorrido(60, gba(norte), maipu).
recorrido (152, gba(norte), olivos).

% Recorridos en CABA:
recorrido(17, caba, santaFe).
recorrido(152, caba, santaFe).
recorrido(10, caba, santaFe).
recorrido(160, caba, medrano).
recorrido(24, caba, corrientes).

%%%%%%%%%%%%%%%%%
%%%Ejercicio 1%%%
%%%%%%%%%%%%%%%%%

puedenCombinar(UnaLinea, OtraLinea) :-
    recorrido(UnaLinea, Zona, Calle),
    recorrido(OtraLinea, Zona, Calle),
    UnaLinea \= OtraLinea.

%%%%%%%%%%%%%%%%%
%%%Ejercicio 2%%%
%%%%%%%%%%%%%%%%%

nacional(Linea) :-
    recorrido(Linea, gba(_), _),
    recorrido(Linea, caba, _).

provincial(Linea, buenosAires) :-
    not(nacional(Linea)),
    recorrido(Linea, gba(_), _).

provincial(Linea, caba) :-
    not(nacional(Linea)),
    recorrido(Linea, caba, _).

%%%%%%%%%%%%%%%%%
%%%Ejercicio 3%%%
%%%%%%%%%%%%%%%%%

calleMasTransidata(Calle) :-
    recorrido(_, Zona, Calle),
    forall(recorrido(_, Zona, OtraCalle), esMasRecorridaQue(Calle, OtraCalle)).

cantidadDeLineasQuePasan(Calle, Cantidad) :-
    findall(Linea, recorrido(Linea, _, Calle), LineasQueLaPasan),
    length(LineasQueLaPasan, Cantidad).

esMasRecorridaQue(UnaCalle, OtraCalle) :-
    cantidadDeLineasQuePasan(UnaCalle, UnaCantidad),
    cantidadDeLineasQuePasan(OtraCalle, OtraCantidad),
    UnaCantidad > OtraCantidad.

%%%%%%%%%%%%%%%%%
%%%Ejercicio 4%%%
%%%%%%%%%%%%%%%%%

calleDeTransbordo(Calle) :-
    recorrido(_, _, Calle),
    findall(Linea, ( recorrido(Linea, _, Calle), nacional(Linea) ), LineasNacionalesQueLaRecorren),
    length(LineasNacionalesQueLaRecorren, CantidadDeLineas),
    CantidadDeLineas >= 3.

%%%%%%%%%%%%%%%%%%%%
%%%Ejercicio 5, a%%%
%%%%%%%%%%%%%%%%%%%%

persona(pepito).
persona(juanita).
persona(tito).
persona(marta).

beneficiario(pepito, personalDeCasasParticulares(gba(oeste))).
beneficiario(juanita, estudiantil).
beneficiario(marta, jubilado).
beneficiario(marta, personalDeCasasParticulares(caba)).
beneficiario(marta, personalDeCasasParticulares(gba(sur))).

beneficio(estudiantil, _ , 50).

beneficio(personalDeCasasParticulares(Zona), Linea, 0) :-
    recorrido(Linea, Zona, _).

beneficio(jubilado, Linea, Precio) :-
    boleto(Linea, PrecioBase),
    Precio is PrecioBase / 2.

%%%%%%%%%%%%%%%%%%%%
%%%Ejercicio 5, b%%%
%%%%%%%%%%%%%%%%%%%%

boleto(Linea, 500) :-
    nacional(Linea).

boleto(Linea, 350) :-
    provincial(Linea, caba).

%! EL PLUS PODRIA HABERSE CALCULADO APARTE PARA EVITAR REPETICION DE LOGICA
boleto(Linea, Precio) :-
    provincial(Linea, buenosAires),
    cantidadDeCallesQuePasa(Linea, CantidadDeCallesQueRecorre),
    not(pasaPorZonasDiferentes(Linea)),
    Precio is 25 * CantidadDeCallesQueRecorre

boleto(Linea, Precio) :-
    provincial(Linea, buenosAires),
    cantidadDeCallesQuePasa(Linea, CantidadDeCallesQueRecorre),
    pasaPorZonasDiferentes(Linea),
    Precio is 25 * CantidadDeCallesQueRecorre + 50

pasaPorZonasDiferentes(Linea) :-
    recorrido(Linea, UnaZona, _),
    recorrido(Linea, OtraZona, _),
    UnaZona \= OtraZona.

cantidadDeCallesQuePasa(Linea, Cantidad) :-
    findall(Calle , recorrido(Linea, _, Calle), CallesQueRecorre),
    length(CallesQueRecorre, Cantidad).

precioFinalBoleto(Persona, Linea, PrecioFinal) :-
    persona(Persona),
    not(beneficiario(Persona, _)),
    boleto(Linea, PrecioFinal).

precioFinalBoleto(Persona, Linea, PrecioFinal) :-
    beneficio(Persona, Beneficio),
    precioPorBeneficio(Persona, Linea, PrecioFinal),
    forall(precioPorBeneficio(Persona, Beneficio, Precio), PrecioFinal <= Precio).

precioPorBeneficio(Persona, Linea, Precio) :-
    beneficiario(Persona, Beneficio),
    beneficio(Beneficio, Linea, PrecioFinal).
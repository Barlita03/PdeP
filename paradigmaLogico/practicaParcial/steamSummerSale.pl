%juego(nombre, genero, precio)
juego(juegoDeAccion, accion, 100).
juego(juegoDeRol, rol(1000001), 200).
juego(juegoDePuzzle, puzzle(25, facil), 300).
juego(minecraft, rol(10), 20).
juego(counterStrike, accion, 50).

juego(Juego) :-
    juego(Juego, _, _).

descuento(juegoDeAccion, 50).
descuento(juegoDeRol, 10).

buenDescuento(Juego) :-
    descuento(Juego, Descuento),
    Descuento > 50.

buenDescuento(regalo(Juego, _)) :-
    descuento(Juego, Descuento),
    Descuento > 50.

precio(Juego, PrecioFinal) :-
    juego(Juego, _, Precio),
    descuento(Juego, Descuento),
    PrecioFinal is Precio - Precio * (Descuento / 100).

precio(Juego, Precio) :-
    juego(Juego, _, Precio),
    not(descuento(Juego, _)),
    juego(Juego, _, Precio).

esPopular(Juego) :-
    juego(Juego, accion, _).

esPopular(Juego) :-
    juego(Juego, rol(UsuariosActivos), _),
    UsuariosActivos > 1000000.

esPopular(Juego) :-
    juego(Juego, puzzle(25, _), _).

esPopular(Juego) :-
    juego(Juego, puzzle(_, facil), _).

esPopular(minecraft).

esPopular(counterStrike).

%usuario(nombre, juegosQuePosee, juegosQueDeseaPoseer).
usuario(nicolas, [minecraft, counterStrike], [juegoDeAccion, regalo(juegoDeAccion, juan)]).
usuario(juan, [counterStrike], [regalo(juegoDeRol, nicolas), minecraft]).

usuario(Usuario) :-
    usuario(Usuario, _, _).

adictoALosDescuentos(Usuario) :-
    usuario(Usuario, _, JuegosAAdquirir),
    forall(member(Juego, JuegosAAdquirir), buenDescuento(Juego)).

fanaticoDeUnGenero(Usuario) :-
    usuario(Usuario, Juegos, _),
    member(UnJuego, Juegos),
    member(OtroJuego, Juegos),
    UnJuego \= OtroJuego,
    juego(UnJuego, UnGenero, _),
    juego(OtroJuego, OtroGenero, _),
    mismoGenero(UnGenero, OtroGenero).

mismoGenero(Genero, Genero).

mismoGenero(rol(_), rol(_)).

mismoGenero(puzzle(_, _), puzzle(_, _)).

monotematico(Usuario) :-
    usuario(Usuario, Juegos, _),
    member(Juego, Juegos),
    juego(Juego, Genero, _),
    forall(member(OtroJuego, Juegos), (juego(OtroJuego, OtroGenero, _), mismoGenero(Genero, OtroGenero))).

buenosAmigos(UnUsuario, OtroUsuario) :-
    usuario(UnUsuario, _, JuegosAAdquirirUno),
    usuario(OtroUsuario, _, JuegosAAdquirirDos),
    member(regalo(JuegoUno, OtroUsuario), JuegosAAdquirirUno),
    member(regalo(JuegoDos, UnUsuario), JuegosAAdquirirDos),
    esPopular(JuegoUno),
    esPopular(JuegoDos).

cuantoGastara(Usuario, GastoTotal) :- 
    usuario(Usuario, _, JuegosAAdquirir),
    findall(Precio, (member(Juego, JuegosAAdquirir), costoJuego(Juego, Precio)), Gasto),
    sumlist(Gasto, GastoTotal).

costoJuego(Juego, Precio) :-
    precio(Juego, Precio).

costoJuego(regalo(Juego, _), Precio) :-
    precio(Juego, Precio).
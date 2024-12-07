%juego(Nombre, Precio, accion)
%juego(Nombre, Precio, rol(cantidadDeUsuariosActivos))
%juego(Nombre, Precio, puzzle(cantidadDeNiveles, Dificultad))

%descuento(Juego, Porcentaje)

%?cuantoSale(Juego, Precio)
cuantoSale(Juego, PrecioFinal) :-
    juego(Juego, PrecioFinal, _),
    not(descuento(Juego, _)).

cuantoSale(Juego, PrecioFinal) :-
    juego(Juego, Precio, _),
    descuento(Juego, Descuento),
    PrecioFinal is Precio - Precio * Descuento / 100.


%?tieneBuenDescuento(Juego)
tieneBuenDescuento(Juego) :-
    descuento(Juego, Descuento),
    Descuento >= 50.

%?popular(Juego)
%!Podria haber hecho una abtraccion "segunTipo(Tipo)"
popular(Juego) :-
    juego(Juego, _, accion).
    
popular(Juego) :-
    juego(Juego, _, rol(UsuariosActivos)),
    UsuariosActivos > 1000000.

popular(Juego) :-
    juego(Juego, _, puzzle(_, facil)).

popular(Juego) :-
    juego(Juego, _, puzzle(25, _)).

popular(minecraft).
popular(counterStrike).

%usuario(Nombre)
%posee(Usuario, Juego)
%planeaAdquirir(Usuario, Juego, personal | regalo(Destinatario) )

%?adictoALosDescuentos(Usuario)
adictoALosDescuentos(Usuario) :-
    usuario(Usuario),
    forall(planeaAdquirir(Usuario, Juego, _), tieneBuenDescuento(Juego)).

%?fanatico(Usuario, Genero)
fanatico(Usuario, Genero) :-
    posee(Usuario, UnJuego),
    posee(Usuario, OtroJuego),
    sonDelMismoGenero(UnJuego, OtroJuego, Genero).

sonDelMismoGenero(UnJuego, OtroJuego, Genero) :-
    UnJuego \= OtroJuego,
    genero(UnJuego, Genero),
    genero(OtroJuego, Genero).

genero(Juego, accion) :-
    juego(Juego, _, accion).

genero(Juego, rol) :-
    juego(Juego, _, rol(_)).

genero(Juego, puzzle) :-
    juego(Juego, _, puzzle(_, _)).

%?monotematico(Usuario)
monotematico(Usuario) :-
    posee(Usuario, Juego),
    genero(Juego, Genero),
    forall(posee(Usuario, OtroJuego), genero(OtroJuego, Genero)).

%?buenosAmigos(UnUsuario, OtroUsuario)
%!Me olvide de que el juego tenia que ser popular
buenosAmigos(UnUsuario, OtroUsuario) :-
    piensaRegalarA(UnUsuario, OtroUsuario),
    piensaRegalarA(OtroUsuario, UnUsuario).

piensaRegalarA(UnUsuario, OtroUsuario) :-
    planeaAdquirir(UnUsuario, _, regalo(OtroUsuario)).

%?cuantoGastara(Usuario, Gasto)
cuantoGastara(Usuario, personal, Gasto) :-
    findall(Precio, (planeaAdquirir(Usuario, Juego, personal), precioFinal(Juego, Precio)), ListaDePrecios),
    sumlist(ListaDePrecios, Gasto).

cuantoGastara(Usuario, regalo, Gasto) :-
    findall(Precio, (planeaAdquirir(Usuario, Juego, regalo(_)), precioFinal(Juego, Precio)), ListaDePrecios),
    sumlist(ListaDePrecios, Gasto).

cuantoGastara(Usuario, ambos, Gasto) :-
    findall(Precio, (planeaAdquirir(Usuario, Juego, _), precioFinal(Juego, Precio)), ListaDePrecios),
    sumlist(ListaDePrecios, Gasto).
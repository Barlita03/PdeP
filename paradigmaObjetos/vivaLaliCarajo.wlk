//-----------------------------------------------------------------------------
//FUNCION
//-----------------------------------------------------------------------------

class Funcion {
    var artista
    var fecha
    var lugar
    var property asientos = []

    method agotada() = asientos.all { asiento => asiento.estaOcupado() }
    method asientosDisponibles() = asientos.filter { asiento => !asiento.estaOcupado() }
    method venderEntrada(persona) {
        lugar.asignarAsiento(persona)
    }
}

class Concierto inherits Funcion {}

class Obra inherits Funcion {
    const nombre
    const director
    var horaTelon
}

//-----------------------------------------------------------------------------
//PREDIO
//-----------------------------------------------------------------------------

class Asiento {
    var persona = ""
    const property fila
    const property numero

    method estaOcupado() = persona != ""

    method asignar(otraPersona) {
        persona = otraPersona
    }
}

class Predio {
    const filasPlateaAlta
    const asientosPorFilaPlateaAlta
    const filasPlateaBaja
    const asientosPorFilaPlateaBaja
    const filasPlateaPreferencial
    const asientosPorFilaPlateaPreferencial

    method capacidadPlateaAlta() = filasPlateaAlta * asientosPorFilaPlateaAlta
    method capacidadPlateaBaja() = filasPlateaBaja * asientosPorFilaPlateaBaja
    method capacidadPlateaPreferencial() = filasPlateaPreferencial * asientosPorFilaPlateaPreferencial

    method asignarAsiento(persona) {}
}

class Estadio inherits Predio {
    const property capacidadCampo
}

class Teatro inherits Predio {}

//-----------------------------------------------------------------------------
//OBJETOS
//-----------------------------------------------------------------------------

object monumental inherits Estadio(
    filasPlateaAlta = 5, 
    asientosPorFilaPlateaAlta = 25,
    filasPlateaBaja = 10, 
    asientosPorFilaPlateaBaja = 15,
    filasPlateaPreferencial = 5, 
    asientosPorFilaPlateaPreferencial = 5,
    capacidadCampo = 1000){}

object lunaPark inherits Teatro(
    filasPlateaAlta = 10, 
    asientosPorFilaPlateaAlta = 10,
    filasPlateaBaja = 10, 
    asientosPorFilaPlateaBaja = 10,
    filasPlateaPreferencial = 10, 
    asientosPorFilaPlateaPreferencial = 10){}

object colon inherits Teatro(
    filasPlateaAlta = 5, 
    asientosPorFilaPlateaAlta = 5,
    filasPlateaBaja = 5, 
    asientosPorFilaPlateaBaja = 5,
    filasPlateaPreferencial = 5, 
    asientosPorFilaPlateaPreferencial = 5){}

object theErasTour inherits Concierto(
    artista = "Taylor Swift",
    lugar = monumental,
    fecha = "20/10"){}

object showDePaul inherits Concierto(
    artista = "Paul McCartney",
    lugar = monumental,
    fecha = "5/10"){}

object showDeLali inherits Concierto(
    artista = "Lali Esposito",
    lugar = lunaPark,
    fecha = "13/11"){}

object hamletDeBurzaco inherits Obra(
    artista = "",
    lugar = colon,
    fecha = "3/10",
    nombre = "Hamlet de Burzaco",
    director = "???",
    horaTelon = "20:30"){}

object felicidades612 inherits Obra(
    artista = "",
    lugar = lunaPark,
    fecha = "6/12",
    nombre = "FELICIDADES",
    director = "Adrian Suar",
    horaTelon = ""){}

object felicidades712 inherits Obra(
    artista = "",
    lugar = lunaPark,
    fecha = "7/12",
    nombre = "FELICIDADES",
    director = "Adrian Suar",
    horaTelon = ""){}

object felicidades812 inherits Obra(
    artista = "",
    lugar = lunaPark,
    fecha = "8/12",
    nombre = "FELICIDADES",
    director = "Adrian Suar",
    horaTelon = ""){}
//-----------------------------------------------------------------------------
//FUNCION
//-----------------------------------------------------------------------------

class Funcion {
//    const artista
//    const fecha
    const lugar
    var property asientos = []

    method agotada() = asientos.all { asiento => asiento.estaOcupado() }
    method asientosDisponibles() = asientos.filter { asiento => !asiento.estaOcupado() }
    method venderEntrada(persona) {
        lugar.asignarAsiento(persona)
    }
}

class Concierto inherits Funcion {}

class Obra inherits Funcion {
//    const nombre
//    const director
//    const horaTelon
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
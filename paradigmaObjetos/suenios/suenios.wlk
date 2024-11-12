import personas.*
class Suenio {
    const cantidadDeFelicidonios

    method cantidadDeFelicidonios() = cantidadDeFelicidonios

    method puedeSerCumplidoPor(persona)

    method serCumplidoPor(persona)

    method esAmbisioso() = cantidadDeFelicidonios >= 100
}

class AdoptarXCantidadDeHijos inherits Suenio {
    const cantidadDeHijos
    
    override method puedeSerCumplidoPor(persona) {
        if( persona.tieneHijos() )
            throw new Exception ( message = persona + "no puede adoptar hijos" )
    }

    override method serCumplidoPor(persona) { persona.adoptarHijos(cantidadDeHijos) }
}

class ConseguirLaburoPorXCantidadDePlata inherits Suenio {
    const trabajo
    
    override method puedeSerCumplidoPor(persona) {
        if( persona.salario() < trabajo.salario() )
            throw new Exception ( message = persona + "gana mas que esto" )
    }

    override method serCumplidoPor(persona) { persona.cambiarDeTrabajo(trabajo) }
}

class SuenioMultiple {
    const suenios = #{}

    method cantidadDeFelicidonios() = suenios.sum { suenio => suenio.cantidadDeFelicidonios() }

    method puedeSerCumplidoPor(persona) = suenios.all { suenio => suenio.puedeSerCumplidoPor(Persona) }

    method serCumplidoPor(persona) = suenios.forEach { suenio => suenio.serCumplidoPor(persona) }
}
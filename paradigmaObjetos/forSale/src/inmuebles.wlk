const valorMinimoPH = 500000
const valorPorMetroCuadradoPH = 14000
const valorPorAmbienteDepartamento = 350000
const incrementoLocalALaCalle = 1.5

class Inmueble {
    const metrosCuadrados
    const cantidadDeAmbientes
    const zona
    var reservador = 0

    method zona() = zona

    method valor() = zona.plusDeLaZona()

    method estaReservada() = reservador != 0

    method serReservada(cliente) { 
        if( !self.estaReservada() )
            reservador = cliente
    }

    method puedeOperar(cliente) = cliente == reservador || reservador == 0

    method disponibleParaCompra() = true
}

class Casa inherits Inmueble {
    const valorParticular

    method valorParticular() = valorParticular

    override method valor() = valorParticular * super()
}

class PH inherits Inmueble {
    override method valor() = valorMinimoPH.max( valorPorMetroCuadradoPH * metrosCuadrados ) * super()
}

class Departamento inherits Inmueble {
    override method valor() = valorPorAmbienteDepartamento * cantidadDeAmbientes * super()
}

class Local inherits Casa {
    const tipoDeLocal

    override method disponibleParaCompra() = false

    override method valor() = tipoDeLocal.valor( super() )
}

class Galpon {
    method valor(valorOriginal) = valorOriginal / 2
}

class LocalALaCalle {
    method valor(valorOriginal) = valorOriginal + incrementoLocalALaCalle
}
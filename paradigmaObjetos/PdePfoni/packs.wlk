const hoy = new Date()

class Pack {
    const fechaDeVencimiento

    method estaVigente() = hoy > fechaDeVencimiento
}

class PackDeInternet inherits Pack {
    var cantidadDeMB

    method puedeSatisfacer(consumo) = consumo.tipoDeConsumo() == "Internet" && self.cubre(consumo)

    method cubre(consumo) = consumo.cantidadDeMB() <= cantidadDeMB

    method consumir(consumo) {
        
    }
}

class PackDeLlamadas inherits Pack {}

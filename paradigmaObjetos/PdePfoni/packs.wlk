const hoy = new Date()

class Pack {
    const vencimiento

    method cubre(consumo)

    method satisfaceConsumo(consumo) = !self.estaVencido() && self.cubre(consumo)

    method consumir(consumo) {}

    method estaVencido() = vencimiento > hoy 

    method acabado() = false
}

class PackDeInternet inherits Pack {
    var mb
    
    method puedeGastarMB(megas) = mb >= megas

    override method cubre(consumo) = consumo.cubiertoPorInternet(self)

    override method consumir(consumo) { mb -= consumo.cantidad() }
}


class PackDeLlamadas inherits Pack {
    var segundos

    method puedeGastarSegundos(cuantos) = segundos >= cuantos

    override method cubre(consumo) = consumo.cubiertoPorLlamada(self)

    override method consumir(consumo) { segundos -= consumo.cantidad() }
}

class PackDeCredito inherits Pack{
    var credito
    
    override method cubre(consumo) = credito > consumo.costo()

    override method consumir(consumo) { credito -= consumo.costo() }

    override method acabado() = credito == 0
}

class LlamadasGratis inherits PackDeLlamadas {
    override method puedeGastarSegundos(cuantos) = true
}

class InternetIlimitadosLosFindes inherits PackDeInternet {
    override method puedeGastarMB(cuantos) = true

    override method cubre(consumo) = consumo.cubiertoPorInternet(self) && consumo.fecha().internalDayOfWeek() > 5
}
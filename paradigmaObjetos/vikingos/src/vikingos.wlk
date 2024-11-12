//!Interprete mal el enunciado suponiendo que al no especificar los granjeros tambien podian luchar en las expediciones

import castas.*

class Vikingo {
    var oro
    var casta
    
    var vidasCobradas
    var cantidadDeArmas

    //Otros
    method subirAExpedicion(expedicion) {
        self.puedeSubirAUnaExpedicion()
        expedicion.subirVikingo(self)
    }

    method puedeSubirAUnaExpedicion() = casta.puedeSubirAExpedicion(self) && self.esProductivo()

    method esProductivo()

    //Castas
    method casta() = casta

    method escalarCasta() { casta.escalar(self) }

    method ascenderAKarl() { casta = karl }

    method ascenderAThrall() { casta = thrall }

    //Vidas tomadas
    method tomarVida() { vidasCobradas += 1 }

    //Armas
    method tieneArmas() = cantidadDeArmas > 0

    method cantidadDeArmas() = cantidadDeArmas

    method adquirirArmas(cuantas) { cantidadDeArmas += cuantas } 

    //Oro
    method oro() = oro

    method adquirirOro(cuanto) { oro += cuanto }
}

class Soldado inherits Vikingo {

    //Otros
    override method esProductivo() = vidasCobradas > 20 && self.tieneArmas()

    //Castas
    override method ascenderAKarl() {
        super()
        self.adquirirArmas(10)
    }
}

class Granjero inherits Vikingo {
    var hijos
    var hectareas

    //Otros
    override method esProductivo() = hectareas >= hijos * 2

    //Hijos
    method adquirirHijos(cuantos) { hijos += cuantos }

    //Hectareas
    method adquirirHectareas(cuantas) { hectareas += cuantas }

    //Castas
    override method ascenderAKarl() {
        super()
        self.adquirirHijos(2)
        self.adquirirHectareas(2)
    }
}
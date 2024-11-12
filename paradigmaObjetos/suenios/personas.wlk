class Persona {
    const sueniosCumplidos = #{}
    const sueniosPendientes = #{}
    var tipoDePersona
    var trabajo
    var cantidadDeHijos

    //suenios
    method cumplir(suenio) {
        self.validarSiEsUnSuenioPendiente(suenio)
        suenio.puedeSerCumplidoPor(self)
        suenio.serCumplidoPor(self)
        sueniosPendientes.remove(suenio)
        sueniosCumplidos.add(suenio)
    }

    method validarSiEsUnSuenioPendiente(suenio) {
        if( !sueniosPendientes.contains(suenio) )
            throw new Exception ( message = suenio + "no esta entre los suenios pendientes" )
    }

    method sueniosPendientes() = sueniosPendientes

    method cumplirSuenioMasPreciado() { self.cumplir( tipoDePersona.suenioMasPreciado(self) ) }

    //tenerHijos
    method tieneHijos() { cantidadDeHijos > 0 }

    method tenerUnHijo() { cantidadDeHijos += 1 }

    method adoptarHijos(cuantos) { cantidadDeHijos += cuantos }

    //trabajo
    method trabajo() = trabajo

    method cambiarDeTrabajo(trabajoNuevo) { trabajo = trabajoNuevo }

    method salario() = trabajo.salario()

    //tipoDePersona
    method cambiarDePersonalidad(nuevaPersonalidad) { tipoDePersona = nuevaPersonalidad }

    //felicidad
    method felicidonios() = sueniosCumplidos.sum { suenio => suenio.felicidonios() }

    method felicidoniosAConseguir() = sueniosPendientes.sum { suenio => suenio.felicidonios() }

    method esFeliz() = self.felicidonios() > self.felicidoniosAConseguir()

    //Otros
    method esAmbiosiosa() = self.sueniosAmbisiosos().size() >= 3

    method sueniosPendientesAmbisiosos() = sueniosPendientes.filter { suenio => suenio.esAmbiosioso() }

    method sueniosCumplidosAmbisiosos() = sueniosCumplidos.filter { suenio => suenio.esAmbiosioso() }

    method sueniosAmbisiosos() = self.sueniosCumplidosAmbisiosos() + self.sueniosPendientesAmbisiosos()
}

object realista {
    method suenioMasPreciado(persona) = persona.sueniosPendientes().max { suenio => suenio.cantidadDeFelicidonios() }
}

object alocado {
    method suenioMasPreciado(persona) = persona.sueniosPendientes().anyOne()
}

object obsesivo {
    method suenioMasPreciado(persona) = persona.sueniosPendientes().first()
}
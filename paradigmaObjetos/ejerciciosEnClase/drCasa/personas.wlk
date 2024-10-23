//------------------------------
//Personas
//------------------------------

class Persona {
    const enfermedades = []
    var temperatura
    var cantidadDeCelulas

    method cantidadDeCelulas() = cantidadDeCelulas

    method aumentarTemperatura(cuanto) {
        temperatura = 45.min(temperatura + cuanto)
    }

    method disminuirCelulas(cuantas) {
        cantidadDeCelulas = 0.max(cantidadDeCelulas - cuantas)
    }

    method enComa() = temperatura == 45 || cantidadDeCelulas < 1000000

    method recibirDosis(unaDosis) {
        enfermedades.forEach { enfermedad => enfermedad.atenuarse(unaDosis * 15) }
        self.removerEnfermedadesCuradas()
    }

    method removerEnfermedadesCuradas() = enfermedades.removeAllSuchThat { enfermedad => enfermedad.celulasAmenazadas() == 0 }

    method contraerEnfermedad(unaEnfermedad) { 
        enfermedades.add(unaEnfermedad) 
    }
    
    method curarse(enfermedad) = enfermedades.remove(enfermedad)

    method tiene(enfermedad) = enfermedades.contains(enfermedad)

    method vivirUnDia() = enfermedades.forEach { enfermedad => enfermedad.afectar(self) }

    method vivirUnosDias(dias) = dias.times { _ => self.vivirUnDia() }

    method cantidadDeCelulasAfectadasPorEnfermedadesAgresivas() = enfermedades.sum { enfermedad => if( enfermedad.esAgresiva(self) ) enfermedad.celulasAmenazadas() else 0 }

    method enfermedadQueMasAfecta() = enfermedades.max { enfermedad => enfermedad.celulasAmenazadas() }

    method morir() {
        temperatura = 0
    }

    method estaMuerto() = temperatura == 0
}

class Medico inherits Persona {
    const dosis

    method atenderA(unaPersona) = unaPersona.recibirDosis(dosis)

    override method contraerEnfermedad(unaEnfermedad) {
        super(unaEnfermedad)
        self.atenderA(self)
    }
}

class JefeDeDepartamento inherits Medico ( dosis = 0 ) {
    const subordinados = []

    override method atenderA(unaPersona) = subordinados.anyOne().atenderA(unaPersona)

    method agregarSubordinado(persona) = subordinados.add ( persona )
}
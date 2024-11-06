import nave.*
import personalidades.*

class Jugador {
    const mochila = []
    var vivo = true
    var impugnado = false
    var nivelDeSospecha = 40
    var property votos = 0

    //Sospecha
    method nivelDeSospecha() = nivelDeSospecha

    method aumentarNivelDeSospecha(cuanto) { nivelDeSospecha += cuanto }

    method disminuirNivelDeSospecha(cuanto) { nivelDeSospecha -= cuanto }

    method esSospechoso() = nivelDeSospecha > 50

    //Items
    method mochila() = mochila

    method buscarItem(item) = mochila.add(item)

    method usarItem(item) = mochila.remove(item)

    method tiene(item) = mochila.contains(item)

    method mochilaVacia() = mochila.isEmpty()

    //impugnado
    method estaImpugnado() = impugnado

    method impugnar() { impugnado = true }

    method desimpugnar() { impugnado = false }

    //votos
    method sumarVoto() { votos += 1 }

    //reunion de emergencia
    method llamarReunionDeEmergencia() { nave.reunionDeEmergencia() }

    //vida
    method estaVivo() = vivo

    method morir() { vivo = false }
}

class Impostor inherits Jugador {
    const rol = "impostor"

    method rol() = rol

    //Tareas
    method realizarTarea() {}

    method completoSusTareas() = true

    //votos
    method votar() {
        nave.unJugadorVivo().votar()
    }
}

class Tripulante inherits Jugador {
    const rol = "tripulante"
    const personalidad

    method rol() = rol

    //Tareas
    const tareas = []

    method agregarTarea(tarea) = tareas.add(tarea)

    method quitarTarea(tarea) = tareas.remove(tarea)

    method tareaPendienteRealizable() = tareas.find { tarea => tarea.puedeRealizarTarea(self) }
    
    method realizarTarea() {
        const tarea = self.tareaPendienteRealizable()
        tarea.realizarTarea(self)
        self.avisarALaNaveDeTareaRealizada(tarea)
    }

    method avisarALaNaveDeTareaRealizada(tarea) { nave.tareaRealizada(tarea) }
    
    method completoSusTareas() = tareas.isEmpty()

    //votos
    method votar() {
        if( !impugnado )
            personalidad.votar()
        impugnado = false
    }
}
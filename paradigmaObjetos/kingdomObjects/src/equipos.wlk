import llavesEspada.*
class Equipo {
    const integrantes = #{}

    method necesitanFrenar() = integrantes.any { heroe => heroe.estaAgotado() }

    method emboscar(monstruo) = integrantes.forEach { heroe => heroe.atacarEnemigo(monstruo) }

    method aQuienesEsUtilEquipar(llaveEspada) = integrantes.filter { heroe => heroe.esUtilEquipar(LlaveEspada) }

    method legarEspada(llaveEspada) {
        self.aQuienesEsUtilEquipar(llaveEspada).max { heroe => heroe.cuantoPotencialOfensivoLeAumenta(llaveEspada) }.equiparLlaveEspada(llaveEspada)
    }
}
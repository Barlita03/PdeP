const hoy = new Date()

class Linea {
    const nroDeTelefono
    const packsActivos = []
    var deudas = 0
    var tipoDeLinea = comun

    method cambiarTipoDeLinea(tipo) { tipoDeLinea = tipo }

    method agregarPack(pack) = packsActivos.add(pack)
    method quitarPack(pack) = packsActivos.remove(pack)

    method consumoEntre(fechaInicial, fechaFinal) = true
    method consumoUltimos30Dias() = self.consumoEntre(hoy.minusDays(30), hoy)

    method consumirInternet(megas) {}
    method consumirLlamadas(segundos) {}

    method puedeConsumir(consumo) {}

    method agregarDeuda(cuanto) { deudas += cuanto }
}

object comun {}
object black {}
object platinum {}

class Pack {
    method satisfaceConsumo(consumo) {}
}
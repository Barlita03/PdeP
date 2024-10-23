const hoy = new Date()

class Linea {
    const packsActivos = []
    const consumos = []
    var deudas = 0
    var tipoDeLinea = comun

    method cambiarTipoDeLinea(tipo) { tipoDeLinea = tipo }

    //packs
    method agregarPack(pack) = packsActivos.add(pack)

    method quitarPack(pack) = packsActivos.remove(pack)

    //Consumos
    method agregarConsumo(consumo) = consumos.add(consumo)

    method consumoEntre(fechaInicial, fechaFinal) = consumos.sum { consumo => consumo.fecha().between(fechaInicial, fechaFinal) }

    method consumoPromedioEntre(fechaInicial, fechaFinal) = self.consumoEntre(fechaInicial, fechaFinal) / consumos.count { consumo => consumo.fecha().between(fechaInicial, fechaFinal) }

    method consumoTotalUltimos30Dias() = self.consumoEntre(hoy.minusDays(30), hoy)

    method puedeConsumir(consumo) {}

    method consumirInternet(megas) {}

    method consumirLlamadas(segundos) {}

    method agregarDeuda(cuanto) { deudas += cuanto }
}

object comun {}
object black {}
object platinum {}
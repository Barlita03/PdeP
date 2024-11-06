const precioFijo = 1
const precioPorMB = 0.10
const precioPorSegundo = 0.05

class Consumo {
    method esSatisfechoPor(pack) = pack.puedeSatisfacer(self)
}

class ConsumoDeInternet inherits Consumo {
    const cantidadDeMB

    method tipoDeConsumo() = "internet"

    method cantidadDeMB() = cantidadDeMB

    method costo() = cantidadDeMB * precioPorMB
}

class ConsumoDeLlamada inherits Consumo {
    const cantidadDeSegundos

    method tipoDeConsumo() = "llamada"

    method cantidadDeSegundos() = cantidadDeSegundos

    method costo() = precioFijo + cantidadDeSegundos * precioPorSegundo

}
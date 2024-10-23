object pdepfoni {
    const property precioPorMB = 0.10
    const property precioFijoPorLlamada = 1
    const property precioPorSegundoDeLlamada = 0.05
}

class Consumo {
    const fecha = new Date()

    method fecha() = fecha

    method cubiertoPorLlamadas(pack) = false
    method cubiertoPorInternet(pack) = false
}

class ConsumoPorInternet inherits Consumo{
    const cantidadDeMB

    method cantidad() = cantidadDeMB

    method costo() = cantidadDeMB * pdepfoni.precioPorMB()

    override method cubiertoPorInternet(pack) = pack.puedeGastarMB(cantidadDeMB)
}

class ConsumoPorLlamada inherits Consumo{
    const segundos

    method cantidad() = segundos

    method costo() = if (segundos <= 30) pdepfoni.precioFijoPorLlamada() else pdepfoni.precioFijoPorLlamada() + segundos * pdepfoni.precioPorSegundoDeLlamada()

    override method cubiertoPorLlamadas(pack) = pack.puedeGastarSegundos(segundos)
}
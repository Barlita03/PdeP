import inmobiliaria.*

class Operacion {
    const inmueble

    method inmueble() = inmueble

    method comision()

    method estaElInmuebleDisponible(cliente) = inmueble.puedeOperar(cliente)

    method reservarPara(cliente) { inmueble.serReservada(cliente) }
    
    method cerrarOperacion(cliente) {}
}

class Alquiler inherits Operacion {
    const cantidadDeMesesDeContrato
    
    override method comision() = inmueble.valor() * cantidadDeMesesDeContrato / 50000
}

class Venta inherits Operacion {
    override method estaElInmuebleDisponible(cliente) = super(cliente) && inmueble.disponibleParaCompra()

    override method comision() = inmueble.valor() * inmobiliaria.porcentajeDeComisionPorVenta()
}
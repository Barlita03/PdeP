import inmuebles.*
class Empleado {
    const operacionesCerradas = []
    const reservasRealizadas = []

    //Operaciones
    method cerreEstaOperacion(operacion) = operacionesCerradas.contains(operacion)

    method cerrarOperacion(operacion, cliente) {
        if ( operacion.puedeOperarCliente(cliente) ){
            operacion.cerrarOperacion(cliente)
            operacionesCerradas.add(operacion)
        }
    }

    method cantidadDeOperacionesCerradas() { operacionesCerradas.size() }

    method tomarReserva(operacion, cliente) { 
        if ( operacion.puedeOperarCliente(cliente) ) {
            operacion.reservarPara(cliente)
            reservasRealizadas.add(operacion)
        }
    }

    method cantidadDeRervasRealizadas(reserva) { reservasRealizadas.size() }

    //Comisiones
    method totalDeComisiones() = operacionesCerradas.sum { operacion => operacion.comision() }

    //Otros
    method zonasEnLasQueOpero() = operacionesCerradas.map { operacion => operacion.inmueble().zona() }.asSet()

    method operoEnLaMismaZonaQue(otroEmpleado) = self.zonasEnLasQueOpero().intersection { otroEmpleado.zonasEnLasQueOpero() }.size() > 0

    method cerroUnaDeMisReservas(otroEmpleado) = reservasRealizadas.any { reserva => otroEmpleado.cerreEstaOperacion(reserva) }

    method noHayBuenoCompanierismo(otroEmpleado) = self.cerroUnaDeMisReservas(otroEmpleado) || otroEmpleado.cerroUnaDeMisReservas(self)

    method vaATenerProblemasCon(otroEmpleado) = self.operoEnLaMismaZonaQue(otroEmpleado) && self.noHayBuenoCompanierismo(otroEmpleado)
}

class Cliente {} //El enunciado no habla de los comportamientos del cliente pero lo agregue por que lo use como objeto en algunos lugares
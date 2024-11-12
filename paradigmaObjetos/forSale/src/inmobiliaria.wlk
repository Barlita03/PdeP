object inmobiliaria {
    const empleados = #{}
    var property porcentajeDeComisionPorVenta = 0.015

    method mejorEmpleadoSegun(criterio) = empleados.max { empleado => criterio.ponderacion(empleado) }
}

object porTotalDeComisiones {
    method ponderacion(empleado) = empleado.totalDeComisiones()
}

object porCantidadDeOperacionesCerradas {
    method ponderacion(empleado) = empleado.cantidadDeOperacionesCerradas()
}

object porCantidadDeReservas {
    method ponderacion(empleado) = empleado.cantidadDeReservas()
}
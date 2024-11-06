class AtaqueFisico {
    const potencia

    method danioCausado(criatura) = potencia
}

class AtaqueMagico {
    const potencia
    const elemento

    method danioCausado(criatura) = potencia * elemento.plusDeElemento( criatura.elemento() )
}
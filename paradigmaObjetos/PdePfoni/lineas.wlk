class TipoDeLinea {}

class Comun inherits TipoDeLinea {}

class Black inherits TipoDeLinea {}

class Platinum inherits TipoDeLinea {}

class Linea {
    const packs = []
    const consumos = []
    const tipoDeLinea

    method agregarPack(pack) = packs.add(pack)
    
    method quitarPack(pack) = packs.remove(pack)


}
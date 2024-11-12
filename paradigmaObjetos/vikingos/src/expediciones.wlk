class Expedicion {
    const integrantes = #{}
    const tierras = #{}

    method valeLaPena() = tierras.all { tierra => tierra.valeLaPena(integrantes) }

    method subirVikingo(vikingo) { integrantes.add(vikingo) }

    method realizarExpedicion() { tierras.forEach { tierra => tierra.serInvadida(integrantes) } }
}
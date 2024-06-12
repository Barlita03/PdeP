---------------PUNTO1---------------

data Personaje = UnPersonaje {
    nombre :: String,
    planeta :: Planeta,
    edad :: Int,
    energia :: Int,
    habilidades :: [Habilidad]
}

type Habilidad = String

type Planeta = String

data Universo = UnUniverso {
    personajes :: [Personaje]
}

data Guantelete = UnGuantelete {
    material :: String,
    gemas :: [Gema]
}

---------------PUNTO2---------------

esPendex :: Personaje -> Bool
esPendex unPersonaje = edad unPersonaje < 45

esAptoParaPendex :: Universo -> Bool
esAptoParaPendex unUniverso = all esPendex (personajes unUniverso)

tieneMasDeUnaHabilidad :: Personaje -> Bool
tieneMasDeUnaHabilidad unPersonaje = length (habilidades unPersonaje) > 1

losQueTienenMasDeUnaHabilidad :: Universo -> [Personaje]
losQueTienenMasDeUnaHabilidad unUniverso = filter tieneMasDeUnaHabilidad (personajes unUniverso)

laEnergiaDeLosQueTienenMasDeUnaHabilidad :: Universo -> [Int]
laEnergiaDeLosQueTienenMasDeUnaHabilidad unUniverso = map energia (losQueTienenMasDeUnaHabilidad unUniverso)

energiaTotalDelUniverso :: Universo -> Int
energiaTotalDelUniverso = sum . laEnergiaDeLosQueTienenMasDeUnaHabilidad

---------------PUNTO3---------------

bajarEnergia :: Int -> Personaje -> Personaje
bajarEnergia cuanto unPersonaje = unPersonaje { energia = energia unPersonaje - cuanto }

gemaDeLaMente :: Int -> Personaje -> Personaje
gemaDeLaMente = bajarEnergia

modificarHabilidades :: (Personaje -> [Habilidad]) -> Personaje -> Personaje
modificarHabilidades modificacion unPersonaje = unPersonaje { habilidades = modificacion unPersonaje }

quietarHabilidadEspecifica :: Habilidad -> Personaje -> [Habilidad]
quietarHabilidadEspecifica unaHabilidad = filter (/= unaHabilidad) . habilidades

gemaDelAlma :: Habilidad -> Personaje -> Personaje
gemaDelAlma unaHabilidad = modificarHabilidades (quietarHabilidadEspecifica unaHabilidad) . bajarEnergia 10

cambiarPlaneta :: Planeta -> Personaje -> Personaje
cambiarPlaneta unPlaneta unPersonaje = unPersonaje { planeta = unPlaneta }

gemaDelEspacio :: Planeta -> Personaje -> Personaje
gemaDelEspacio unPlaneta = cambiarPlaneta unPlaneta . bajarEnergia 20

tieneDosOMenosHabilidades :: Personaje -> Bool
tieneDosOMenosHabilidades unPersonaje = length (habilidades unPersonaje) <= 2

quitarHabilidades :: Personaje -> Personaje
quitarHabilidades unPersonaje
    | tieneDosOMenosHabilidades unPersonaje = modificarHabilidades quitarTodasLasHabilidades unPersonaje
    | otherwise = unPersonaje

quitarTodasLasHabilidades :: Personaje -> [Habilidad]
quitarTodasLasHabilidades unPersonaje = []

gemaDelPoder :: Personaje -> Personaje
gemaDelPoder unPersonaje = quitarHabilidades (bajarEnergia (energia unPersonaje) unPersonaje)

modificarEdad :: Int -> Personaje -> Personaje
modificarEdad nuevaEdad unPersonaje = unPersonaje { edad = nuevaEdad }

reducirEdadOponente :: Personaje -> Personaje
reducirEdadOponente unOponente = modificarEdad (laMitadDeLaEdadPeroMayor unOponente) unOponente

laMitadDeLaEdadPeroMayor :: Personaje -> Int
laMitadDeLaEdadPeroMayor unPersonaje = max 18 (div (edad unPersonaje) 2)

gemaDelTiempo :: Personaje -> Personaje
gemaDelTiempo = reducirEdadOponente . bajarEnergia 50

type Gema = Personaje -> Personaje

dobleAtaque :: Gema -> [Gema]
dobleAtaque = replicate 2

laGemaLoca :: Gema -> Personaje -> Personaje
laGemaLoca unaGema unObjetivo = foldl (flip ($)) unObjetivo (dobleAtaque unaGema)

---------------PUNTO4---------------

guanteleteDeGoma :: Guantelete
guanteleteDeGoma = UnGuantelete {
    material = "goma",
    gemas = [gemaDelTiempo, gemaDelAlma "usar Mjolnir", laGemaLoca (gemaDelAlma "programacion en haskell")]
}

---------------PUNTO5---------------

utilizar :: [Gema] -> Personaje -> Personaje
utilizar gemas unEnemigo = foldl (flip ($)) unEnemigo gemas

---------------PUNTO6---------------

gemaMasPoderosa :: Guantelete -> Personaje -> Gema
gemaMasPoderosa unGuantelete = cualSacaMasEnergia (gemas unGuantelete)

cualSacaMasEnergia :: [Gema] -> Personaje -> Gema
cualSacaMasEnergia (x:xs) unPersonaje
    | null xs = x
    | energia (x unPersonaje) < energia (head xs unPersonaje) = cualSacaMasEnergia xs unPersonaje
    | otherwise = cualSacaMasEnergia (x:tail xs) unPersonaje

---------------PUNTO7---------------

infinitasGemas :: Gema -> [Gema]
infinitasGemas gema = gema:(infinitasGemas gema)

guanteleteDeLocos :: Guantelete
guanteleteDeLocos = UnGuantelete "vesconite" (infinitasGemas gemaDelTiempo)

usoLasTresPrimerasGemas :: Guantelete -> Personaje -> Personaje
usoLasTresPrimerasGemas guantelete = (utilizar . take 3 . gemas) guantelete

--gemaMasPoderosa punisher guanteleteDeLocos no terminaria nunca de ejecutarse ya que la lista no tiene final

--usoLasTresPrimerasGemas guanteleteDeLocos punisher si podria ejecutarse y obtener un resultado debido al lazy evaluation de haskell que le permitira obtener
--los primeros tres elementos sin tener en cuenta el resto de la lista
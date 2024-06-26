----------------EJERCICIO1----------------

data Turista = UnTurista {
    cansancio :: Int,
    stress :: Int,
    viajaSolo :: Bool,
    idiomas :: [String]
}

ana :: Turista
ana = UnTurista {
    cansancio = 0,
    stress = 21,
    viajaSolo = False,
    idiomas = ["espaniol"]
}

beto :: Turista
beto = UnTurista {
    cansancio = 15,
    stress = 15,
    viajaSolo = True,
    idiomas = ["aleman"]
}

cathi :: Turista
cathi = UnTurista {
    cansancio = 15,
    stress = 15,
    viajaSolo = True,
    idiomas = ["aleman", "catalan"]
}

----------------EJERCICIO2,a----------------

type Excursion = Turista -> Turista

modificarStress :: (Int -> Int) -> Turista -> Turista
modificarStress modificacion unTurista = unTurista { stress = modificacion (stress unTurista) }

modificarCansancio :: (Int -> Int) -> Turista -> Turista
modificarCansancio modificacion unTurista = unTurista { cansancio = modificacion (cansancio unTurista) }

bajar :: Int -> Int -> Int
bajar cuanto parametro = parametro - cuanto

subir :: Int -> Int -> Int
subir cuanto parametro = parametro + cuanto

irALaPlaya :: Turista -> Turista
irALaPlaya unTurista
    | viajaSolo unTurista = modificarCansancio (bajar 5) unTurista
    | otherwise = modificarStress (bajar 1) unTurista

apreciarElementoDelPaisaje :: String -> Turista -> Turista
apreciarElementoDelPaisaje elemento = modificarStress (bajar (length elemento))

viajaAcompaniado :: Turista -> Turista
viajaAcompaniado unTurista = unTurista { viajaSolo = False }

modificarIdioma :: ([String] -> [String]) -> Turista -> Turista
modificarIdioma modificador unTurista = unTurista { idiomas = modificador (idiomas unTurista) }

agregar :: String -> [String] -> [String]
agregar idiomaNuevo = (idiomaNuevo :)

salirAHablarAlgunIdioma :: String -> Turista -> Turista
salirAHablarAlgunIdioma idioma = viajaAcompaniado . modificarIdioma (agregar idioma)

calcularIntensidad :: Int -> Int
calcularIntensidad tiempo = div tiempo 4

caminar :: Int -> Turista -> Turista
caminar tiempo = modificarStress (bajar intensidad) . modificarCansancio (subir intensidad)
    where intensidad = calcularIntensidad tiempo

data EstadoMarea = Fuerte | Moderada | Tranquila deriving(Eq)

paseoEnBarco :: EstadoMarea -> Turista -> Turista
paseoEnBarco estadoMarea unTurista
    | esta Fuerte = modificarStress (subir 6) . modificarCansancio (subir 10) $ unTurista
    | esta Tranquila = caminar 10 . apreciarElementoDelPaisaje "mar" . salirAHablarAlgunIdioma "aleman" $ unTurista
    | otherwise = unTurista
    where esta = (estadoMarea ==)

hacerExcursion :: Turista -> Excursion -> Turista
hacerExcursion unTurista unaExcursion = modificarStress (bajar (div (stress unTurista) 10)) . unaExcursion $ unTurista

----------------EJERCICIO2,b----------------

deltaSegun :: (a -> Int) -> a -> a -> Int
deltaSegun f algo1 algo2 = f algo1 - f algo2

type Indice = Turista -> Int

deltaExcursionSegun :: Indice -> Turista -> Excursion -> Int
deltaExcursionSegun indice unTurista unaExcursion = deltaSegun indice (unaExcursion unTurista) unTurista 

cuantoStress :: Turista -> Int
cuantoStress = stress

cuantoCansancio :: Turista -> Int
cuantoCansancio = cansancio

cuantosIdiomas :: Turista -> Int
cuantosIdiomas = length . idiomas

----------------EJERCICIO2,c----------------

esEducativa :: Turista -> Excursion -> Bool
esEducativa unTurista unaExcursion = deltaExcursionSegun cuantosIdiomas unTurista unaExcursion >= 1

esDesestresante :: Turista -> Excursion -> Bool
esDesestresante unTurista unaExcursion = deltaExcursionSegun cuantoStress unTurista unaExcursion <= -3

cualesSonDesestresantes :: Turista -> PaqueteDeExcursiones -> PaqueteDeExcursiones
cualesSonDesestresantes unTurista = filter (esDesestresante unTurista)

----------------EJERCICIO3----------------

type PaqueteDeExcursiones = [Excursion]

completo :: PaqueteDeExcursiones
completo = [caminar 20, apreciarElementoDelPaisaje "cascada", caminar 40, irALaPlaya, salirAHablarAlgunIdioma "melmacquiano"]

ladoB :: Excursion -> PaqueteDeExcursiones
ladoB excursionElegida = [paseoEnBarco Tranquila, excursionElegida, caminar 120]

islaVecina :: EstadoMarea -> PaqueteDeExcursiones
islaVecina estadoMarea
    | estadoMarea == Fuerte = armarExcursion (apreciarElementoDelPaisaje "lago")
    | otherwise = armarExcursion irALaPlaya    
    where armarExcursion = armarExcursionIsla estadoMarea

armarExcursionIsla :: EstadoMarea -> Excursion -> PaqueteDeExcursiones
armarExcursionIsla estadoMarea unaExcursion = [barco, unaExcursion, barco]
    where barco = paseoEnBarco estadoMarea

realizarExcursiones :: PaqueteDeExcursiones -> Turista -> Turista
realizarExcursiones unPaquete unTurista = foldl (flip ($)) unTurista unPaquete

hacerTour :: PaqueteDeExcursiones -> Turista -> Turista
hacerTour unPaquete = realizarExcursiones unPaquete . modificarStress (subir (length unPaquete))

loDejoAcompaniado :: Turista -> Excursion -> Bool
loDejoAcompaniado unTurista unaExcursion = not (viajaSolo unTurista)

algunaLoDejaAcompaniado :: Turista -> [Excursion] -> Bool
algunaLoDejaAcompaniado unTurista = any (loDejoAcompaniado unTurista)

algunaLoDesestresa :: Turista -> [Excursion] -> Bool
algunaLoDesestresa unTurista = any (esDesestresante unTurista)

esConvincente :: Turista -> PaqueteDeExcursiones -> Bool
esConvincente unTurista paquetes = algunaLoDejaAcompaniado unTurista paquetes && algunaLoDesestresa unTurista paquetes

algunoEsConvincente :: Turista -> [PaqueteDeExcursiones] -> Bool
algunoEsConvincente unTurista = any (esConvincente unTurista)

deltaStressPaquete :: Turista -> PaqueteDeExcursiones -> Int
deltaStressPaquete unTurista = sum . map (deltaExcursionSegun cuantoStress unTurista)

espiritualidad :: Turista -> PaqueteDeExcursiones -> Int
espiritualidad unTurista unPaquete = -1 * deltaStressPaquete unTurista unPaquete

lesParecioConvincente :: PaqueteDeExcursiones -> [Turista] -> [Turista]
lesParecioConvincente paquete = filter (flip esConvincente paquete)

efectividad :: PaqueteDeExcursiones -> [Turista] -> Int
efectividad unPaquete turistas = sum (map (flip espiritualidad unPaquete) (lesParecioConvincente unPaquete turistas))

----------------EJERCICIO3,a----------------

playasInfinitas :: PaqueteDeExcursiones
playasInfinitas = repeat irALaPlaya

----------------EJERCICIO3,b----------------

--Obviando el hecho de que nosotros sabemos que nunca se va modificar el estado de viajaSolo, si, esta funcion podria devolver un resultado gracias al lazy evaluation de Haskell,
--por mas que la lista sea infinita, en el instante en el que este se encuentre con un elemento que cumpla la condicion dejara de recorrerla y devolvera el valor

----------------EJERCICIO3,c----------------

--El unico caso donde pueda conocerse la efectividad de este tour seria en el que a ningun turista le resulte convincente lo cual devolveria una efectividad de 0, en cualquier otro caso
--no podria obtenerse una respuesta debido a que es necesario terminar de recorrer la lista para sumar todos sus valores
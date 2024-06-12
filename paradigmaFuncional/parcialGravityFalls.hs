-------------EJERCICIO1-------------

data Criatura = UnaCriatura {
    peligrosidad :: Int,
    necesario :: [Necesidad]
}

type Necesidad = Persona -> Bool

data Persona = UnaPersona {
    edad :: Int,
    experiencia :: Int,
    items :: [String]
}

tieneObjeto :: String -> Persona -> Bool
tieneObjeto unObjeto = elem unObjeto . items

siempreDetras :: Criatura
siempreDetras = UnaCriatura {
    peligrosidad = 0,
    necesario = []
}

calcularPeligrosidadGnomos :: Int -> Int
calcularPeligrosidadGnomos = (2 ^)

gnomos :: Int -> Criatura
gnomos cuantos = UnaCriatura { peligrosidad = calcularPeligrosidadGnomos cuantos, necesario = [tieneObjeto "soplador de hojas"] }

calcularPeligrosidadFantasmas :: Int -> Int
calcularPeligrosidadFantasmas = (20 *)

fantasma :: Int -> [Necesidad] -> Criatura
fantasma categoria asuntosPendientes = UnaCriatura { peligrosidad = calcularPeligrosidadFantasmas categoria, necesario = asuntosPendientes }

-------------EJERCICIO2-------------

---------ARMAR FUNCION-----------
seDeshace :: Persona -> Criatura -> Bool
seDeshace unaPersona unaCriatura = undefined

sumarExperiencia :: Int -> Persona -> Persona
sumarExperiencia cuanto unaPersona = unaPersona { experiencia = experiencia unaPersona + cuanto }

enfrentarCriatura :: Persona -> Criatura -> Persona
enfrentarCriatura unaPersona unaCriatura
    | seDeshace unaPersona unaCriatura = sumarExperiencia (peligrosidad unaCriatura) unaPersona
    | otherwise = sumarExperiencia 1 unaPersona

-------------EJERCICIO3-------------

cuantaExperiencia :: Persona -> [Criatura] -> Int
cuantaExperiencia unaPersona = experiencia . foldl enfrentarCriatura unaPersona

data Manada = UnaManada {
    criaturas :: [Criatura]
}

tieneMenosDe :: Int -> Persona -> Bool
tieneMenosDe unaEdad = (unaEdad <) . edad

suficienteExperiencia :: Int -> Persona -> Bool
suficienteExperiencia unaExperiencia = (unaExperiencia <) . experiencia

manadaDeCriaturas :: Manada
manadaDeCriaturas = UnaManada {
    criaturas = [siempreDetras, gnomos 10, fantasma 3 [tieneMenosDe 13, tieneObjeto "disfraz de oveja"], fantasma 1 [suficienteExperiencia 10]]
}

--cuantaExperiencia dipper manadaDeCriaturas

-------------EJERCICIO4-------------

zipWithIf :: (a -> b -> b) -> (b -> Bool) -> [a] -> [b] -> [b]
zipWithIf _ _ _ [] = [] 
zipWithIf _ _ [] lista2 = lista2
zipWithIf funcion condicion (x:xs) (y:ys)
    | condicion y = funcion x y : zipWithIf funcion condicion xs ys
    | otherwise = y : zipWithIf funcion condicion (x:xs) ys

-------------EJERCICIO5-------------

abecedarioDesde :: Char -> [Char]
abecedarioDesde letra = [letra..'z'] ++ init ['a'..letra]

cantidadDeLetras :: [Char] -> Int
cantidadDeLetras = length

desencriptarLetra :: Char -> Char -> Char
desencriptarLetra letraClave letraBuscada = abecedarioDesde letraBuscada !! (cantidadDeLetras (takeWhile (/= letraBuscada) (abecedarioDesde letraClave)) - 1)

cesar :: Char -> String -> String
cesar letraClave = zipWithIf desencriptarLetra (flip elem ['a'..'z']) (abecedarioDesde letraClave)

posiblesEncriptaciones :: String -> [String]
posiblesEncriptaciones textoEncriptado = map (flip cesar textoEncriptado) ['a'..'z']

--posiblesEncriptaciones "jrzel zrfaxal!"

-------------EJERCICIO6-------------

--LA HICIERON RE COMPLICADA, NI LO TERMINO
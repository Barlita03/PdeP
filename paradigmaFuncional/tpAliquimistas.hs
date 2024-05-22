{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use newtype instead of data" #-}
{-# HLINT ignore "Use infix" #-}

{-
Sustancias sencillas: Un solo elemento en la tabla periodica
Sustancias compuestas: Tienen una serie de componentes, tienen un nombre pero no un numero atomico
Componente: Es un par formado por una sustancia y su cantidad de moleculas, su sustancia puede ser un elemento o un compuesto
-}

--------------------ESTRUCTURAS--------------------

data Sustancias = SustanciasSencillas{
    nombre :: [Char],
    tipo :: [Char],
    grupo :: [Char],
    elemento :: Elemento
} | SustanciasCompuestas{
    nombre :: [Char],
    tipo :: [Char],
    grupo :: [Char],
    componentes :: [Componente]
} deriving (Show)

data Elemento = Elemento{
    nombreElemento :: [Char],
    simboloQuimico :: [Char],
    numeroAtomico :: Int
} deriving (Show)

type Componente = (Sustancias, Int)

--------------------EJERCICIOS--------------------

--Ejercicio1, a

hidrogeno :: Sustancias
hidrogeno = SustanciasSencillas{
    nombre = "hidrogeno",
    tipo = "sencilla",
    grupo = "no metal",
    elemento = Elemento "hidrogeno" "H" 1
}

oxigeno :: Sustancias
oxigeno = SustanciasSencillas{
    nombre = "oxigeno",
    tipo = "sencilla",
    grupo = "no metal",
    elemento = Elemento "oxigeno" "O" 8
}

--Ejercicio1, b

agua :: Sustancias
agua = SustanciasCompuestas{
    nombre = "agua",
    tipo = "compuesta",
    grupo = "no metal",
    componentes = [(hidrogeno, 2), (oxigeno, 1)]
}


--Ejercicio2
conduceBien ::  Sustancias -> [Char] -> Bool
conduceBien sustancia criterio
    | criterio == "calor" = grupo sustancia == "metal" || (tipo sustancia == "compuesta" && grupo sustancia == "halojeno")
    | criterio == "electricidad" = grupo sustancia == "metal" || (tipo sustancia == "sencilla" && grupo sustancia == "gas noble")

--Ejercicio3
ultimaVocal :: [Char] -> Bool
ultimaVocal palabra = elem (last palabra) "a,e,i,o,u"

nombreDeUnion :: [Char] -> [Char]
nombreDeUnion palabra
    | ultimaVocal palabra = nombreDeUnion (init palabra)
    | otherwise = palabra ++ "uro"

--Ejercicio4
combinar :: [Char] -> [Char] -> [Char]
combinar primero segundo = nombreDeUnion primero ++ " de " ++ segundo

--Ejercicio5
mezclar :: [Componente] -> Sustancias
mezclar lista = SustanciasCompuestas{
    nombre = combinar ((nombre . fst . head) lista) ((nombre . fst . last) lista),
    tipo = "compuesta",
    grupo = "no metal",
    componentes = lista
}

--Ejercicio6
devolverMoleculas :: Int -> [Char]
devolverMoleculas moleculas
    | moleculas > 1 = [toEnum (moleculas + fromEnum '0')]
    | otherwise = ""

devolverSimboloQuimico :: [Componente] -> [Char]
devolverSimboloQuimico lista
    | length lista > 1 = resumo ++ devolverSimboloQuimico (tail lista)
    | otherwise = resumo
    where resumo = ((simboloQuimico . elemento . fst . head) lista) ++ devolverMoleculas ((snd . head) lista)

formula :: Sustancias -> [Char]
formula sustancia
    | tipo sustancia == "sencilla" = simboloQuimico (elemento sustancia)
    | otherwise = devolverSimboloQuimico (componentes sustancia)
import 

--Punto1
data Heroes = Heroes{
    epiteto :: String,
    reconocimiento :: Int,
    artefactos :: [Artefactos],
    tareas :: [Tarea]
} deriving (Show)

data Artefactos = Artefactos{
    nombre :: String,
    rareza :: Int
} deriving (Show)

type Tarea = Heroes -> Heroes

--Punto2
data Bestias = Bestias {
    nombreBestia :: String,
    debilidad :: Heroes -> Bool
} deriving (Show)

lanzaDelOlimpo :: Artefactos
lanzaDelOlimpo = Artefactos{
    nombre = "Lanza del olimpo",
    rareza = 100
}

xiphos :: Artefactos
xiphos = Artefactos{
    nombre = "Xiphos",
    rareza = 50
}

relampagoDeZeus :: Artefactos
relampagoDeZeus = Artefactos{
    nombre = "Relampago de zeus",
    rareza = 500
}

pistolaRara :: Artefactos
pistolaRara = Artefactos{
    nombre = "pistolaRara",
    rareza = 500
}

cambiarEpiteto :: String -> Heroes -> Heroes
cambiarEpiteto epiteto heroe = heroe { epiteto = epiteto }

cambiarArtefactos :: [Artefactos] -> Heroes -> Heroes
cambiarArtefactos listaArtefactos heroe = heroe { artefactos = listaArtefactos }

agregarArtefactos :: Artefactos -> Heroes -> Heroes
agregarArtefactos artefacto heroe = heroe { artefactos = artefacto : artefactos heroe }

ganarReconocimiento :: Int -> Heroes -> Heroes
ganarReconocimiento valor heroe = heroe { reconocimiento = reconocimiento heroe + valor }

multiplicarRarezaArtefacto :: Int -> Artefactos -> Artefactos
multiplicarRarezaArtefacto multiplicador artefacto = artefacto { rareza = rareza artefacto * multiplicador }

multiplicarRarezaArtefactos :: Int -> Heroes -> Heroes
multiplicarRarezaArtefactos multiplicador heroe = heroe { artefactos = map (multiplicarRarezaArtefacto 3) . artefactos $ heroe }

esDebil :: Int -> Artefactos -> Bool
esDebil limite artefacto = rareza artefacto > limite

desecharArtefactos :: Int -> Heroes -> Heroes
desecharArtefactos limite heroe = heroe { artefactos = (filter (esDebil 1000) . artefactos) heroe } 

pasarALaHistoria :: Heroes -> Heroes
pasarALaHistoria heroe
    | comparo 1000 = cambiarEpiteto "El mitico" heroe
    | comparo 500 = ( cambiarEpiteto "El mitico" . agregarArtefactos lanzaDelOlimpo) heroe
    | comparo 100 = ( cambiarEpiteto "Hoplita" . agregarArtefactos xiphos) heroe
    | otherwise = heroe
    where comparo = (reconocimiento heroe >=)

encontrarUnArtefacto :: Artefactos -> Tarea
encontrarUnArtefacto artefacto = agregarArtefactos artefacto . ganarReconocimiento (rareza artefacto)

escalarElOlimpo :: Tarea
escalarElOlimpo = ganarReconocimiento 500 . agregarArtefactos relampagoDeZeus . multiplicarRarezaArtefactos 3 . desecharArtefactos 100

ayudarACruzarLaCalle :: Int -> Tarea
ayudarACruzarLaCalle calles = cambiarEpiteto ("Gros" ++ replicate calles 'o')

matarUnaBestia :: Bestias -> Tarea
matarUnaBestia bestia heroe
    | debilidad bestia heroe = cambiarEpiteto ("El asesino de " ++ nombreBestia bestia) heroe
    | otherwise = (cambiarEpiteto "El cobarde" . cambiarArtefactos (drop 1 (artefactos heroe))) heroe

--Punto4
heracles :: Heroes
heracles = Heroes{
    epiteto = "Guardian del olimpo",
    reconocimiento = 700,
    artefactos = [pistolaRara, relampagoDeZeus],
    tareas = []
}

--Punto5
leonDeNemea :: Bestias
leonDeNemea = Bestias {
    nombreBestia = "Leon de Nemea",
    debilidad = (> 20) . length . epiteto
}

matarAlLeonDeNemea :: Tarea
matarAlLeonDeNemea = matarUnaBestia leonDeNemea

--Punto6
agregarTarea :: Tarea -> Heroes -> Heroes
agregarTarea tarea heroe = heroe { tareas = tarea : tareas heroe }

hacerUnaTarea :: Tarea -> Heroes -> Heroes
hacerUnaTarea tarea = agregarTarea tarea . tarea

--Punto7
sumarRarezas :: Heroes -> Int
sumarRarezas heroe
    | null (tail (artefactos heroe)) = rareza (head (artefactos heroe))
    | otherwise = rareza (head (artefactos heroe)) + sumarRarezas ( heroe { artefactos = tail (artefactos heroe)} )

realizarLabor :: [Tarea] -> Heroes -> Heroes
realizarLabor (x:xs) heroe
    | null xs = hacerUnaTarea x heroe
    | otherwise = (hacerUnaTarea x . realizarLabor xs) heroe

presumir :: Heroes -> Heroes -> (Heroes, Heroes)
presumir heroe1 heroe2
    | reconocimiento heroe1 > reconocimiento heroe2 = (heroe1, heroe2)
    | reconocimiento heroe1 < reconocimiento heroe2 = (heroe2, heroe1)
    | sumarRarezas heroe1 > sumarRarezas heroe2 = (heroe1, heroe2)
    | sumarRarezas heroe1 > sumarRarezas heroe2 = (heroe2, heroe1)
    | otherwise = presumir (realizarLabor (tareas heroe2) heroe1) (realizarLabor (tareas heroe1) heroe2)
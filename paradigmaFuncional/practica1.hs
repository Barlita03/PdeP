--Ejercicio1
esMultiploDe3 :: Integral a => a -> Bool
esMultiploDe3 numero = mod numero 3 == 0

--Ejercicio2
esMultiploDe :: Integral a => a -> a -> Bool
esMultiploDe numero1 numero2 = mod numero1 numero2 == 0

--Ejercicio3
cubo :: Num a => a -> a
cubo numero = numero * numero

--Ejercicio4
calculoArea :: Num a => a -> a -> a
calculoArea base altura = base * altura

--Ejercicio5
esBisiesto :: Integral a => a -> Bool
esBisiesto anio = esMultiploDe anio 400 || (esMultiploDe anio 4 && not (esMultiploDe anio 100))

--Ejercicio6
celsiusToFahr :: Fractional a => a -> a
celsiusToFahr temperatura = (temperatura * 1.8) + 32

--Ejercicio7
fahrToCelsius :: Fractional a => a -> a
fahrToCelsius temperatura = (temperatura - 32) / 1.8

--Ejercicio8
haceFrio :: (Ord a, Fractional a) => a -> Bool
haceFrio temperatura = fahrToCelsius temperatura < 8

--Ejercicio9
mcm :: Integral a => a -> a -> a
mcm numero1 numero2 = div (numero1 * numero2) (gcd numero1 numero2)

--Ejercicio10-a
dispersion :: (Num a, Ord a) => a -> a -> a -> a
dispersion dia1 dia2 dia3 = max (max dia1 dia2) dia3 - min (min dia1 dia2) dia3

--Ejercicio10-b
diasParejos :: (Num a, Ord a) => a -> a -> a -> Bool
diasParejos dia1 dia2 dia3 = dispersion dia1 dia2 dia3 < 30

diasLocos :: (Num a, Ord a) => a -> a -> a -> Bool
diasLocos dia1 dia2 dia3 = dispersion dia1 dia2 dia3 > 100

diasNormales :: (Num a, Ord a) => a -> a -> a -> Bool
diasNormales dia1 dia2 dia3 = not (diasParejos dia1 dia2 dia3) && not (diasLocos dia1 dia2 dia3)

--Ejercicio11-a
pesoPino :: Int -> Int
pesoPino altura
    | altura <= 3 = altura * 100 * 3
    | altura > 3 = 900 + ((altura - 3) * 100) * 2

--Ejercicio11-b
esPesoUtil :: (Ord a, Num a) => a -> Bool
esPesoUtil peso = 400 < peso && peso < 1000

--Ejercicio11-c
sirvePino :: Int -> Bool
sirvePino altura = esPesoUtil (pesoPino altura)

--Ejercicio12
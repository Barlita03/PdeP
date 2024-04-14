import GHC.Conc (numCapabilities)
--Ejercicio1
esMultiploDe3 numero = mod numero 3 == 0

--Ejercicio2
esMultiploDe numero1 numero2 = mod numero1 numero2 == 0

--Ejercicio3
cubo numero = numero * numero

--Ejercicio4
calculoArea base altura = base * altura

--Ejercicio5
esBisiesto anio = esMultiploDe anio 400 || (esMultiploDe anio 4 && not (esMultiploDe anio 100))

--Ejercicio6
celsiusToFahr temperatura = (temperatura * 1.8) + 32

--Ejercicio7
fahrToCelsius temperatura = (temperatura - 32) / 1.8

--Ejercicio8
haceFrio temperatura = fahrToCelsius temperatura < 8

--Ejercicio9
mcm numero1 numero2 = div (numero1 * numero2) (gcd numero1 numero2)

--Ejercicio10-a
dispersion dia1 dia2 dia3 = max (max dia1 dia2) dia3 - min (min dia1 dia2) dia3

--Ejercicio10-b
diasParejos dia1 dia2 dia3 = dispersion dia1 dia2 dia3 < 30

diasLocos dia1 dia2 dia3 = dispersion dia1 dia2 dia3 > 100

diasNormales dia1 dia2 dia3 = not (diasParejos dia1 dia2 dia3) && not (diasLocos dia1 dia2 dia3)

--Ejercicio11-a
pesoPino :: Int -> Int
pesoPino altura
    | altura <= 3 = altura * 100 * 3
    | altura > 3 = 900 + ((altura - 3) * 100) * 2

--Ejercicio11-b
esPesoUtil peso = 400 < peso && peso < 1000

--Ejercicio11-c
sirvePino altura = esPesoUtil (pesoPino altura)

--Ejercicio12
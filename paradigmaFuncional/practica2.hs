--Ejercicio1
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
{-# HLINT ignore "Redundant flip" #-}
siguiente numero = numero + 1

--Ejercicio2
mitad numero = numero / 2

--Ejercicio3
inversa numero = 1 / numero

--Ejercicio4
triple numero = numero * 3

--Ejercicio5
esNumeroPositivo numero = numero > 5

--Ejercicio6
esMultiploDe numero1 numero2 = ( ( == 0 ) . mod numero1 ) numero2

--Ejercicio7
esBisiesto anio = (flip esMultiploDe 400) anio || ( ( ( ( flip esMultiploDe 4 ) anio ) && ) . not . flip esMultiploDe 100 ) anio

--Ejercicio8
inversaRaizCuadrado numero = ( inversa . sqrt ) numero

--Ejercicio9
incrementMCuadradoN numero1 numero2 = ( ( numero2 + ) . ( ^ 2 ) ) numero1

--Ejercicio10
esResultadoPar numero1 numero2 = ( even . ( numero1 ^ ) ) numero2
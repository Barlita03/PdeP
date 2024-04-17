esAesthetic :: Int -> Bool
esAesthetic numero = ((==42) . length . show) numero

esMultiploDe :: Int -> Int -> Bool
esMultiploDe numero1 numero2 = ((==0) . mod numero1) numero2

esFraseCheta :: String -> Bool
esFraseCheta frase = (flip esMultiploDe 5 . length) frase
take2 :: Int -> [a] -> [a]
take2 numero (x:xs)
    |numero == 0 = []
    |otherwise = x : take2 (numero - 1) xs

drop2 :: Int -> [a] -> [a]
drop2 numero = reverse . take2 numero . reverse

map2 :: (a -> b) -> [a] -> [b]
map2 funcion (x:xs)
    |null xs = [funcion x]
    |otherwise = funcion x : map2 funcion xs

filter2 :: (a -> Bool) -> [a] -> [a]
filter2 funcion (x:xs)
    |null xs && not (funcion x) = [] 
    |null xs && funcion x = [x] 
    |funcion x = x : resumo
    |otherwise = resumo
    where resumo = filter2 funcion xs

any2 :: (a -> Bool) -> [a] -> Bool
any2 funcion (x:xs)
    |null xs = funcion x
    |funcion x = True
    |otherwise = any2 funcion xs

all2 :: (a -> Bool) -> [a] -> Bool
all2 funcion (x:xs)
    |not (funcion x) = False
    |null xs = funcion x
    |otherwise = funcion x && all2 funcion xs
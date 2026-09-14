sacarPeriodoTexto :: Int -> String
sacarPeriodoTexto cod =
  let per = cod `div` 100000
      yy = per `div` 10
      sem = per `mod` 10
  in "20" ++ show yy ++ "-" ++ show sem

sacarDigitosCategoria :: Int -> Int
sacarDigitosCategoria cod = (cod `div` 1000) `mod` 100

sumaDivisores :: Int -> Int
sumaDivisores n = sum (filter (\x -> n `mod` x == 0) [1..(n-1)])

sacarCategoriaTexto :: Int -> String
sacarCategoriaTexto n
  | suma > n = "Administrative"
  | suma == n = "Engineering"
  | otherwise = "Humanities"
  where suma = sumaDivisores n

sacarConsecutivoTexto :: Int -> String
sacarConsecutivoTexto cod =
  let con = cod `mod` 1000
  in "num" ++ show con

sacarParidadTexto :: Int -> String
sacarParidadTexto cod =
  if even cod
    then "even"
    else "odd"

formatoValido :: Int -> Bool
formatoValido cod = cod >= 1000000 && cod <= 99999999

periodoValido :: Int -> Bool
periodoValido cod =
  let per = cod `div` 100000
      yy = per `div` 10
      sem = per `mod` 10
  in yy >= 26 && yy <= 29 && (sem == 1 || sem == 2)

codigoValido :: Int -> Bool
codigoValido cod = formatoValido cod && periodoValido cod

procesarCodigo :: Int -> String
procesarCodigo cod =
  if not (codigoValido cod)
    then "codigo invalido"
    else
      let per = sacarPeriodoTexto cod
          cat = sacarCategoriaTexto (sacarDigitosCategoria cod)
          con = sacarConsecutivoTexto cod
          par = sacarParidadTexto cod
      in per ++ " " ++ cat ++ " " ++ con ++ " " ++ par

probar :: Int -> IO ()
probar cod = do
  putStrLn ("codigo " ++ show cod ++ ":")
  putStrLn (procesarCodigo cod)
  putStrLn ""

main :: IO ()
main = do
  probar 26276002
  probar 27128112
  probar 27206025
  probar 28124236
  probar 28299115

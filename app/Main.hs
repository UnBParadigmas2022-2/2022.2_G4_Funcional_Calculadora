module Main (main) where

import Operation(calculate)

main :: IO ()
main = read_

read_ :: IO()
read_ = do
  putStrLn "=========Calculadora========="
  putStrLn "Insira abaixo a expressão que você deseja calcular:"
  expr <- getLine
  
  if expr == ""
    then closeProgram
    else do 
        print(expr ++ " = " ++ show(calculate(expr)))
        read_

closeProgram :: IO()
closeProgram = do
  print "Parando graciosamente..."
  print ""
  print "Obrigado por usar!"
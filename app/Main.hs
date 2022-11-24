module Main (main) where

import Operation(calculate)
import System.Exit

main :: IO ()
main = read_

read_ :: IO()
read_ = do
  putStrLn "=========Calculadora========="
  putStrLn "Insira abaixo a expressão que você deseja calcular (Pressione Enter para sair):"
  expr <- getLine

  if expr == ""
    then closeProgram
    else return()

  putStrLn ""
  print("A expressao digitada foi: " ++ expr)
  putStrLn "Tem certeza que deseja calculá-la? (Verifique se ela está correta)"
  putStrLn "Digite S ou N"
  confirmation <- getLine

  if confirmation == "N" ||  confirmation == "n"
    then read_
    else return()

  putStrLn ""
  putStrLn "---------Resultado---------"
  print("" ++ expr ++ " = " ++ show(calculate(expr)) ++ "")
  putStrLn "---------------------------"
  putStrLn ""
  read_

closeProgram :: IO()
closeProgram = do
  putStrLn "Parando graciosamente..."
  putStrLn ""
  putStrLn "Obrigado por usar!"
  exitWith ExitSuccess
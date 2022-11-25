module Run(run) where

import Operation(calculate)
import Parser(removeWhiteSpace)
import Handler(validate, validWhiteSpace)
import System.Exit

run :: IO()
run = do
    printHeader
    read_

printErro :: IO()
printErro = do 
    putStrLn "---------------------------"
    putStrLn ""
    putStrLn "Insira uma expressão válida"
    putStrLn ""
    read_

printHeader :: IO()
printHeader = do 
  putStrLn "=========Calculadora========="
  putStrLn "Para utilizar a calculadora, basta digitar a expressão que você deseja calcular."
  putStrLn "Caso você queira fechar o programa, basta apertar ENTER."
  putStrLn ""
  read_

read_ :: IO()
read_ = do
  putStrLn "---------------------------"
  putStrLn ""
  putStrLn "Insira abaixo a expressão, ou ENTER para sair:"
  expr <- getLine

  print (removeWhiteSpace("", expr))

  if validWhiteSpace(head expr, tail expr)
   then return()
   else printErro

  if validate(removeWhiteSpace("", expr))
    then return()
    else printErro

  if expr == ""
    then closeProgram
    else return()

  putStrLn ""
  putStrLn("A expressao digitada foi: " ++ expr)
  putStrLn "Tem certeza que deseja calculá-la? (S/n)"
  confirmation <- getLine

  if confirmation == "N" ||  confirmation == "n"
    then read_
    else return()

  putStrLn ""
  putStrLn "---------Resultado---------"
  print("" ++ expr ++ " = " ++ show(calculate(removeWhiteSpace("", expr))) ++ "")
  read_

closeProgram :: IO()
closeProgram = do
  putStrLn "Parando..."
  putStrLn "---------------------------"
  exitWith ExitSuccess
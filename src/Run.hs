module Run(run) where

import Operation(basicOperation)
import Parentheses(parentheses)
import Parser(removeWhiteSpace, getOperation)
import Handler(isValid, validWhiteSpace)
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

  if expr == ""
    then closeProgram
    else return()

  if validWhiteSpace(head expr, tail expr)
   then return()
   else printErro

  if isValid(removeWhiteSpace("", expr))
    then return()
    else printErro

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

result :: ([Char]) -> Int
result ([])  = 0
result (str) = basicOperation(parentheses("", str))

calculate :: [Char] -> Int
calculate str = result(str)
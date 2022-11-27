module Run(run) where

import Operation(basicOperation)
import Parentheses(parentheses)
import Handler(isValid, validWhiteSpace)
import Parser(removeWhiteSpace, getArrayWithoutSequenceOfPlusLess)

import System.Exit

-- Wrap system execution in one function 
run :: IO()
run = do
    printHeader
    read_

-- Show error interface when expression is invalid
printError :: IO()
printError = do 
    putStrLn "---------------------------"
    putStrLn ""
    putStrLn "Insira uma expressão válida"
    putStrLn ""
    read_

-- Show calculator system header and signature
printHeader :: IO()
printHeader = do 
  putStrLn "=========Calculadora========="
  putStrLn "Para utilizar a calculadora, basta digitar a expressão que você deseja calcular."
  putStrLn "Caso você queira fechar o programa, basta apertar ENTER."
  putStrLn ""
  read_

-- Resolve user input and call operation module 
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
   else printError

  if isValid(removeWhiteSpace("", expr))
    then return()
    else printError

  putStrLn ""
  putStrLn("A expressao digitada foi: " ++ expr)
  putStrLn "Tem certeza que deseja calculá-la? (S/n)"
  confirmation <- getLine

  if confirmation == "N" ||  confirmation == "n"
    then read_
    else return()

  putStrLn ""
  putStrLn "---------Resultado---------"
  print(expr ++ " = " ++ show(calculate expr))
  read_

-- Used to exit program properly 
closeProgram :: IO()
closeProgram = do
  putStrLn "Parando..."
  putStrLn "---------------------------"
  exitWith ExitSuccess

-- Wrap math module call 
calculate :: ([Char]) -> Int
calculate ([])  = 0
calculate (str) = basicOperation(getArrayWithoutSequenceOfPlusLess("", parentheses("", removeWhiteSpace("", str))))
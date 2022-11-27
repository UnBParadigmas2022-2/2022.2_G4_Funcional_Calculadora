module Handler(isValid, validWhiteSpace, isNextEmpty) where

import Data.Char(isDigit)


-- Function used to validate sring expressions
isValid :: [Char] -> Bool
isValid (str)
    | not(strValidate(str))          = False --- Verifica se tem simbolo invalido
    | head(reverse(str)) == ')'      = True  --- Verifica se o ultimo caracter é )
    | validToken(head(reverse(str))) = False --- Verifica se termina com algum time inválido
    | validInitialOperator(head str) = False --- Verifica se começa com algum time inválido
    | otherwise                      = True

-- Function to validate lexical components of calculator grammar
strValidate :: [Char] -> Bool
strValidate [] = True
strValidate (str)
    | not (validToken h) && not (isDigit h) = False
    | otherwise                             = strValidate t 
    where h = head str
          t = tail str

-- Function used to wrap all valid tokens
validToken :: Char -> Bool
validToken char 
    | char == '+' || char == '-' || char == '*' || char == '/' || char == 'ˆ' || char == '^' || char == 'v' || char == 'V' || char == '(' || char == ')' = True
    | otherwise                                                                                                                                          = False

-- Function used to validate first digit
validInitialOperator :: Char -> Bool
validInitialOperator char 
    | char == '*' || char == '/' || char == 'ˆ' || char == '^' || char == ')' = True
    | otherwise                                                               = False

-- Function used to block a numbers chain in a sequence of spaces
validWhiteSpace :: (Char, [Char]) -> Bool
validWhiteSpace (_, []) = True
validWhiteSpace (char, (h:t))
    | isDigit char && h == ' ' = isNextAToken (t)
    | otherwise = validWhiteSpace(h, t)

-- Function used to verify if next token is an allowed token in validWhiteSpace case
isNextAToken :: [Char] -> Bool
isNextAToken ([]) = True
isNextAToken (h:t)
    | validToken h = True
    | isDigit h = False
    | otherwise = isNextAToken t

-- Verify if next character ends string
isNextEmpty :: [Char] -> Bool
isNextEmpty [] = True
isNextEmpty _ = False

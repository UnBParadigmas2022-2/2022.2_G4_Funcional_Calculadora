module Handler(isValid, validWhiteSpace) where

import Data.Char(isDigit)


isValid :: [Char] -> Bool
isValid (str)
    | not(strValidate(str))          = False --- Verifica se tem simbolo invalido
    | head(reverse(str)) == ')'      = True  --- Verifica se o ultimo caracter é )
    | validToken(head(reverse(str))) = False --- Verifica se termina com algum time inválido
    | validInitialOperator(head str) = False --- Verifica se começa com algum time inválido
    | otherwise                      = True

strValidate :: [Char] -> Bool
strValidate [] = True
strValidate (str)
    | not (validToken h) && not (isDigit h) = False
    | otherwise                             = strValidate t 
    where h = head str
          t = tail str

validToken :: Char -> Bool
validToken char 
    | char == '+' || char == '-' || char == '*' || char == '/' || char == 'ˆ' || char == '^' || char == 'v' || char == 'V' || char == '(' || char == ')' = True
    | otherwise                                                                                                                                          = False

validInitialOperator :: Char -> Bool
validInitialOperator char 
    | char == '*' || char == '/' || char == 'ˆ' || char == '^' || char == ')' = True
    | otherwise                                                               = False

validWhiteSpace :: (Char, [Char]) -> Bool
validWhiteSpace (_, []) = True
validWhiteSpace (char, (h:t))
    | isDigit char && h == ' ' = isNextAToken (t)
    | otherwise = validWhiteSpace(h, t)

isNextAToken :: [Char] -> Bool
isNextAToken ([]) = True
isNextAToken (h:t)
    | validToken h = True
    | isDigit h = False
    | otherwise = isNextAToken t

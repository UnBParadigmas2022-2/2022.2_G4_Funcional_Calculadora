module Handler(validate, validWhiteSpace) where

import Data.Char(isDigit)
import Parser(toList, removeWhiteSpace)



validate :: [Char] -> Bool
validate [] = True
validate (str)
    | not (validToken h) && not (isDigit h) = False
    | validToken(head(reverse(str)))        = False
    | validInitialOperator(h)               = False
    | otherwise                             = validate t 
    where h = head str
          t = tail str

validToken :: Char -> Bool
validToken char 
    | char == '+' || char == '-' || char == '*' || char == '/' || char == 'ˆ' || char == '^' || char == 'v' || char == 'V' = True
    | otherwise                                                                                                            = False

validInitialOperator :: Char -> Bool
validInitialOperator char 
    | char == '*' || char == '/' || char == 'ˆ' || char == '^' = True
    | otherwise                                                = False

validWhiteSpace :: (Char, [Char]) -> Bool
validWhiteSpace (char, []) = True
validWhiteSpace (char, (h:t))
    | isDigit char && h == ' ' = isNextAToken (t)
    | otherwise = validWhiteSpace(h, t)

isNextAToken :: [Char] -> Bool
isNextAToken ([]) = True
isNextAToken (h:t)
    | validToken h = True
    | isDigit h = False
    | otherwise = isNextAToken t

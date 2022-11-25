module Handler(validate) where

import Data.Char(isDigit)

validate :: [Char] -> Bool
validate [] = True
validate (str)
    | not (validToken h) && not (isDigit h) = False
    | validToken(head(reverse(str)))        = False
    | validInitialOperator(h)       = False
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
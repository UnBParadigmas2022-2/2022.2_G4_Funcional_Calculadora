module Handler(validate) where

import Data.Char(isDigit)

validate :: [Char] -> Bool
validate [] = True
validate (h:t)
    | not (validToken h) && not (isDigit h) = False
    | otherwise                 = validate t 

validToken :: Char -> Bool
validToken char 
    | char == '+' || char == '-' || char == '*' || char == '/' || char == 'ˆ' || char == '^' || char == 'v' || char == 'V' = True
    | otherwise                                                                                                            = False
module Parser(toList, getNumber, getAfterNumber, isSymbol, removeWhiteSpace, getOperation, getArrayWithoutSequenceOfPlusLess) where

import Data.Char(isDigit)

toList :: Char -> [Char]
toList a = [a]

isSymbol :: (Char, [Char]) -> Bool
isSymbol (symbol, str) 
    | h == symbol = True
    | otherwise = False
    where h = head str

-------------------------------

getOperation :: (Char, [Char]) -> (Int, [Char])
getOperation (aux, str)
    | aux == 'r' = (getNumber(aux, str), t)
    | otherwise  = (getNumber('_', str), t)
    where t = tail str

getNumber :: (Char, [Char]) -> Int
getNumber (aux, (h:t))
    | aux == 'r' = strToNumber(reverse(getArrayNumber(h, t)))
    | otherwise  = strToNumber(getArrayNumber(h, t)) 

strToNumber :: [Char] -> Int
strToNumber str =  read str :: Int

getArrayNumber :: (Char, [Char]) -> [Char]
getArrayNumber (char, []) = toList char
getArrayNumber (char, (h:t)) 
    | h /= '+' && h /= '-' && h /= '*' && h /= '/' && h /= 'V' && h /= 'ˆ' && h /= '^' = toList char ++ getArrayNumber(h, t)
    | otherwise                                                                        = toList char

-------------------------------

getAfterToken :: ([Char]) -> [Char]
getAfterToken ([]) = ""
getAfterToken (str) 
    | isDigit h = str
    | otherwise = getAfterToken(t)
    where t = tail str
          h = head str

getAfterNumber :: ([Char]) -> [Char]
getAfterNumber ([]) = ""
getAfterNumber (str) 
    | h == '+' || h == '-' || h == '*' || h == '/' || h == 'V' || h == 'ˆ' || h == '^' = str
    | otherwise                                                                        = getAfterNumber(t)
    where t = tail str
          h = head str

-------------------------------

removeWhiteSpace :: ([Char], [Char]) -> [Char]
removeWhiteSpace (support, []) = support
removeWhiteSpace (support, (h:t))
    | h == ' '  = removeWhiteSpace(support, t)
    | otherwise = removeWhiteSpace(support ++ toList(h), t)

-------------------------------

resumePlusLess :: (Char, [Char]) -> [Char]
resumePlusLess (char, (h:t))
    | char == '+' && h == '-' = resumePlusLess('-', t)
    | char == '-' && h == '+' = resumePlusLess('-', t)
    | char == h               = resumePlusLess('+', t)
    | otherwise               = toList char

getAfterPlusLess :: ([Char]) -> [Char]
getAfterPlusLess ([]) = ""
getAfterPlusLess (str) 
    | h /= '+' && h /= '-' = str
    | otherwise = getAfterToken(t)
    where t = tail str
          h = head str

getArrayWithoutSequenceOfPlusLess :: ([Char], [Char]) -> [Char]
getArrayWithoutSequenceOfPlusLess (support, []) = support
getArrayWithoutSequenceOfPlusLess (support, (h:[])) = support ++ toList(h)
getArrayWithoutSequenceOfPlusLess (support, (h:t))
    | h == '+' || h == '-' = support ++ resumePlusLess(h, t) ++ getArrayWithoutSequenceOfPlusLess("", getAfterPlusLess(t))
    | otherwise            = getArrayWithoutSequenceOfPlusLess(support ++ toList(h), t)

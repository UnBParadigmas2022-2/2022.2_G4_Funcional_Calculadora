module Parser(toList, getNumber, getAfterNumber, isSymbol, removeWhiteSpace, getOperation, getArrayWithoutSequenceOfPlusLess) where

import Data.Char(isDigit)

-- Convert char to string
toList :: Char -> [Char]
toList a = [a]

-- Verify if first element of a string is a specific char
isSymbol :: (Char, [Char]) -> Bool
isSymbol (symbol, str) 
    | h == symbol = True
    | otherwise = False
    where h = head str

-------------------------------

-- Return current number and the next operation token
getOperation :: (Char, [Char]) -> (Int, [Char])
getOperation (aux, str)
    | aux == 'r' = (getNumber(aux, str), t)
    | otherwise  = (getNumber('_', str), t)
    where t = tail str

-- Return current number 
getNumber :: (Char, [Char]) -> Int
getNumber (aux, (h:t)) -- aux é usado para controlar a forma como é interpretada a direção do leitura (esq->dir ou dir->esq)
    | aux == 'r' = strToNumber(reverse(getArrayNumber(h, t)))
    | otherwise  = strToNumber(getArrayNumber(h, t)) 

-- Convert string to integer 
strToNumber :: [Char] -> Int
strToNumber str =  read str :: Int

-- Convert a sequence of digit characters into string 
getArrayNumber :: (Char, [Char]) -> [Char]
getArrayNumber (char, []) = toList char
getArrayNumber (char, (h:t)) 
    | h /= '+' && h /= '-' && h /= '*' && h /= '/' && h /= 'V' && h /= 'ˆ' && h /= '^' = toList char ++ getArrayNumber(h, t)
    | otherwise                                                                        = toList char

-------------------------------

-- Used to return a digit (called after a token) 
getAfterToken :: ([Char]) -> [Char]
getAfterToken ([]) = ""
getAfterToken (str) 
    | isDigit h = str
    | otherwise = getAfterToken(t)
    where t = tail str
          h = head str

-- Used to return a token (called after a digit)
getAfterNumber :: ([Char]) -> [Char]
getAfterNumber ([]) = "_"
getAfterNumber (str) 
    | h == '+' || h == '-' || h == '*' || h == '/' || h == 'V' || h == 'ˆ' || h == '^' = str
    | otherwise                                                                        = getAfterNumber(t)
    where t = tail str
          h = head str

-------------------------------

-- Function used to ignore white spaces 
removeWhiteSpace :: ([Char], [Char]) -> [Char]
removeWhiteSpace (support, []) = support
removeWhiteSpace (support, (h:t))
    | h == ' '  = removeWhiteSpace(support, t)
    | otherwise = removeWhiteSpace(support ++ toList(h), t)

-------------------------------

-- Function used to resolve a sequence of plus and minus (and vice versa)
resumePlusLess :: (Char, [Char]) -> [Char]
resumePlusLess (char, (h:t))
    | char == '+' && h == '-' = resumePlusLess('-', t)
    | char == '-' && h == '+' = resumePlusLess('-', t)
    | char == h               = resumePlusLess('+', t)
    | otherwise               = toList char

-- Function to return the next token after a plus or minus token
getAfterPlusLess :: ([Char]) -> [Char]
getAfterPlusLess ([]) = ""
getAfterPlusLess (str) 
    | h /= '+' && h /= '-' = str
    | otherwise = getAfterToken(t)
    where t = tail str
          h = head str

-- Return expression without plus-minus sequence
getArrayWithoutSequenceOfPlusLess :: ([Char], [Char]) -> [Char]
getArrayWithoutSequenceOfPlusLess (support, []) = support
getArrayWithoutSequenceOfPlusLess (support, (h:[])) = support ++ toList(h)
getArrayWithoutSequenceOfPlusLess (support, (h:t))
    | h == '+' || h == '-' = support ++ resumePlusLess(h, t) ++ getArrayWithoutSequenceOfPlusLess("", getAfterPlusLess(t))
    | otherwise            = getArrayWithoutSequenceOfPlusLess(support ++ toList(h), t)

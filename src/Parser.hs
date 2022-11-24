module Parser
(
    toList
    ,getNumber
    ,getBeforeNumber
) where

import Data.Char()

toList :: Char -> [Char]
toList a = [a]

getNumber :: ([Char]) -> Int
getNumber str = strToNumber(reverse(getArrayNumber(h, t))) 
    where h = head str
          t = tail str

strToNumber :: [Char] -> Int
strToNumber str =  read str :: Int

getArrayNumber :: (Char, [Char]) -> [Char]
getArrayNumber (char, []) = toList char
getArrayNumber (char, str) 
    | h /= '+' && h /= '-' && h /= '*' && h /= '/' && h /= 'ˆ' && h /= '^' = toList char ++ getArrayNumber(h, t)
    | otherwise                                                            = toList char
    where h = head str
          t = tail str

getBeforeNumber :: ([Char], [Char]) -> [Char]
getBeforeNumber (support, []) = support
getBeforeNumber (support, str) 
    | h == '+' && h == '-' && h == '*' && h == '/' && h == 'V' && h == 'ˆ' && h == '^' = str
    | otherwise                                    = getBeforeNumber ("", t)
    where h = head str
          t = tail str
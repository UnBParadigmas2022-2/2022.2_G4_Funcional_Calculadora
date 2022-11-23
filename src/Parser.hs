module Parser
(
    toList
    ,strToNumber
    ,getNumber
) where

import Data.Char()

toList :: Char -> [Char]
toList a = [a]

strToNumber :: [Char] -> Int
strToNumber str =  read str :: Int

getNumber :: (Char, [Char]) -> [Char]
getNumber (char, []) = toList char
getNumber (char, str) 
    | h /= '+' && h /= '-' && h /= '*' && h /= '/' && h /= '^' = toList char ++ getNumber(h, t)
    | otherwise                                                = toList char
    where h = head str
          t = tail str
          
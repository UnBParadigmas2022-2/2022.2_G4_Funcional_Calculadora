module Lib (calcula) where

import Data.Char()

toList :: Char -> [Char]
toList a = [a]

strToNumber :: [Char] -> Int
strToNumber str =  read str :: Int

getNumber :: (Char, [Char]) -> [Char]
getNumber (char, []) = toList char
getNumber (char, str) 
    | h /= '+' && h /= '-' = toList char ++ getNumber(h, t)
    | otherwise            = toList char
    where h = head str
          t = tail str

operacao :: (Int, [Char]) -> Int
operacao (_, []) = 0
operacao (num, str) 
    | h == '+'  = num + calcula t
    | h == '-'  = num - calcula t
    | otherwise = operacao(num, t)
    where h = head str
          t = tail str

calcula :: [Char] -> Int
calcula c = resultado(head c, tail c)

resultado :: (Char, [Char]) -> Int
resultado (h, []) = strToNumber(toList(h))
resultado (h, t) = operacao(strToNumber(getNumber(h, t)), t)

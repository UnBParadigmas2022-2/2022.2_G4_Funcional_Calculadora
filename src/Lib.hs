module Lib (calcula) where

import Data.Char()

arrayHead :: Char -> [Char]
arrayHead a = [a]

strToNumber :: [Char] -> Int
strToNumber str =  read str :: Int

getNumber :: (Char, [Char]) -> [Char]
getNumber (char, []) = arrayHead(char)
getNumber (char, array) = if (head array /= '+')
                        then concat[arrayHead(char), getNumber(((head array), (tail array)))]
                        else arrayHead(char)

soma :: (Int, Char, [Char]) -> Int
soma (int, h, []) = 0
soma (int, h, t) = if ( h == '+' ) 
                    then int + calcula t
                    else soma(int, head t, tail t)

calcula :: [Char] -> Int
calcula c = resultado(head c, tail c)

resultado :: (Char, [Char]) -> Int
resultado (h, []) = strToNumber(arrayHead(h))
resultado (h, t) = soma(strToNumber(getNumber(h, t)), head t, tail t)

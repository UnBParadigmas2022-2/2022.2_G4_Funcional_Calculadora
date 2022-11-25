module Parentheses(parentheses) where

import Data.Char()
import Parser(toList)
import Operation(basicOperation)

-- Adiciona tudo o que está dentro dos parenteses
getContent :: ([Char], [Char]) -> [Char]
getContent (support, str)
    | h == ')'  = support
    | otherwise = getContent(support ++ toList(h), t)
    where h = head str
          t = tail str

-- Realiza a operação de dentro do parenteses
getParanthesesContent :: [Char] -> [Char]
getParanthesesContent str = show(basicOperation(getContent("", str)))
    
-- Pega o que está depois do parênteses
getAfterParentheses :: [Char] -> [Char]
getAfterParentheses [] = ""
getAfterParentheses str
    | h == ')' = t
    | otherwise = getAfterParentheses(t)
    where h = head str
          t = tail str

parentheses :: ([Char], [Char]) -> [Char]
parentheses (support, []) = support
parentheses (support, str)
    | h == '(' = support ++ getParanthesesContent(t) ++ getAfterParentheses(t)
    | otherwise = parentheses(support ++ toList(h), t)
    where h = head str
          t = tail str
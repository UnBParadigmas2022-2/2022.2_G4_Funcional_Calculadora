module Parentheses(parentheses) where

import Data.Char()
import Parser(toList, getArrayWithoutSequenceOfPlusLess)
import Operation(basicOperation)

-- Return expression that is inside parentheses
getContent :: ([Char], [Char]) -> [Char]
getContent (support, str)
    | h == ')'  = support
    | otherwise = getContent(support ++ toList(h), t)
    where h = head str
          t = tail str

-- Return result of expression inside parentheses
getParanthesesContent :: [Char] -> [Char]
getParanthesesContent str = show(basicOperation(getArrayWithoutSequenceOfPlusLess("", getContent("", str))))
    
-- Return whatever expression is after parentheses
getAfterParentheses :: [Char] -> [Char]
getAfterParentheses [] = ""
getAfterParentheses str
    | h == ')'  = t
    | otherwise = getAfterParentheses(t)
    where h = head str
          t = tail str
          
-- Wrap all parentheses logic in one function call 
parentheses :: ([Char], [Char]) -> [Char]
parentheses (support, []) = support
parentheses (support, str)
    | h == '('  = support ++ getParanthesesContent(t) ++ getAfterParentheses(t)
    | otherwise = parentheses(support ++ toList(h), t)
    where h = head str
          t = tail str
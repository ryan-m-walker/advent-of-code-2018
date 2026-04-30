module Main where

import System.IO (readFile)
import qualified Data.Set as Set

parse :: String -> [Int]
parse = map read . lines

findDuplicate :: [Int] -> Int
findDuplicate changes = go 0 Set.empty (cycle changes)
  where
    go freq seen (x:xs)
      | Set.member freq seen = freq
      | otherwise = go (freq + x) (Set.insert freq seen) xs
    go freq _ [] = freq

main :: IO ()
main = do
  input <- readFile "input.txt"
  print $ findDuplicate (parse input)

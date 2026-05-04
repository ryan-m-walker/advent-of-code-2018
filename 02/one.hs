import Data.List (group, sort)

charFreqs :: String -> [Int]
charFreqs = map length . group . sort

checksum :: [String] -> Int
checksum ids = twos * threes
  where
    freqs  = map charFreqs ids
    twos   = length $ filter (elem 2) freqs
    threes = length $ filter (elem 3) freqs

main :: IO ()
main = do
    contents <- readFile "input.txt"
    let ids = lines contents
    print $ checksum ids

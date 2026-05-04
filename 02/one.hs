import Data.List (group, sort)

charFreqs :: String -> [Int]
charFreqs = map length . group . sort

hasExactly :: Int -> String -> Bool
hasExactly n = elem n . charFreqs

checksum :: [String] -> Int
checksum ids = length (filter (hasExactly 2) ids) * length (filter (hasExactly 3) ids)

main :: IO ()
main = do
    input <- readFile "input.txt"
    let ids = lines input
    print (checksum ids)

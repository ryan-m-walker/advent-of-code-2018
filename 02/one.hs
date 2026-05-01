import Data.List (group, sort)

hasCount :: Int -> String -> Bool
hasCount n = any ((== n) . length) . group . sort

checksum :: [String] -> Int
checksum ids = twos * threes
  where
    twos   = length $ filter (hasCount 2) ids
    threes = length $ filter (hasCount 3) ids

main :: IO ()
main = do
    contents <- readFile "input.txt"
    let ids = lines contents
    print $ checksum ids

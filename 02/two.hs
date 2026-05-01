commonLetters :: String -> String -> String
commonLetters a b = [x | (x, y) <- zip a b, x == y]

diffByOne :: String -> String -> Bool
diffByOne a b = length a - length (commonLetters a b) == 1

findMatch :: [String] -> String
findMatch [] = error "no match found"
findMatch (x:xs) = case filter (diffByOne x) xs of
    (y:_) -> commonLetters x y
    []    -> findMatch xs

main :: IO ()
main = do
    contents <- readFile "input.txt"
    let ids = lines contents
    putStrLn $ findMatch ids

diffByOne :: String -> String -> Bool
diffByOne a b = length (filter id (zipWith (/=) a b)) == 1

commonChars :: String -> String -> String
commonChars a b = [x | (x, y) <- zip a b, x == y]

findPair :: [String] -> String
findPair [] = error "no pair found"
findPair (x:xs) = case filter (diffByOne x) xs of
    (y:_) -> commonChars x y
    []    -> findPair xs

main :: IO ()
main = do
    contents <- readFile "input.txt"
    let ids = lines contents
    putStrLn $ findPair ids

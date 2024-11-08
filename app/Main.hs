{-# OPTIONS_GHC -Wall #-}

import Data.Char
import Data.Function
import Data.List
import Data.Maybe
import Text.Read
import Control.Monad

newtype Puzzle = Puzzle [Int]

instance Show Puzzle where
    show (Puzzle puzzle) = intercalate "\n" $ chunksOf 9 (map intToDigit puzzle)
        where
            chunksOf _ [] = []
            chunksOf n xs = take n xs : chunksOf n (drop n xs)

instance Read Puzzle where
    readsPrec _ str = [(Puzzle puzzle, "") | length puzzle == 81]
        where puzzle = map (\c -> if isDigit c then digitToInt c else 0) str

main :: IO ()
main = do
    solutions <- solve <$> getPuzzle
    if null solutions
        then putStrLn "No solution found."
        else putStrLn "Solution(s):" *> mapM_ print solutions

getPuzzle :: IO Puzzle
getPuzzle = do
    putStrLn "Please enter the puzzle, row by row, with '.' for empty cells."
    puzzle <- readMaybe . filter (/='\n') . unlines <$> replicateM 9 getLine
    maybe (putStrLn "Invalid puzzle. Try again." *> getPuzzle) return puzzle

solve :: Puzzle -> [Puzzle]
solve (Puzzle puzzle) = if isNothing pos then [Puzzle puzzle] else solutions
    where
        pos = elemIndex 0 puzzle
        numList = possibleList puzzle $ fromJust pos
        puzzles = map (\x -> replace (fromJust pos) x puzzle) numList
        solutions = concatMap (solve . Puzzle) puzzles

possibleList :: [Int] -> Int -> [Int]
possibleList puzzle pos = [1..9] \\ [puzzle !! i | i <- posList]
    where
        posList = filter (\x -> row x || col x || box x) [0..80]
        row = ((==) `on` (`div` 9)) pos
        col = ((==) `on` (`mod` 9)) pos
        box = ((&&) . ((==) `on` (`div` 27)) pos) <*> ((==) `on` ((`div` 3) . (`mod` 9))) pos

replace :: Int -> a -> [a] -> [a]
replace pos val list = take pos list ++ [val] ++ drop (pos + 1) list

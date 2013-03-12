import Text.Printf
import System.Environment
import Data.List

validPLL (m, n, pll_hz) = (pll_hz >= 275) && (pll_hz <= 550)

cartProd xs ys = [(x, y) | x <- xs, y <- ys]

-- Build up tuples of (M, N, PLL_FREQ, CCLKDIV, CCLK)

allPossiblePLLMultipliers :: [(Double, Double, Double)]
allPossiblePLLMultipliers = map (\(m,n) -> (m, n, 12*2*m/n)) $ cartProd [6..512] [1..256]
allPLLMultipliers = filter validPLL allPossiblePLLMultipliers

allClockConfigs :: [(Double, Double, Double, Double, Double)]
allClockConfigs = [(m, n, pll_hz, cclk_div, pll_hz / cclk_div) | (m, n, pll_hz) <- allPLLMultipliers, cclk_div <- [1..256]]

getClockConfigs target_hz = map (\(m, n, pll_hz, cclkdiv, cclk) -> (m, n, cclkdiv)) $ filter (\(m, n, pll_hz, cclkdiv, cclk) -> cclk == target_hz) allClockConfigs

main :: IO ()
main = do
     args <- getArgs
     putStrLn " M    N  CCLKDIV"

     let target_hz = read (head args) :: Double
     mapM_ (\(m, n, cclkdiv) -> printf "%3.0f  %3.0f  %3.0f\n" m n cclkdiv) $ getClockConfigs target_hz
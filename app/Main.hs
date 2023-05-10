module Main where

import FavoritesParser (parseString)
import SiteMapper (mapSites)
import TemplateEngine (render)

main :: IO ()
main =
  do
    putStrLn "Generating index!"
    rawText <- readFile "links.txt"
    template <- readFile "template.html"
    let generated = render template . mapSites <$> FavoritesParser.parseString rawText

    case generated of
      Left parseError -> putStrLn "Error parsing favorites file" >> print parseError
      Right html -> writeFile "index.html" html
module TemplateEngine (render) where

import Data.Char (isSpace)
import qualified Data.Text as T
import SiteTypes (Favorites, Site (..), Url (hostname, path, protocol))

linkTag :: Site -> String
linkTag Site {url = u, displayName = name, logo = l} =
  "<a href=\""
    ++ fullLink u
    ++ "\">\n"
    ++ "\t<img src=\""
    ++ fullLink l
    ++ "\" />\n"
    ++ "\t<p>"
    ++ name
    ++ "</p>\n"
    ++ "</a>\n"
  where
    fullLink uri = protocol uri ++ hostname uri ++ "/" ++ path uri

generateLinks :: Favorites -> String
generateLinks = concatMap linkTag

replaceLine :: String -> (String -> Bool) -> String -> String
replaceLine s p r = unlines . map (\l -> if p l then addIndentation l r else l) $ lines s

render :: String -> Favorites -> String
render template favorites =
  replaceLine template isSiteTag (generateLinks favorites)
  where
    isSiteTag s = "<!-- sites -->" == T.unpack (T.strip $ T.pack s)

addIndentation :: String -> String -> String
addIndentation line replacements = unlines $ map (indentation ++) $ lines replacements
  where
    indentation = takeWhile isSpace line
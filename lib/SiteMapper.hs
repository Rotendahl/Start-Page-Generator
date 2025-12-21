module SiteMapper (mapSites) where

import Data.Maybe (fromMaybe)
import SiteTypes (Favorites, ParsedSite, Site (..), Url (..))

mapSites :: [ParsedSite] -> Favorites
mapSites = map mapSite

mapSite :: ParsedSite -> Site
mapSite (parsedName, parsedUrl, parsedLogo) =
  Site
    { displayName = fromMaybe (hostname parsedUrl) parsedName,
      logo = fromMaybe replacementLogo parsedLogo,
      url = parsedUrl
    }
  where
    replacementLogo =
      Url
        { protocol = "https://",
          hostname = "img.logo.dev",
          path = "" ++ hostname parsedUrl
          ++ "?token=pk_CRpvkunsQi2ojaUrvTgQZA"
        }

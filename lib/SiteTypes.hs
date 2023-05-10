module SiteTypes (DisplayName, Logo, Url (..), Site (..), Favorites, ParsedSite) where

type DisplayName = String

data Url = Url {protocol :: String, hostname :: String, path :: String} deriving (Show, Eq)

type Logo = Url

type ParsedSite = (Maybe DisplayName, Url, Maybe Logo)

data Site = Site
  { displayName :: DisplayName,
    logo :: Logo,
    url :: Url
  }
  deriving (Show)

type Favorites = [Site]
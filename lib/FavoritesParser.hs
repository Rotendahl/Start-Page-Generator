module FavoritesParser (parseString) where

import qualified Data.Text as T
import SiteTypes (DisplayName, Logo, ParsedSite, Url(..))
import Text.ParserCombinators.Parsec
    ( ParseError,
      eof,
      space,
      string,
      alphaNum,
      noneOf,
      anyToken,
      manyTill,
      optionMaybe,
      skipMany1,
      (<|>),
      many,
      parse,
      skipMany,
      try,
      Parser, option, sepBy1, many1, char )
import Data.List (intercalate)

parseString :: String -> Either ParseError [ParsedSite]
parseString = parse (lexeme *> parseFavorites <* eof) ""

lexeme :: Parser ()
lexeme = skipMany $ whiteSpace <|> comment

whiteSpace :: Parser ()
whiteSpace = skipMany1 space

comment :: Parser ()
comment = skipMany1 $ noneOf "*\n"

parseFavorites :: Parser [ParsedSite]
parseFavorites = many (parseSite <* lexeme)

parseSite :: Parser ParsedSite
parseSite = do
  _ <- string "*"
  whiteSpace
  name <- optionMaybe $ try parseDisplayName
  url <- parseUrl
  logo <- optionMaybe $ try parseLogo
  return (name, url, logo)

parseDisplayName :: Parser DisplayName
parseDisplayName = do
  name <- manyTill (alphaNum <|> space) (string "->")
  whiteSpace
  return $ strip name
  where
    strip s = T.unpack (T.strip $ T.pack s)

parseUrl :: Parser Url
parseUrl = do
  parsedProtocol <- option "https" $ try $ manyTill alphaNum (string "://")
  parsedHostName <- sepBy1 (many1 $ noneOf " /\n") (char '.')
  let host = intercalate "." parsedHostName
  parsedPath <- option "" $ try $ char '/' *> manyTill anyToken space
  return $ Url {protocol = parsedProtocol ++ "://", hostname =  host, path = parsedPath}


parseLogo :: Parser Logo
parseLogo = do
  _ <- skipMany space
  _ <- string "<-"
  _ <- skipMany1 space
  parseUrl

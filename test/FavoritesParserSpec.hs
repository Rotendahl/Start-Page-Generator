module FavoritesParserSpec (spec) where

import FavoritesParser (parseString)
import Test.Hspec
import ParsedSites ( parsedSites )

spec :: Spec
spec = do
  describe "Parser Tests" $ do
    it "Sample with only comments and white space is empty" $ do
      parseString <$> readFile "test/empty-input.txt"
        `shouldReturn` Right []

    it "Parses full example" $ do
      parseString <$> readFile "test/sample-input.txt"
        `shouldReturn` Right parsedSites
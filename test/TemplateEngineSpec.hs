module TemplateEngineSpec (spec) where

import SiteTypes (Site (..), Url (..))
import TemplateEngine
import Test.Hspec

spec :: Spec
spec = do
  describe "render template" $ do
    it "renders favorites" $ do
      render
        "<div>\n\t<!-- sites -->\n<div>\n"
        [ Site
            { displayName = "site a",
              logo =
                Url
                  { protocol = "https://",
                    hostname = "site-a.com",
                    path = "logo.png"
                  },
              url =
                Url
                  { protocol = "https://",
                    hostname = "site-a.com",
                    path = ""
                  }
            },
          Site
            { displayName = "site b",
              logo =
                Url
                  { protocol = "https://",
                    hostname = "site-b.com",
                    path = ""
                  },
              url =
                Url
                  { protocol = "https://",
                    hostname = "site-b.com",
                    path = "logo.png"
                  }
            }
        ]
        `shouldBe` "<div>\n"
          ++ "\t<a href=\"https://site-a.com/\">\n"
          ++ "\t\t<img src=\"https://site-a.com/logo.png\" />\n"
          ++ "\t\t<p>site a</p>\n"
          ++ "\t</a>\n"
          ++ "\t<a href=\"https://site-b.com/logo.png\">\n"
          ++ "\t\t<img src=\"https://site-b.com/\" />\n"
          ++ "\t\t<p>site b</p>\n"
          ++ "\t</a>\n"
          ++ "\n<div>\n"

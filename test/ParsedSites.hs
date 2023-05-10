module ParsedSites (parsedSites) where

import SiteTypes (ParsedSite, Url (..))

parsedSites :: [ParsedSite]
parsedSites =
  [ ( Just "Site A",
      Url {protocol = "https://", hostname = "site-a.com", path = ""},
      Just Url {protocol = "https://", hostname = "site-a.com", path = "logo.png"}
    ),
    ( Just "Site B",
      Url
        { protocol = "https://",
          hostname = "site-b.com",
          path = ""
        },
      Nothing
    ),
    ( Nothing,
      Url
        { protocol = "https://",
          hostname = "site-c.com",
          path = ""
        },
      Nothing
    ),
    ( Nothing,
      Url
        { protocol = "http://",
          hostname = "site-d.com",
          path = ""
        },
      Nothing
    ),
    ( Nothing,
      Url
        { protocol = "https://",
          hostname = "sub.domain.site.com",
          path = "with/path"
        },
      Nothing
    ),
    ( Nothing,
      Url
        { protocol = "https://",
          hostname = "sub.domain.site.com",
          path = "with/path"
        },
      Just
        ( Url
            { protocol = "https://",
              hostname = "sub.domain.site.com",
              path = "with/path/logo.png"
            }
        )
    )
  ]
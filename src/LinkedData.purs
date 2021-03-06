module LinkedData
    ( linkedData
    ) where

import Prelude
import Data.Argonaut ((:=), (~>), jsonEmptyObject, stringify)
import Data.MediaType (MediaType(MediaType))

import Halogen.HTML as HH
import Halogen.HTML.Properties as HP

import Language (Language(..))

linkedData :: Language -> HH.PlainHTML
linkedData language = HH.script
    [ HP.type_ $ MediaType "application/ld+json" ]
    [ HH.text $ stringify content ]
  where
    content = "@context" := "http://schema.org"
           ~> "@type"    := "Person"
           ~> "name"     := "Siegfried Weber"
           ~> "jobTitle" :=
               case language of
                   De -> "Freiberuflicher Softwareentwickler und Experte für funktionale Programmierung"
                   En -> "Freelance software developer and expert for functional programming"
           ~> "image"    := "https://www.siegfriedweber.net/images/siegfried_weber-2.jpg"
           ~> "email"    := "mailto:mail@siegfriedweber.net"
           ~> "url"      := "https://www.siegfriedweber.net"
           ~> "sameAs"   := [ "https://www.gulp.de/gulp2/home/profil/siegfriedweber"
                            , "https://www.xing.com/profile/Siegfried_Weber18"
                            , "https://de.linkedin.com/in/siegfriedweber"
                            , "https://github.com/siegfriedweber"
                            ]
           ~> jsonEmptyObject


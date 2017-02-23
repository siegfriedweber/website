module Elements.Language
    ( choose
    , multilingualContent
    ) where

import Prelude

import Halogen.HTML as HH
import Halogen.HTML.Core as HC
import Halogen.HTML.Properties as HP

import Language (Language(..), languageCode)

multilingualContent :: forall p i
                     . Language
                    -> Array (HH.HTML p i)
                    -> HH.HTML p i
multilingualContent l = HH.div [ langAttr $ languageCode l ]

type Lang a =
    { de :: a
    , en :: a
    }

choose :: forall a. Language -> Lang a -> a
choose De a = a.de
choose En a = a.en

langAttr :: forall r i. String -> HP.IProp (lang :: String | r) i
langAttr = HP.prop (HC.PropName "lang")


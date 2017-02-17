module Elements.Icon
    ( LinkedIconStyle
    , iconStyles
    , linkedIcon
    , linkedIcon_
    , linkedIconStyleDefault
    ) where

import Prelude
import Data.Maybe(Maybe(Just))

import CSS as C
import CSS.VerticalAlign as CV
import Halogen.HTML.Indexed as HH
import Halogen.HTML.Properties.Indexed as HP

import Elements.Types (Style, defaultStyle)

iconStyles :: Array Style
iconStyles = getIconStyles linkedIconStyleDefault

newtype LinkedIconStyle = LinkedIconStyle
    { link :: Style
    , icon :: Style
    }

getIconStyles :: LinkedIconStyle -> Array Style
getIconStyles (LinkedIconStyle style) =
    [ style.link
    , style.icon
    ]

linkedIconStyleDefault :: LinkedIconStyle
linkedIconStyleDefault = LinkedIconStyle
    { link : defaultStyle
        { className = "linked-icon"
        , cssCommon = Just do
            C.paddingLeft $ C.px 12.0
            C.paddingRight $ C.px 12.0
        }
    , icon : defaultStyle
        { className = "linked-icon__image"
        , cssCommon = Just $ CV.verticalAlign CV.Top
        }
    }

linkedIcon_ :: forall p i. String -> String -> String -> HH.HTML p i
linkedIcon_ = linkedIcon linkedIconStyleDefault

linkedIcon :: forall p i. LinkedIconStyle -> String -> String -> String -> HH.HTML p i
linkedIcon (LinkedIconStyle style) name icon url =
    HH.a [ HP.href url, HP.class_ $ HH.className style.link.className ]
         [ HH.img [ HP.src icon
                  , HP.alt name
                  , HP.class_ $ HH.className style.icon.className
                  ]
         ]


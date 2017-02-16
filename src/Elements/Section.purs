module Elements.Section
    ( SectionStyle
    , section
    , section_
    , sectionStyleFooter
    , sectionStyleHeader
    , sectionStyleLinks
    , sectionStyles
    ) where

import Prelude
import Data.Maybe(Maybe(Just))

import CSS as C
import CSS.Common as CC
import Halogen.HTML.Indexed as HH
import Halogen.HTML.Properties.Indexed as HP

import Elements.Colors (darkBackgroundColor, darkTextColor, lightBackgroundColor, lightTextColor)
import Elements.Types (Style, defaultStyle)

sectionStyles :: Array Style
sectionStyles =
    [ sectionStyleHeaderOuter
    , sectionStyleHeaderInner
    , sectionStyleDefaultOuter
    , sectionStyleDefaultInner
    , sectionStyleLinksOuter
    , sectionStyleLinksInner
    , sectionStyleFooterOuter
    , sectionStyleFooterInner
    ]

newtype SectionStyle = SectionStyle
    { outer :: Style
    , inner :: Style
    }

sectionStyleHeader :: SectionStyle
sectionStyleHeader = SectionStyle
    { outer : sectionStyleHeaderOuter
    , inner : sectionStyleHeaderInner
    }

sectionStyleHeaderOuter :: Style
sectionStyleHeaderOuter = defaultStyle
    { className = "sectionHeaderOuter"
    , cssCommon = Just $ do
        C.backgroundColor darkBackgroundColor
        C.backgroundImage $ C.url "images/header_background.jpg"
        C.backgroundRepeat C.noRepeat
    , cssSmall  = Just $ C.paddingTop $ C.px 24.0
    , cssMedium = Just $ C.paddingTop $ C.px 150.0
    , cssLarge  = Just $ C.paddingTop $ C.px 150.0
    }

defaultSectionInnerStyle :: Style
defaultSectionInnerStyle = defaultStyle
    { cssSmall  = Just $ C.width $ C.pct 100.0
    , cssMedium = Just $ C.width $ C.px 480.0
    , cssLarge  = Just $ C.width $ C.px 960.0
    }

sectionStyleHeaderInner :: Style
sectionStyleHeaderInner = defaultSectionInnerStyle
    { className = "sectionHeaderInner"
    , cssCommon = Just $ do
        C.marginLeft CC.auto
        C.marginRight CC.auto
        C.backgroundColor lightBackgroundColor
        C.color darkTextColor
        C.boxShadow C.nil C.nil (C.px 72.0) (C.rgba 0 0 0 0.8)
    }

sectionStyleLinks :: SectionStyle
sectionStyleLinks = SectionStyle
    { outer : sectionStyleLinksOuter
    , inner : sectionStyleLinksInner
    }

sectionStyleLinksOuter :: Style
sectionStyleLinksOuter = defaultStyle
    { className = "sectionLinksOuter"
    , cssCommon = Just $ do
        C.paddingBottom $ C.px 36.0
        C.backgroundColor lightBackgroundColor
    }

sectionStyleLinksInner :: Style
sectionStyleLinksInner = defaultSectionInnerStyle
    { className = "sectionLinksInner"
    , cssCommon = Just $ do
        C.marginLeft CC.auto
        C.marginRight CC.auto
        C.paddingTop $ C.px 24.0
        C.paddingBottom $ C.px 24.0
        C.backgroundColor darkBackgroundColor
    }

sectionStyleFooter :: SectionStyle
sectionStyleFooter = SectionStyle
    { outer : sectionStyleFooterOuter
    , inner : sectionStyleFooterInner
    }

sectionStyleFooterOuter :: Style
sectionStyleFooterOuter = defaultStyle
    { className = "sectionFooterOuter"
    , cssCommon = Just $ C.backgroundColor darkBackgroundColor
    }

sectionStyleFooterInner :: Style
sectionStyleFooterInner = defaultSectionInnerStyle
    { className = "sectionFooterInner"
    , cssCommon = Just $ do
        C.marginLeft CC.auto
        C.marginRight CC.auto
        C.paddingTop $ C.px 36.0
        C.paddingBottom $ C.px 36.0
        C.backgroundColor darkBackgroundColor
        C.color lightTextColor
    }

sectionStyleDefault :: SectionStyle
sectionStyleDefault = SectionStyle
    { outer : sectionStyleDefaultOuter
    , inner : sectionStyleDefaultInner
    }

sectionStyleDefaultOuter :: Style
sectionStyleDefaultOuter = defaultStyle
    { className = "sectionStyleDefaultOuter"
    , cssCommon = Just $ C.backgroundColor lightBackgroundColor
    }

sectionStyleDefaultInner :: Style
sectionStyleDefaultInner = defaultSectionInnerStyle
    { className = "sectionStyleDefaultInner"
    , cssCommon = Just $ do
        C.marginLeft CC.auto
        C.marginRight CC.auto
        C.paddingTop $ C.px 36.0
        C.paddingBottom $ C.px 36.0
        C.backgroundColor lightBackgroundColor
        C.color darkTextColor
    }

section_ :: forall p i. Array (HH.HTML p i) -> HH.HTML p i
section_ = section sectionStyleDefault

section :: forall p i. SectionStyle -> Array (HH.HTML p i) -> HH.HTML p i
section (SectionStyle style) content =
    HH.div
        [ HP.class_ $ HH.className style.outer.className
        ]
        [ HH.div
            [ HP.class_ $ HH.className style.inner.className
            ]
            content
        ]


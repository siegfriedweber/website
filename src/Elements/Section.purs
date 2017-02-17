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
import Data.Maybe (Maybe(Just))

import CSS as C
import CSS.Border as CB
import CSS.Common as CC
import Halogen.HTML.Indexed as HH
import Halogen.HTML.Properties.Indexed as HP

import Elements.Colors ( darkBackgroundColor
                       , darkTextColor
                       , lightBackgroundColor
                       , lightTextColor
                       )
import Elements.Types (Style, defaultStyle)

sectionStyles :: Array Style
sectionStyles = getSectionStyles sectionStyleHeader
             <> getSectionStyles sectionStyleDefault
             <> getSectionStyles sectionStyleLinks
             <> getSectionStyles sectionStyleFooter

newtype SectionStyle = SectionStyle
    { outer :: Style
    , inner :: Style
    }

getSectionStyles :: SectionStyle -> Array Style
getSectionStyles (SectionStyle styles) =
    [ styles.outer
    , styles.inner
    ]

defaultSectionInnerStyle :: Style
defaultSectionInnerStyle = defaultStyle
    { cssSmall  = Just $ C.width $ C.pct 100.0
    , cssMedium = Just $ C.width $ C.px 480.0
    , cssLarge  = Just $ C.width $ C.px 960.0
    }

sectionStyleHeader :: SectionStyle
sectionStyleHeader = SectionStyle
    { outer : defaultStyle
        { className = "sectionHeaderOuter"
        , cssCommon = Just do
            C.backgroundColor darkBackgroundColor
            C.backgroundImage $ C.url "images/header_background.jpg"
            C.backgroundRepeat C.noRepeat
        , cssSmall  = Just $ C.paddingTop $ C.px 24.0
        , cssMedium = Just $ C.paddingTop $ C.px 150.0
        , cssLarge  = Just $ C.paddingTop $ C.px 150.0
        }
    , inner : defaultSectionInnerStyle
        { className = "sectionHeaderInner"
        , cssCommon = Just do
            C.marginLeft CC.auto
            C.marginRight CC.auto
            C.backgroundColor lightBackgroundColor
            C.color darkTextColor
            C.boxShadow C.nil C.nil (C.px 72.0) (C.rgba 0 0 0 0.8)
        }
    }

sectionStyleLinks :: SectionStyle
sectionStyleLinks = SectionStyle
    { outer : defaultStyle
        { className = "section-links"
        , cssCommon = Just do
            C.backgroundColor lightBackgroundColor
            CB.borderBottom CB.solid (C.px 36.0) lightBackgroundColor
        }
    , inner : defaultSectionInnerStyle
        { className = "section-links__inner"
        , cssCommon = Just do
            C.marginLeft CC.auto
            C.marginRight CC.auto
            C.paddingTop $ C.px 24.0
            C.paddingBottom $ C.px 24.0
            C.backgroundColor darkBackgroundColor
        }
    }

sectionStyleFooter :: SectionStyle
sectionStyleFooter = SectionStyle
    { outer : defaultStyle
        { className = "section-footer"
        , cssCommon = Just do
            C.backgroundColor darkBackgroundColor
            CB.borderTop CB.solid (C.px 36.0) lightBackgroundColor
        }
    , inner : defaultSectionInnerStyle
        { className = "section-footer__inner"
        , cssCommon = Just do
            C.marginLeft CC.auto
            C.marginRight CC.auto
            C.paddingTop $ C.px 36.0
            C.paddingBottom $ C.px 36.0
            C.backgroundColor darkBackgroundColor
            C.color lightTextColor
        }
    }

sectionStyleDefault :: SectionStyle
sectionStyleDefault = SectionStyle
    { outer : defaultStyle
        { className = "section"
        , cssCommon = Just $ C.backgroundColor lightBackgroundColor
        }
    , inner : defaultSectionInnerStyle
        { className = "section__inner"
        , cssCommon = Just do
            C.marginLeft CC.auto
            C.marginRight CC.auto
            C.paddingTop $ C.px 36.0
            C.paddingBottom $ C.px 36.0
            C.backgroundColor lightBackgroundColor
            C.color darkTextColor
        }
    }

section_ :: forall p i. Array (HH.HTML p i) -> HH.HTML p i
section_ = section sectionStyleDefault

section :: forall p i. SectionStyle -> Array (HH.HTML p i) -> HH.HTML p i
section (SectionStyle style) content =
    HH.div [ HP.class_ $ HH.className style.outer.className ]
        [ HH.div [ HP.class_ $ HH.className style.inner.className ]
            content
        ]


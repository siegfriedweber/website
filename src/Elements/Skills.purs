module Elements.Skills
    ( Skill
    , SkillSetStyle
    , skillSet
    , skillSet_
    , skillSetStyleDefault
    , skillSetStyles
    ) where

import Prelude
import Data.Maybe (Maybe(Just))

import CSS as C
import CSS.Common as CC
import CSS.ListStyle.Type as CL
import Halogen.HTML.CSS.Indexed as HC
import Halogen.HTML.Indexed as HH
import Halogen.HTML.Properties.Indexed as HP

import Elements.Colors (darkBackgroundColor)
import Elements.Types (Style, defaultStyle)
import Fonts (Font(SourceSansProLight, SourceSansProSemibold), styleFont)

type Skill =
    { name       :: String
    , expertise  :: String
    , percentage :: Number
    }

newtype SkillSetStyle = SkillSetStyle
    { list          :: Style
    , header        :: Style
    , name          :: Style
    , expertise     :: Style
    , barForeground :: Style
    , barBackground :: Style
    }

getStyles :: SkillSetStyle -> Array Style
getStyles (SkillSetStyle style) =
    [ style.list
    , style.header
    , style.name
    , style.expertise
    , style.barForeground
    , style.barBackground
    ]

skillSetStyles :: Array Style
skillSetStyles = getStyles skillSetStyleDefault

skillSetStyleDefault :: SkillSetStyle
skillSetStyleDefault = SkillSetStyle
    { list : defaultStyle
        { className = "skill-set"
        , cssCommon = Just do
            CL.listStyleType CC.none
            C.marginTop C.nil
            C.marginBottom C.nil
            C.paddingLeft C.nil
        }
    , header : defaultStyle
        { className = "skill-set__header"
        , cssCommon = Just do
            C.display C.flex
            C.justifyContent C.spaceBetween
            C.alignItems CC.baseline
            C.marginTop $ C.px 12.0
            C.marginBottom $ C.px 8.0
        }
    , name : defaultStyle
        { className = "skill-set__name"
        , cssCommon = Just do
            styleFont SourceSansProSemibold
            C.fontSize $ C.px 18.0
        }
    , expertise : defaultStyle
        { className = "skill-set__expertise"
        , cssCommon = Just do
            styleFont SourceSansProLight
            C.fontSize $ C.px 16.0
            C.color $ C.fromInt 0x404040
        }
    , barForeground : defaultStyle
        { className = "skill-set__bar-foreground"
        , cssCommon = Just do
            C.height $ C.px 8.0
            C.backgroundColor darkBackgroundColor
        }
    , barBackground : defaultStyle
        { className = "skill-set__bar-background"
        , cssCommon = Just $
            C.backgroundColor $ C.fromInt 0xa0a0a0
        }
    }

skillSet_ :: forall p i. Array Skill -> HH.HTML p i
skillSet_ = skillSet skillSetStyleDefault

skillSet :: forall p i. SkillSetStyle -> Array Skill -> HH.HTML p i
skillSet styles@(SkillSetStyle style) = map (skillBar styles)
                                    >>> map createListItem
                                    >>> createList
  where
    createListItem = HH.li_
    createList = HH.ul [ HP.class_ $ HH.className style.list.className ]

skillBar :: forall p i. SkillSetStyle -> Skill -> Array (HH.HTML p i)
skillBar styles@(SkillSetStyle style) skill =
    [ HH.h3
        [ HP.class_ $ HH.className style.header.className ]
        [ HH.span
            [ HP.class_ $ HH.className style.name.className ]
            [ HH.text skill.name ]
        , HH.span
            [ HP.class_ $ HH.className style.expertise.className ]
            [ HH.text skill.expertise ]
        ]
    , bar styles skill.percentage
    ]

bar :: forall p i. SkillSetStyle -> Number -> HH.HTML p i
bar (SkillSetStyle style) percentage = HH.div
    [ HP.class_ $ HH.className style.barBackground.className ]
    [ HH.div
        [ HP.class_ $ HH.className style.barForeground.className
        , HC.style $ C.width $ C.pct percentage
        ]
        []
    ]


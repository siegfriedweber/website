module Elements.Skills
    ( Skill
    , SkillSetStyle
    , skillSet
    , skillSet_
    , skillSetStyleDefault
    , skillSetStyles
    ) where

import Prelude
import Data.Array ((..))
import Data.Int (toNumber)
import Data.Maybe (Maybe(Just))

import CSS as C
import CSS.Border as CB
import CSS.Common as CC
import CSS.ListStyle.Type as CL
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP

import Elements.Colors (darkBackgroundColor)
import Elements.Types (Style, defaultStyle)
import Fonts (Font(SourceSansProSemibold), styleFont)

type Skill =
    { name      :: String
    , rating    :: Int
    }

newtype SkillSetStyle = SkillSetStyle
    { list          :: Style
    , name          :: Style
    , barForeground :: Style
    , barBackground :: Style
    }

getStyles :: SkillSetStyle -> Array Style
getStyles (SkillSetStyle style) =
    [ style.list
    , style.name
    , style.barForeground
    , style.barBackground
    ]

skillSetStyles :: Array Style
skillSetStyles = getStyles skillSetStyleDefault
              <> barWidthStyles

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
    , name : defaultStyle
        { className = "skill-set__name"
        , cssCommon = Just do
            styleFont SourceSansProSemibold
            C.fontSize $ C.px 18.0
            C.marginTop $ C.px 12.0
            C.marginBottom $ C.px 8.0
        }
    , barForeground : defaultStyle
        { className = "skill-set__bar-foreground"
        , cssScreen = Just do
            C.height $ C.px 8.0
            C.backgroundColor darkBackgroundColor
        , cssPrint  = Just $
            CB.borderTop CB.solid (C.px 8.0) C.black
        }
    , barBackground : defaultStyle
        { className = "skill-set__bar-background"
        , cssScreen = Just $
            C.backgroundColor $ C.fromInt 0xa0a0a0
        }
    }

barWidthStyles :: Array Style
barWidthStyles = 0 .. 10 <#> \rating ->
    defaultStyle
        { className = barWidthClassName rating
        , cssCommon = Just $ C.width $ C.pct $ toNumber $ rating * 10
        }

barWidthClassName :: Int -> String
barWidthClassName rating = "skill-set__bar-foreground--rating-" <> show rating

skillSet_ :: forall p i. Array Skill -> HH.HTML p i
skillSet_ = skillSet skillSetStyleDefault

skillSet :: forall p i. SkillSetStyle -> Array Skill -> HH.HTML p i
skillSet styles@(SkillSetStyle style) = map (skillBar styles)
                                    >>> map createListItem
                                    >>> createList
  where
    createListItem = HH.li_
    createList = HH.ul [ HP.class_ $ HH.ClassName style.list.className ]

skillBar :: forall p i. SkillSetStyle -> Skill -> Array (HH.HTML p i)
skillBar styles@(SkillSetStyle style) skill =
    [ HH.div
        [ HP.class_ $ HH.ClassName style.name.className ]
        [ HH.text skill.name ]
    , bar styles skill.rating
    ]

bar :: forall p i. SkillSetStyle -> Int -> HH.HTML p i
bar (SkillSetStyle style) rating = HH.div
    [ HP.class_ $ HH.ClassName style.barBackground.className ]
    [ HH.div
        [ HP.classes
            [ HH.ClassName style.barForeground.className
            , HH.ClassName $ barWidthClassName rating
            ]
        ]
        []
    ]


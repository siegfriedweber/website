module Elements
    ( module S
    , Box(Box)
    , Content(Text, Email)
    , Skill
    , allStyles
    , boxes
    , defaultBoxStyle
    , heading
    , heading_
    , inlineImage
    , inlineList
    , linkedIcon
    , paragraphs
    , paragraph
    , paragraph_
    , paragraph'
    , paragraph'_
    , skillSet
    , subHeading
    , styleElements
    ) where

import Prelude
import Control.Bind (bindFlipped)

import CSS as C
import CSS.Common as CC
import CSS.ListStyle.Type as CL
import CSS.Media as CM
import CSS.TextAlign as CT
import CSS.VerticalAlign as CV
import Data.Array (mapMaybe)
import Data.Foldable (sequence_)
import Data.Maybe(Maybe)
import Data.NonEmpty (NonEmpty, (:|), singleton)
import Data.String (Pattern(Pattern), split)
import Halogen.HTML.CSS.Indexed as HC
import Halogen.HTML.Indexed as HH
import Halogen.HTML.Properties.Indexed as HP

import Elements.Colors (darkBackgroundColor, lightTextColor)
import Elements.Section as S
import Elements.Types (Style)
import Foldable (intersperse)
import Fonts (Font(SourceSansProLight, SourceSansProSemibold), styleFont)

type HeadingStyle =
    { marginBottom :: Number
    }

allStyles :: Array Style
allStyles = S.sectionStyles

defaultHeadingStyle :: HeadingStyle
defaultHeadingStyle =
    { marginBottom : 36.0
    }

heading_ :: forall p i. String -> HH.HTML p i
heading_ = heading defaultHeadingStyle

heading :: forall p i. HeadingStyle -> String -> HH.HTML p i
heading style = textToHtml >>>
    HH.h1 [ HC.style do
              C.marginTop C.nil
              C.marginBottom $ C.px style.marginBottom
              C.fontSize $ C.px 30.0
              styleFont SourceSansProSemibold
          ]

subHeading :: forall p i. String -> HH.HTML p i
subHeading = textToHtml >>>
    HH.h2 [ HC.style do
              C.marginTop C.nil
              C.marginBottom $ C.px 36.0
              C.fontSize $ C.px 24.0
              styleFont SourceSansProSemibold
          ]

data Content = Text String | Email String

type ParagraphStyle =
    { marginBottom :: Number
    }

defaultParagraphStyle :: ParagraphStyle
defaultParagraphStyle =
    { marginBottom : 18.0
    }

paragraphs :: forall p i. Array (HH.HTML p i) -> HH.HTML p i
paragraphs = HH.div [ HC.style $ C.marginBottom $ C.px (- 18.0) ]

paragraph_ :: forall p i. String -> HH.HTML p i
paragraph_ = paragraph defaultParagraphStyle

paragraph :: forall p i. ParagraphStyle -> String -> HH.HTML p i
paragraph style = paragraph' style <<< pure <<< Text

paragraph'_ :: forall p i. Array Content -> HH.HTML p i
paragraph'_ = paragraph' defaultParagraphStyle

paragraph' :: forall p i. ParagraphStyle -> Array Content -> HH.HTML p i
paragraph' style = bindFlipped contentToHtml >>>
    HH.p [ HC.style do
             C.marginTop C.nil
             C.marginBottom $ C.px style.marginBottom
             C.fontSize $ C.px 18.0
             styleFont SourceSansProLight
         ]

contentToHtml :: forall p' i'. Content -> Array (HH.HTML p' i')
contentToHtml (Text s)  = textToHtml s
contentToHtml (Email e) =
    [ HH.a
        [ HP.href $ "mailto:" <> e
        , HC.style do
            C.color lightTextColor
            C.textDecoration C.noneTextDecoration
        ]
        [ HH.text e ]
    ]

textToHtml :: forall p i. String -> Array (HH.HTML p i)
textToHtml = intersperse HH.br_ <<< map HH.text <<< split (Pattern "\n")

inlineImage :: forall p i. String -> String -> HH.HTML p i
inlineImage alt src =
    HH.img [ HP.src src
           , HP.alt alt
           , HC.style do
               C.display C.inlineBlock
               CV.verticalAlign CV.Top
           ]

inlineList :: forall p i. Array (HH.HTML p i) -> HH.HTML p i
inlineList = wrapItems >>> createList
  where
    wrapItems =
        map $ HH.li [ HC.style $ C.display C.inlineBlock ] <<< pure

    createList =
        HH.ul [ HC.style do
                  CT.textAlign CT.center
                  CL.listStyleType CC.none
                  C.marginTop C.nil
                  C.marginBottom C.nil
                  C.paddingLeft C.nil
              ]

linkedIcon :: forall p i. String -> String -> String -> HH.HTML p i
linkedIcon name icon url =
    HH.a [ HP.href url
         , HC.style do
             C.paddingLeft $ C.px 12.0
             C.paddingRight $ C.px 12.0
         ]
         [ HH.img
            [ HP.src icon
            , HP.alt name
            , HC.style $ CV.verticalAlign CV.Top
            ]
        ]

type Skill =
    { name       :: String
    , desc       :: String
    , percentage :: Number
    }

skillSet :: forall p i. Array Skill -> HH.HTML p i
skillSet = map skillBar >>> map createListItem >>> createList
  where
    createListItem = HH.li_

    createList = HH.ul
        [ HC.style do
            CL.listStyleType CC.none
            C.marginTop C.nil
            C.marginBottom $ C.px 36.0
            C.paddingLeft C.nil
        ]

skillBar :: forall p i. Skill -> Array (HH.HTML p i)
skillBar skill =
    [ HH.h3
        [ HC.style do
            C.display C.flex
            C.justifyContent C.spaceBetween
            C.alignItems CC.baseline
            C.marginTop $ C.px 12.0
            C.marginBottom $ C.px 8.0
        ]
        [ HH.span
            [ HC.style do
                styleFont SourceSansProSemibold
                C.fontSize $ C.px 18.0
            ]
            [ HH.text skill.name ]
        , HH.span
            [ HC.style do
                styleFont SourceSansProLight
                C.fontSize $ C.px 16.0
                C.color $ C.fromInt 0x404040
            ]
            [ HH.text skill.desc ]
        ]
    , bar skill.percentage
    ]

bar :: forall p i. Number -> HH.HTML p i
bar percentage = HH.div
    [ HC.style $ C.backgroundColor $ C.fromInt 0xa0a0a0
    ]
    [ HH.div
        [ HC.style do
            C.height $ C.px 8.0
            C.width $ C.pct percentage
            C.backgroundColor darkBackgroundColor
        ]
        []
    ]

newtype Box p i = Box (Array (HH.HTML p i))

type BoxStyle =
    { width :: Number
    , horizontalSpace :: Number
    , verticalSpace :: Number
    }

defaultBoxStyle :: BoxStyle
defaultBoxStyle =
    { width : 444.0
    , horizontalSpace : 72.0
    , verticalSpace : 72.0
    }

boxes :: forall p i. BoxStyle -> Array (Box p i) -> HH.HTML p i
boxes style = map createBox >>>
    HH.div [ HC.style do
               C.display C.flex
               C.flexWrap C.wrap
               C.marginTop $ C.px (- verticalMargin)
               C.marginBottom $ C.px (- verticalMargin)
               C.marginLeft $ C.px (- horizontalMargin)
               C.marginRight $ C.px (- horizontalMargin)
           ]
  where
    horizontalMargin = style.horizontalSpace / 2.0
    verticalMargin = style.verticalSpace / 2.0

    createBox :: Box p i -> HH.HTML p i
    createBox (Box b) = HH.div
        [ HC.style do
            C.width $ C.px style.width
            C.marginTop $ C.px verticalMargin
            C.marginBottom $ C.px verticalMargin
            C.marginLeft $ C.px horizontalMargin
            C.marginRight $ C.px horizontalMargin
        ]
        b

type ClassCss =
    { className :: String
    , css       :: C.CSS
    }

styleElements :: C.CSS
styleElements = stylesToCss allStyles
  where
    stylesToCss :: Array Style -> C.CSS
    stylesToCss styles = do
        mediaCss allScreens   filterCommon styles
        mediaCss smallScreen  filterSmall  styles
        mediaCss mediumScreen filterMedium styles
        mediaCss largeScreen  filterLarge  styles

    mediaCss :: NonEmpty Array C.Feature
             -> (Style -> Maybe ClassCss)
             -> Array Style
             -> C.CSS
    mediaCss features filter = mapMaybe filter
        >>> map (\s -> C.select (classSelector s.className) s.css)
        >>> sequence_
        >>> C.query CM.screen features

    classSelector :: String -> C.Selector
    classSelector className =
        C.Selector (C.Refinement [C.Class className]) C.Star

    filterCommon :: Style -> Maybe ClassCss
    filterCommon style = createClassCss style.className style.cssCommon

    filterSmall :: Style -> Maybe ClassCss
    filterSmall style = createClassCss style.className style.cssSmall

    filterMedium :: Style -> Maybe ClassCss
    filterMedium style = createClassCss style.className style.cssMedium

    filterLarge :: Style -> Maybe ClassCss
    filterLarge style = createClassCss style.className style.cssLarge

    createClassCss :: String -> Maybe C.CSS -> Maybe ClassCss
    createClassCss className = map $ \css -> { className, css }

    allScreens :: NonEmpty Array C.Feature
    allScreens = singleton $ C.Feature "min-width" $ pure $ C.value $ C.px 0.0

    smallScreen :: NonEmpty Array C.Feature
    smallScreen = singleton $ C.Feature "max-width" $ pure $ C.value $ C.px 480.0

    mediumScreen :: NonEmpty Array C.Feature
    mediumScreen = (C.Feature "min-width" $ pure $ C.value $ C.px 481.0)
                :| [ C.Feature "max-width" $ pure $ C.value $ C.px 960.0 ]

    largeScreen :: NonEmpty Array C.Feature
    largeScreen = singleton $ C.Feature "min-width" $ pure $ C.value $ C.px 961.0


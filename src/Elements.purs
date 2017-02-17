module Elements
    ( module B
    , module S
    , module Skills
    , module Text
    , Content(Text, Email)
    , allStyles
    , inlineImage
    , inlineList
    , linkedIcon
    , paragraphs
    , paragraph
    , paragraph_
    , paragraph'
    , paragraph'_
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

import Elements.Box as B
import Elements.Colors (lightTextColor)
import Elements.Section as S
import Elements.Skills as Skills
import Elements.Text as Text
import Elements.Types (Style)
import Foldable (intersperse)
import Fonts (Font(SourceSansProLight, SourceSansProSemibold), styleFont)

type HeadingStyle =
    { marginBottom :: Number
    }

allStyles :: Array Style
allStyles = S.sectionStyles
         <> B.boxStyles
         <> Skills.skillSetStyles
         <> Text.textStyles

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


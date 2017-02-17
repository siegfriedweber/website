module Elements
    ( module B
    , module Icon
    , module Image
    , module List
    , module S
    , module Skills
    , module Text
    , styleElements
    ) where

import Prelude

import CSS as C
import CSS.Media as CM
import Data.Array (mapMaybe)
import Data.Foldable (sequence_)
import Data.Maybe(Maybe)
import Data.NonEmpty (NonEmpty, (:|), singleton)

import Elements.Box as B
import Elements.Icon as Icon
import Elements.Image as Image
import Elements.List as List
import Elements.Section as S
import Elements.Skills as Skills
import Elements.Text as Text
import Elements.Types (Style)

type ClassCss =
    { className :: String
    , css       :: C.CSS
    }

styleElements :: C.CSS
styleElements = stylesToCss allStyles
  where
    allStyles :: Array Style
    allStyles = S.sectionStyles
             <> B.boxStyles
             <> Icon.iconStyles
             <> Image.imageStyles
             <> List.listStyles
             <> Skills.skillSetStyles
             <> Text.textStyles

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


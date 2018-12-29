module Elements
    ( styleElements
    ) where

import Prelude
import Data.Array (mapMaybe)
import Data.Foldable (sequence_)
import Data.Maybe(Maybe)
import Data.NonEmpty (NonEmpty, (:|), singleton)

import CSS as C
import CSS.Media as CM

import Elements.Box (boxStyles)
import Elements.Icon (iconStyles)
import Elements.Image (imageStyles)
import Elements.List (listStyles)
import Elements.Section (sectionStyles)
import Elements.Skills (skillSetStyles)
import Elements.Text (textStyles)
import Elements.Types (Style)

type ClassCss =
    { className :: String
    , css       :: C.CSS
    }

styleElements :: C.CSS
styleElements = stylesToCss allStyles
  where
    allStyles :: Array Style
    allStyles = boxStyles
             <> iconStyles
             <> imageStyles
             <> listStyles
             <> skillSetStyles
             <> sectionStyles
             <> textStyles

    stylesToCss :: Array Style -> C.CSS
    stylesToCss styles = do
        mediaCss CM.screen      all          filterCommon styles
        mediaCss CM.screen      all          filterScreen styles
        mediaCss CM.screen      smallScreen  filterSmall  styles
        mediaCss CM.screen      mediumScreen filterMedium styles
        mediaCss CM.screen      largeScreen  filterLarge  styles
        mediaCss mediaTypePrint all          filterCommon styles
        mediaCss mediaTypePrint all          filterPrint  styles

    mediaTypePrint :: C.MediaType
    mediaTypePrint = C.MediaType $ C.fromString "print"

    mediaCss :: C.MediaType
             -> NonEmpty Array C.Feature
             -> (Style -> Maybe ClassCss)
             -> Array Style
             -> C.CSS
    mediaCss mediaType features filter = mapMaybe filter
        >>> map (\s -> C.select (classSelector s.className) s.css)
        >>> sequence_
        >>> C.query mediaType features

    classSelector :: String -> C.Selector
    classSelector className =
        C.Selector (C.Refinement [C.Class className]) C.Star

    filterCommon :: Style -> Maybe ClassCss
    filterCommon style = createClassCss style.className style.cssCommon

    filterScreen :: Style -> Maybe ClassCss
    filterScreen style = createClassCss style.className style.cssScreen

    filterSmall :: Style -> Maybe ClassCss
    filterSmall style = createClassCss style.className style.cssSmall

    filterMedium :: Style -> Maybe ClassCss
    filterMedium style = createClassCss style.className style.cssMedium

    filterLarge :: Style -> Maybe ClassCss
    filterLarge style = createClassCss style.className style.cssLarge

    filterPrint :: Style -> Maybe ClassCss
    filterPrint style = createClassCss style.className style.cssPrint

    createClassCss :: String -> Maybe C.CSS -> Maybe ClassCss
    createClassCss className = map $ \css -> { className, css }

    all :: NonEmpty Array C.Feature
    all = singleton $ C.Feature "min-width" $ pure $ C.value $ C.px 0.0

    smallScreen :: NonEmpty Array C.Feature
    smallScreen = singleton $ C.Feature "max-width" $ pure $ C.value $ C.px 480.0

    mediumScreen :: NonEmpty Array C.Feature
    mediumScreen = (C.Feature "min-width" $ pure $ C.value $ C.px 481.0)
                :| [ C.Feature "max-width" $ pure $ C.value $ C.px 960.0 ]

    largeScreen :: NonEmpty Array C.Feature
    largeScreen = singleton $ C.Feature "min-width" $ pure $ C.value $ C.px 961.0


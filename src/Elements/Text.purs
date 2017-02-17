module Elements.Text
    ( HeadingStyle
    , SubheadingStyle
    , heading
    , heading_
    , headingStyleDefault
    , headingStyleSmallMargin
    , subheading
    , subheading_
    , subheadingStyleDefault
    , textStyles
    ) where

import Prelude
import Data.Maybe(Maybe(Just))

import CSS as C
import Halogen.HTML.Indexed as HH
import Halogen.HTML.Properties.Indexed as HP

import Elements.Types (Style, defaultStyle)
import Fonts (Font(SourceSansProSemibold), styleFont)

textStyles :: Array Style
textStyles = getHeadingStyles headingStyleDefault
          <> getHeadingStyles headingStyleSmallMargin
          <> getSubheadingStyles subheadingStyleDefault

newtype HeadingStyle = HeadingStyle Style

getHeadingStyles :: HeadingStyle -> Array Style
getHeadingStyles (HeadingStyle style) = [ style ]

headingStyleDefault :: HeadingStyle
headingStyleDefault = headingStyle 36.0

headingStyleSmallMargin :: HeadingStyle
headingStyleSmallMargin = headingStyle 24.0

headingStyle :: Number -> HeadingStyle
headingStyle marginBottom = HeadingStyle defaultStyle
    { className = "heading"
    , cssCommon = Just do
        C.marginTop C.nil
        C.marginBottom $ C.px marginBottom
        C.fontSize $ C.px 30.0
        styleFont SourceSansProSemibold
    }

heading_ :: forall p i. String -> HH.HTML p i
heading_ = heading headingStyleDefault

heading :: forall p i. HeadingStyle -> String -> HH.HTML p i
heading (HeadingStyle style) =
    HH.h1 [ HP.class_ $ HH.className style.className ] <<< pure <<< HH.text

newtype SubheadingStyle = SubheadingStyle Style

getSubheadingStyles :: SubheadingStyle -> Array Style
getSubheadingStyles (SubheadingStyle style) = [ style ]

subheadingStyleDefault :: SubheadingStyle
subheadingStyleDefault = SubheadingStyle defaultStyle
    { className = "subheading"
    , cssCommon = Just do
        C.marginTop C.nil
        C.marginBottom $ C.px 36.0
        C.fontSize $ C.px 24.0
        styleFont SourceSansProSemibold
    }

subheading_ :: forall p i. String -> HH.HTML p i
subheading_ = subheading subheadingStyleDefault

subheading :: forall p i. SubheadingStyle -> String -> HH.HTML p i
subheading (SubheadingStyle style) =
    HH.h2 [ HP.class_ $ HH.className style.className ] <<< pure <<< HH.text


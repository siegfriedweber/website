module Elements.Text
    ( HeadingStyle
    , LinkStyle
    , ParagraphStyle
    , SubheadingStyle
    , email
    , email_
    , heading
    , heading_
    , headingStyleDefault
    , headingStyleSmallMargin
    , link
    , link_
    , linkStyleDefault
    , paragraph
    , paragraph_
    , paragraphStyleDefault
    , paragraphStyleNoMargin
    , subheading
    , subheading_
    , subheadingStyleDefault
    , text
    , textStyles
    ) where

import Prelude
import Data.Maybe (Maybe(Just))
import Data.String (Pattern(Pattern), split)

import CSS as C
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP

import Elements.Colors (lightTextColor)
import Elements.Types (Style, defaultStyle)
import Foldable (intersperse)
import Fonts (Font(SourceSansProLight, SourceSansProSemibold), styleFont)

textStyles :: Array Style
textStyles = getHeadingStyles headingStyleDefault
          <> getHeadingStyles headingStyleSmallMargin
          <> getSubheadingStyles subheadingStyleDefault
          <> getParagraphStyles paragraphStyleDefault
          <> getParagraphStyles paragraphStyleNoMargin
          <> getLinkStyles linkStyleDefault

newtype HeadingStyle = HeadingStyle Style

getHeadingStyles :: HeadingStyle -> Array Style
getHeadingStyles (HeadingStyle style) = [ style ]

headingStyleDefault :: HeadingStyle
headingStyleDefault = headingStyle
    { className : "heading"
    , marginBottomScreen : 36.0
    , marginBottomPrint : 18.0
    }

headingStyleSmallMargin :: HeadingStyle
headingStyleSmallMargin = headingStyle
    { className : "heading-small-margin"
    , marginBottomScreen : 9.0
    , marginBottomPrint : 9.0
    }

headingStyle :: { className          :: String
                , marginBottomScreen :: Number
                , marginBottomPrint  :: Number
                }
             -> HeadingStyle
headingStyle params =
    HeadingStyle defaultStyle
        { className = params.className
        , cssCommon = Just do
            C.marginTop C.nil
            C.fontSize $ C.px 30.0
            styleFont SourceSansProSemibold
        , cssScreen = Just $
            C.marginBottom $ C.px params.marginBottomScreen
        , cssPrint  = Just $
            C.marginBottom $ C.px params.marginBottomPrint
        }

heading_ :: forall p i. String -> HH.HTML p i
heading_ = heading headingStyleDefault

heading :: forall p i. HeadingStyle -> String -> HH.HTML p i
heading (HeadingStyle style) =
    HH.h1 [ HP.class_ $ HH.ClassName style.className ] <<< pure <<< HH.text

newtype SubheadingStyle = SubheadingStyle Style

getSubheadingStyles :: SubheadingStyle -> Array Style
getSubheadingStyles (SubheadingStyle style) = [ style ]

subheadingStyleDefault :: SubheadingStyle
subheadingStyleDefault = SubheadingStyle defaultStyle
    { className = "subheading"
    , cssCommon = Just do
        C.marginTop C.nil
        C.fontSize $ C.px 24.0
        styleFont SourceSansProSemibold
    , cssScreen = Just $
        C.marginBottom $ C.px 36.0
    , cssPrint  = Just $
        C.marginBottom $ C.px 18.0
    }

subheading_ :: forall p i. String -> HH.HTML p i
subheading_ = subheading subheadingStyleDefault

subheading :: forall p i. SubheadingStyle -> String -> HH.HTML p i
subheading (SubheadingStyle style) =
    HH.h2 [ HP.class_ $ HH.ClassName style.className ] <<< pure <<< HH.text

newtype ParagraphStyle = ParagraphStyle Style

getParagraphStyles :: ParagraphStyle -> Array Style
getParagraphStyles (ParagraphStyle style) = [ style ]

paragraphStyleDefault :: ParagraphStyle
paragraphStyleDefault = paragraphStyle "paragraph" 18.0

paragraphStyleNoMargin :: ParagraphStyle
paragraphStyleNoMargin = paragraphStyle "paragraph-no-margin" 0.0

paragraphStyle :: String -> Number -> ParagraphStyle
paragraphStyle className marginBottom = ParagraphStyle defaultStyle
    { className = className
    , cssCommon = Just do
        C.marginTop C.nil
        C.marginBottom $ C.px marginBottom
        C.fontSize $ C.px 18.0
        styleFont SourceSansProLight
    }

paragraph_ :: forall p i. Array (HH.HTML p i) -> HH.HTML p i
paragraph_ = paragraph paragraphStyleDefault

paragraph :: forall p i. ParagraphStyle -> Array (HH.HTML p i) -> HH.HTML p i
paragraph (ParagraphStyle style) =
    HH.p [ HP.class_ $ HH.ClassName style.className ]

text :: forall p i. String -> Array (HH.HTML p i)
text = intersperse HH.br_ <<< map HH.text <<< split (Pattern "\n")

newtype LinkStyle = LinkStyle Style

getLinkStyles :: LinkStyle -> Array Style
getLinkStyles (LinkStyle style) = [ style ]

linkStyleDefault :: LinkStyle
linkStyleDefault = LinkStyle defaultStyle
    { className = "link"
    , cssCommon = Just $
        C.textDecoration C.noneTextDecoration
    , cssScreen = Just $
        C.color lightTextColor -- TODO change to inherit
    , cssPrint  = Just $
        C.color C.black
    }

link_ :: forall p i. String
                  -> Array (HH.HTML p i)
                  -> Array (HH.HTML p i)
link_ = link linkStyleDefault

link :: forall p i. LinkStyle
                 -> String
                 -> Array (HH.HTML p i)
                 -> Array (HH.HTML p i)
link (LinkStyle style) ref = pure <<<
    HH.a [ HP.href ref, HP.class_ $ HH.ClassName style.className ]

email_ :: forall p i. String -> Array (HH.HTML p i)
email_ = email linkStyleDefault

email :: forall p i. LinkStyle -> String -> Array (HH.HTML p i)
email style ref = link style ("mailto:" <> ref) $ text ref


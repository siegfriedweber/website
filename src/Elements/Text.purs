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
    , linkStyleNoDecoration
    , paragraph
    , paragraph_
    , paragraphStyleDefault
    , paragraphStyleNoMargin
    , phone
    , phone_
    , subheading
    , subheading_
    , subheadingStyleDefault
    , text
    , textStyles
    ) where

import Prelude
import Data.Maybe (Maybe(Just))
import Data.Newtype (class Newtype, unwrap)
import Data.String (Pattern(Pattern), Replacement(Replacement), replaceAll, split)

import CSS as C
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP

import Elements.Types (Style, defaultStyle)
import Foldable (intersperse)
import Fonts (Font(MontserratRegular, SourceSansProLight), styleFont)

textStyles :: Array Style
textStyles =
    [ unwrap headingStyleDefault
    , unwrap headingStyleSmallMargin
    , unwrap subheadingStyleDefault
    , unwrap paragraphStyleDefault
    , unwrap paragraphStyleNoMargin
    , unwrap linkStyleDefault
    , unwrap linkStyleNoDecoration
    ]

newtype HeadingStyle = HeadingStyle Style
derive instance newtypeHeadingStyle :: Newtype HeadingStyle _

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
            C.letterSpacing $ C.em (-0.01)
            styleFont MontserratRegular
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

derive instance newtypeSubheadingStyle :: Newtype SubheadingStyle _

subheadingStyleDefault :: SubheadingStyle
subheadingStyleDefault = SubheadingStyle defaultStyle
    { className = "subheading"
    , cssCommon = Just do
        C.marginTop C.nil
        C.fontSize $ C.px 24.0
        styleFont MontserratRegular
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

derive instance newtypeParagraphStyle :: Newtype ParagraphStyle _

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
        C.fontSize $ C.px 19.0
        C.lineHeight $ C.Size $ C.value 1.4
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

derive instance newtypeLinkStyle :: Newtype LinkStyle _

linkStyleDefault :: LinkStyle
linkStyleDefault = LinkStyle defaultStyle
    { className = "link"
    , cssScreen = Just $
        C.key (C.fromString "color") "inherit"
    , cssPrint  = Just $
        C.color C.black
    }

linkStyleNoDecoration :: LinkStyle
linkStyleNoDecoration = LinkStyle defaultStyle
    { className = "link-no-decoration"
    , cssCommon = Just $
        C.textDecoration C.noneTextDecoration
    , cssScreen = Just $
        C.key (C.fromString "color") "inherit"
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

phone_ :: forall p i. String -> Array (HH.HTML p i)
phone_ = phone linkStyleNoDecoration

phone :: forall p i. LinkStyle -> String -> Array (HH.HTML p i)
phone style ref = link style ("tel:" <> uri) $ text ref
  where
    uri = replaceAll (Pattern " ") (Replacement "") ref

email_ :: forall p i. String -> Array (HH.HTML p i)
email_ = email linkStyleNoDecoration

email :: forall p i. LinkStyle -> String -> Array (HH.HTML p i)
email style ref = link style ("mailto:" <> ref) $ text ref


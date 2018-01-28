module Fonts
    ( Font(..)
    , styleFont
    , styleFontFaces
    ) where

import Prelude
import Data.NonEmpty ((:|), singleton)

import CSS as C

data Font = MontserratRegular
          | SourceSansProLight
          | SourceSansProSemibold

type FontFace =
    { name   :: String
    , family :: String
    , weight :: C.FontWeight
    , files  :: Array FontFile
    }

type FontFile =
    { filename :: String
    , format   :: C.FontFaceFormat
    }

fontFace :: Font -> FontFace
fontFace MontserratRegular =
    { name   : "Montserrat Regular"
    , family : "Montserrat"
    , weight : toFontWeight "400"
    , files  : [ { filename: "fonts/Montserrat-Regular.woff"
                 , format: C.WOFF
                 }
               ]
    }
fontFace SourceSansProLight =
    { name   : "Source Sans Pro Light"
    , family : "Source Sans Pro"
    , weight : toFontWeight "300"
    , files  : [ { filename: "fonts/SourceSansPro-Light.otf.woff"
                 , format: C.WOFF
                 }
               ]
    }
fontFace SourceSansProSemibold =
    { name   : "Source Sans Pro Semibold"
    , family : "Source Sans Pro"
    , weight : toFontWeight "600"
    , files  : [ { filename: "fonts/SourceSansPro-Semibold.otf.woff"
                 , format: C.WOFF
                 }
               ]
    }

toFontWeight :: String -> C.FontWeight
toFontWeight = C.FontWeight <<< C.fromString

styleFont :: Font -> C.CSS
styleFont = fontFace >>> \font -> do
    C.fontFamily [ font.family ] $ singleton C.sansSerif
    C.fontWeight font.weight

styleFontFaces :: C.CSS
styleFontFaces = do
    createFontFace MontserratRegular
    createFontFace SourceSansProLight
    createFontFace SourceSansProSemibold
  where
    createFontFace = fontFace >>> \font -> C.fontFace do
        C.fontFaceFamily font.family
        C.fontWeight font.weight
        C.fontFaceSrc $ C.FontFaceSrcLocal font.name :| createSrcUrls font.files

    createSrcUrls = map \file -> C.FontFaceSrcUrl file.filename $ pure file.format


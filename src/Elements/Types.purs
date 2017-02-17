module Elements.Types
    ( Style
    , defaultStyle
    ) where

import Data.Maybe (Maybe(Nothing))

import CSS as C

type Style =
    { className :: String
    , cssCommon :: Maybe C.CSS
    , cssSmall  :: Maybe C.CSS
    , cssMedium :: Maybe C.CSS
    , cssLarge  :: Maybe C.CSS
    }

defaultStyle :: Style
defaultStyle =
    { className : ""
    , cssCommon : Nothing
    , cssSmall  : Nothing
    , cssMedium : Nothing
    , cssLarge  : Nothing
    }


module Elements.Colors
    ( darkBackgroundColor
    , darkTextColor
    , lightBackgroundColor
    , lightTextColor
    ) where

import CSS as C

lightBackgroundColor :: C.Color
lightBackgroundColor = C.fromInt 0xf1f1f1

darkBackgroundColor :: C.Color
darkBackgroundColor = C.fromInt 0x002b36

lightTextColor :: C.Color
lightTextColor = C.white

darkTextColor :: C.Color
darkTextColor = C.black


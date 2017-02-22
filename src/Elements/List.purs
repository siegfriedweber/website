module Elements.List
    ( ListStyle
    , list
    , listStyleInline
    , listStyles
    ) where

import Prelude
import Data.Maybe (Maybe(Just))

import CSS as C
import CSS.Common as CC
import CSS.ListStyle.Type as CL
import CSS.TextAlign as CT
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP

import Elements.Types (Style, defaultStyle)

listStyles :: Array Style
listStyles = getListStyles listStyleInline

newtype ListStyle = ListStyle
    { list :: Style
    , item :: Style
    }

getListStyles :: ListStyle -> Array Style
getListStyles (ListStyle styles) =
    [ styles.list
    , styles.item
    ]

listStyleInline :: ListStyle
listStyleInline = ListStyle
    { list : defaultStyle
        { className = "list-inline"
        , cssCommon = Just do
            CT.textAlign CT.center
            CL.listStyleType CC.none
            C.marginTop $ C.px (-9.0)
            C.marginBottom $ C.px (-9.0)
            C.paddingLeft C.nil
        }
    , item : defaultStyle
        { className = "list-inline__item"
        , cssCommon = Just do
            C.display C.inlineBlock
            C.marginTop $ C.px 9.0
            C.marginBottom $ C.px 9.0
        }
    }

list :: forall p i. ListStyle -> Array (HH.HTML p i) -> HH.HTML p i
list (ListStyle styles) = createList <<< wrapItems
  where
    createList = HH.ul [ HP.class_ $ HH.ClassName styles.list.className ]

    wrapItems = map $
        HH.li [ HP.class_ $ HH.ClassName styles.item.className ] <<< pure


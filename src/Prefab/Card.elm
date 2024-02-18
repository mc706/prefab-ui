module Prefab.Card exposing (view)

{-| A card is a container with a white background, a rounded border, and a shadow.


# Card

@docs view

-}

import Element exposing (Attribute, Element, el)
import Element.Background as Background
import Element.Border as Border
import Theme


baseAttrs : List (Attribute msg)
baseAttrs =
    [ Background.color Theme.white
    , Border.rounded 15
    , Border.color Theme.gray4
    , Border.width 1
    , Border.shadow { offset = ( 1, 2 ), size = 1, blur = 0.5, color = Theme.gray4 }
    ]


{-| A card is a container with a white background, a rounded border, and a shadow.
-}
view : List (Attribute msg) -> Element msg -> Element msg
view extraAttrs =
    el (baseAttrs ++ extraAttrs)

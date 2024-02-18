module Prefab.Loader exposing (..)

{-| A loader component.


# Loader

@docs view

-}

import Element exposing (Attribute, Element, el, text)


{-| The loader component.
-}
view : List (Attribute msg) -> Element msg
view attrs =
    el [] <| text "..."

module Prefab.Icon exposing (icon)

{-| A simple icon component that wraps the `FontAwesome` module.


# Icon

@docs icon

-}

import Element exposing (Attribute, Element, el)
import FontAwesome as Icon exposing (Icon)


{-| Create an icon with the given name and attributes.
-}
icon : List (Attribute msg) -> Icon hasId -> Element msg
icon attrs name =
    el attrs <| Element.html <| Icon.view name

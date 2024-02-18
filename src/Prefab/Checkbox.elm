module Prefab.Checkbox exposing (view)

{-| A checkbox with a label to the right of the checkbox.


# Checkbox

@docs view

-}

import Element exposing (Attribute, Element, text)
import Element.Input as Input


baseAttrs : List (Attribute msg)
baseAttrs =
    []


{-| A checkbox with a label to the right of the checkbox.
-}
view : List (Attribute msg) -> { onChange : Bool -> msg, checked : Bool, label : String } -> Element msg
view attrs { onChange, checked, label } =
    Input.checkbox (baseAttrs ++ attrs)
        { onChange = onChange
        , checked = checked
        , icon = Input.defaultCheckbox
        , label = Input.labelRight [] <| text label
        }

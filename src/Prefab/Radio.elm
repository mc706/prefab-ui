module Prefab.Radio exposing
    ( new, view
    , withArrangement, withOptions, withSerializer
    , Arrangement(..)
    )

{-| A radio button group.


# Creating

@docs new, view


# Modifying

@docs withArrangement, withOptions, withSerializer


# Types

@docs Arrangement

-}

import Element exposing (Attribute, Element, el, text)
import Element.Input as Input


baseAttributes : List (Attribute msg)
baseAttributes =
    []


{-| The arrangement of the radio buttons.
-}
type Arrangement
    = Horizontal
    | Vertical


type Radio a msg
    = Settings
        { label : String
        , onChange : a -> msg
        , arrangement : Arrangement
        , options : List a
        , serializer : a -> String
        , selected : Maybe a
        }


{-| Create a new radio button group.
-}
new : { label : String, onChange : a -> msg, selected : Maybe a } -> Radio a msg
new settings =
    Settings
        { label = settings.label
        , onChange = settings.onChange
        , arrangement = Horizontal
        , options = []
        , serializer = \_ -> ""
        , selected = settings.selected
        }


{-| Change the arrangement of the radio buttons.
-}
withArrangement : Arrangement -> Radio a msg -> Radio a msg
withArrangement arrangement (Settings settings) =
    Settings { settings | arrangement = arrangement }


{-| Change the options of the radio buttons.
-}
withOptions : List a -> Radio a msg -> Radio a msg
withOptions options (Settings settings) =
    Settings { settings | options = options }


{-| Change the serializer of the radio buttons.
-}
withSerializer : (a -> String) -> Radio a msg -> Radio a msg
withSerializer serializer (Settings settings) =
    Settings { settings | serializer = serializer }


{-| View the radio button group.
-}
view : List (Attribute msg) -> Radio a msg -> Element msg
view attrs ((Settings settings) as radioSettings) =
    case settings.arrangement of
        Horizontal ->
            Input.radio
                (baseAttributes ++ attrs)
                { onChange = settings.onChange
                , options = settings.options |> List.map (\option -> Input.option option (el [] <| text <| settings.serializer option))
                , selected = settings.selected
                , label = Input.labelRight [] <| el [] <| text settings.label
                }

        Vertical ->
            Input.radioRow
                (baseAttributes ++ attrs)
                { onChange = settings.onChange
                , options = settings.options |> List.map (\option -> Input.option option (el [] <| text <| settings.serializer option))
                , selected = settings.selected
                , label = Input.labelRight [] <| el [] <| text settings.label
                }

module Prefab.Radio exposing
    ( new, view
    , withLayout, withOptions, withSerializer, withMessage, withDisabled
    , Layout(..)
    )

{-| A radio button group.


# Creating

@docs new, view


# Modifying

@docs withLayout, withOptions, withSerializer, withMessage, withDisabled


# Types

@docs Layout

-}

import Element exposing (Attribute, Element, column, el, none, px, row, spacing, text, width)
import Element.Input as Input
import Prefab.Text as Text


baseAttributes : List (Attribute msg)
baseAttributes =
    [ spacing 4 ]


{-| The arrangement of the radio buttons.
-}
type Layout
    = Vertical
    | VerticalInline
    | Horizontal
    | HorizontalInline
    | Compact


type Radio a msg
    = Settings
        { label : String
        , onChange : a -> msg
        , layout : Layout
        , options : List a
        , serializer : a -> String
        , selected : Maybe a
        , message : Maybe String
        , disabled : Bool
        }


{-| Create a new radio button group.
-}
new : { label : String, onChange : a -> msg, selected : Maybe a } -> Radio a msg
new settings =
    Settings
        { label = settings.label
        , onChange = settings.onChange
        , layout = Vertical
        , options = []
        , serializer = \_ -> ""
        , selected = settings.selected
        , message = Nothing
        , disabled = False
        }


{-| Change the arrangement of the radio buttons.
-}
withLayout : Layout -> Radio a msg -> Radio a msg
withLayout layout (Settings settings) =
    Settings { settings | layout = layout }


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


{-| Add a help message of the radio buttons.
-}
withMessage : String -> Radio a msg -> Radio a msg
withMessage message (Settings settings) =
    Settings { settings | message = Just message }


{-| Disable the radio buttons.
-}
withDisabled : Bool -> Radio a msg -> Radio a msg
withDisabled disabled (Settings settings) =
    Settings { settings | disabled = disabled }


{-| View the radio button group.
-}
view : List (Attribute msg) -> Radio a msg -> Element msg
view attrs ((Settings settings) as radioSettings) =
    case settings.layout of
        Horizontal ->
            row baseAttributes
                [ Text.label [ width <| px 70 ] settings.label
                , column [ spacing 4 ]
                    [ Input.radio
                        []
                        { onChange = settings.onChange
                        , options = settings.options |> List.map (\option -> Input.option option (Text.form [] <| settings.serializer option))
                        , selected = settings.selected
                        , label = Input.labelHidden settings.label
                        }
                    , settings.message |> Maybe.map (\msg -> Text.helpText [] msg) |> Maybe.withDefault none
                    ]
                ]

        HorizontalInline ->
            row (baseAttributes ++ attrs)
                [ Text.label [ width <| px 70 ] settings.label
                , column [ spacing 4 ]
                    [ Input.radioRow
                        [ spacing 12 ]
                        { onChange = settings.onChange
                        , options = settings.options |> List.map (\option -> Input.option option (Text.form [] <| settings.serializer option))
                        , selected = settings.selected
                        , label = Input.labelHidden settings.label
                        }
                    , settings.message |> Maybe.map (\msg -> Text.helpText [] msg) |> Maybe.withDefault none
                    ]
                ]

        Vertical ->
            column (baseAttributes ++ attrs)
                [ Text.label [] settings.label
                , Input.radio
                    []
                    { onChange = settings.onChange
                    , options = settings.options |> List.map (\option -> Input.option option (Text.form [] <| settings.serializer option))
                    , selected = settings.selected
                    , label = Input.labelHidden settings.label
                    }
                , settings.message |> Maybe.map (\msg -> Text.helpText [] msg) |> Maybe.withDefault none
                ]

        VerticalInline ->
            column (baseAttributes ++ attrs)
                [ Text.label [] settings.label
                , Input.radioRow
                    [ spacing 12 ]
                    { onChange = settings.onChange
                    , options = settings.options |> List.map (\option -> Input.option option (Text.form [] <| settings.serializer option))
                    , selected = settings.selected
                    , label = Input.labelHidden settings.label
                    }
                , settings.message |> Maybe.map (\msg -> Text.helpText [] msg) |> Maybe.withDefault none
                ]

        Compact ->
            row (baseAttributes ++ attrs)
                [ Text.label [ width <| px 70 ] settings.label
                , Input.radioRow
                    [ spacing 12 ]
                    { onChange = settings.onChange
                    , options = settings.options |> List.map (\option -> Input.option option (Text.form [] <| settings.serializer option))
                    , selected = settings.selected
                    , label = Input.labelHidden settings.label
                    }
                , settings.message |> Maybe.map (\msg -> Text.helpText [] msg) |> Maybe.withDefault none
                ]

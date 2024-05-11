module Prefab.Radio exposing
    ( new, view
    , withLayout, withOptions, withSerializer, withMessage, withDisabled, withDefaultButton, withCustomButton
    , Layout(..)
    )

{-| A radio button group.


# Creating

@docs new, view


# Modifying

@docs withLayout, withOptions, withSerializer, withMessage, withDisabled, withDefaultButton, withCustomButton


# Types

@docs Layout

-}

import Element exposing (Attribute, Element, centerY, column, el, height, none, px, row, spacing, text, width)
import Element.Border as Border
import Element.Input as Input exposing (Option, OptionState(..))
import Prefab.Text as Text
import Theme


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


type DotRender msg
    = Clarity
    | Browser
    | Custom (OptionState -> Element msg)


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
        , dotRenderer : DotRender msg
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
        , dotRenderer = Clarity
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


{-| Use default broswer button
-}
withDefaultButton : Radio a msg -> Radio a msg
withDefaultButton (Settings settings) =
    Settings { settings | dotRenderer = Browser }


{-| Use custom button
-}
withCustomButton : (OptionState -> Element msg) -> Radio a msg -> Radio a msg
withCustomButton custom (Settings settings) =
    Settings { settings | dotRenderer = Custom custom }


makeClarityOption : (a -> String) -> a -> Option a msg
makeClarityOption serializer value =
    let
        renderDot : OptionState -> Element msg
        renderDot state =
            case state of
                Idle ->
                    el
                        [ Border.width 1
                        , Border.rounded 14
                        , height <| px 14
                        , width <| px 14
                        , Border.color Theme.gray7
                        , centerY
                        ]
                        none

                Focused ->
                    el
                        [ Border.width 1
                        , Border.rounded 14
                        , height <| px 14
                        , width <| px 14
                        , Border.color Theme.gray7
                        , centerY
                        ]
                        none

                Selected ->
                    el
                        [ Border.width 5
                        , Border.rounded 14
                        , height <| px 14
                        , width <| px 14
                        , Border.color Theme.primary
                        , centerY
                        ]
                        none

        render : OptionState -> Element msg
        render state =
            row [ spacing 12 ] [ renderDot state, Text.form [ centerY ] <| serializer value ]
    in
    Input.optionWith value render


makeBrowserOption : (a -> String) -> a -> Option a msg
makeBrowserOption serializer value =
    Input.option value <| Text.form [ centerY ] <| serializer value


makeCustomOption : (OptionState -> Element msg) -> (a -> String) -> a -> Option a msg
makeCustomOption custom serializer value =
    Input.optionWith value (\state -> row [ spacing 12 ] [ custom state, Text.form [ centerY ] <| serializer value ])


{-| View the radio button group.
-}
view : List (Attribute msg) -> Radio a msg -> Element msg
view attrs ((Settings settings) as radioSettings) =
    let
        optionMaker =
            case settings.dotRenderer of
                Clarity ->
                    makeClarityOption settings.serializer

                Browser ->
                    makeBrowserOption settings.serializer

                Custom custom ->
                    makeCustomOption custom settings.serializer
    in
    case settings.layout of
        Horizontal ->
            row (baseAttributes ++ attrs)
                [ Text.label [ width <| px 70 ] settings.label
                , column [ spacing 4 ]
                    [ Input.radio
                        []
                        { onChange = settings.onChange
                        , options = settings.options |> List.map optionMaker
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
                        , options = settings.options |> List.map optionMaker
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
                    , options = settings.options |> List.map optionMaker
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
                    , options = settings.options |> List.map optionMaker
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
                    , options = settings.options |> List.map optionMaker
                    , selected = settings.selected
                    , label = Input.labelHidden settings.label
                    }
                , settings.message |> Maybe.map (\msg -> Text.helpText [] msg) |> Maybe.withDefault none
                ]

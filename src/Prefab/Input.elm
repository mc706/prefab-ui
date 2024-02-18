module Prefab.Input exposing
    ( new, view
    , withDisabled, withError, withHelpText, withInputType, withLayout, withOnEnter, withPlaceholder, withRequired, withSpellCheck
    , InputType(..), Layout(..)
    )

{-| Text Inputs


# Creating

@docs new, view


# Modifying

@docs withDisabled, withError, withHelpText, withInputType, withLayout, withOnEnter, withPlaceholder, withRequired, withSpellCheck


# Types

@docs InputType, Layout

-}

import Element exposing (Attribute, Element, alignTop, column, el, fill, focused, height, paddingEach, paddingXY, px, row, spacing, width)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input exposing (Label, Placeholder)
import Prefab.Text as Text
import Prefab.Utils exposing (onEnter)
import Theme


type Input msg
    = Settings
        { onChange : String -> msg
        , value : String
        , label : String
        , onEnterMsg : Maybe msg
        , inputType : InputType
        , layout : Layout
        , placeholder : Maybe String
        , spellChecked : Bool
        , isDisabled : Bool
        , isRequired : Bool
        , helpText : Maybe String
        , error : Maybe String
        }


{-| The layout of the input
-}
type Layout
    = Vertical
    | Horizontal


{-| The type of input to display
-}
type InputType
    = Text
    | Username
    | CurrentPassword
    | NewPassword
    | Email
    | Search
    | Spellchecked
    | Multiline


{-| Modify the input type of an input
-}
withInputType : InputType -> Input msg -> Input msg
withInputType inputType (Settings settings) =
    Settings
        { settings
            | inputType = inputType
        }


{-| Modify the layout of an input
-}
withLayout : Layout -> Input msg -> Input msg
withLayout layout (Settings settings) =
    Settings
        { settings
            | layout = layout
        }


{-| Modify the onEnter message of an input
-}
withOnEnter : msg -> Input msg -> Input msg
withOnEnter onEnterMsg (Settings settings) =
    Settings
        { settings
            | onEnterMsg = Just onEnterMsg
        }


{-| Modify the placeholder of an input
-}
withPlaceholder : String -> Input msg -> Input msg
withPlaceholder placeholder (Settings settings) =
    Settings
        { settings
            | placeholder = Just placeholder
        }


{-| Modify the spell check of an input
-}
withSpellCheck : Input msg -> Input msg
withSpellCheck (Settings settings) =
    Settings
        { settings
            | spellChecked = True
        }


{-| Modify the disabled state of an input
-}
withDisabled : Bool -> Input msg -> Input msg
withDisabled isDisabled (Settings settings) =
    Settings
        { settings
            | isDisabled = isDisabled
        }


{-| Modify the help text of an input
-}
withHelpText : String -> Input msg -> Input msg
withHelpText helpText (Settings settings) =
    Settings
        { settings
            | helpText = Just helpText
        }


{-| Modify the required state of an input
-}
withRequired : Input msg -> Input msg
withRequired (Settings settings) =
    Settings
        { settings
            | isRequired = True
        }


{-| Modify the error state of an input
-}
withError : Maybe String -> Input msg -> Input msg
withError error (Settings settings) =
    Settings
        { settings
            | error = error
        }


{-| Create a new input
-}
new : { onChange : String -> msg, value : String, label : String } -> Input msg
new { onChange, value, label } =
    Settings
        { onChange = onChange
        , value = value
        , label = label
        , onEnterMsg = Nothing
        , inputType = Text
        , layout = Vertical
        , placeholder = Nothing
        , spellChecked = False
        , isDisabled = False
        , isRequired = False
        , helpText = Nothing
        , error = Nothing
        }


containerAttrs : List (Attribute msg)
containerAttrs =
    [ width fill ]


{-| View an input
-}
view : List (Attribute msg) -> Input msg -> Element msg
view attrs ((Settings settings) as input) =
    case settings.layout of
        Vertical ->
            el (containerAttrs ++ attrs) <| viewVertical input

        Horizontal ->
            el (containerAttrs ++ attrs) <| viewHorizontal input


viewVertical : Input msg -> Element msg
viewVertical ((Settings settings) as inputSettings) =
    column [ width fill, spacing 8 ]
        [ Text.label [] settings.label
        , column [ width fill, spacing 4 ]
            [ renderInput inputSettings
            , settings.helpText |> Maybe.map (Text.helpText []) |> Maybe.withDefault Element.none
            ]
        ]


viewHorizontal : Input msg -> Element msg
viewHorizontal ((Settings settings) as inputSettings) =
    row [ width fill ]
        [ el [ width (px 100), alignTop ] <| Text.label [ alignTop ] settings.label
        , column [ width fill, spacing 4 ]
            [ renderInput inputSettings
            , settings.helpText |> Maybe.map (Text.helpText []) |> Maybe.withDefault Element.none
            ]
        ]


baseAttrs : List (Attribute msg)
baseAttrs =
    [ Background.color Theme.transparent
    , Border.widthEach { top = 0, left = 0, right = 0, bottom = 1 }
    , Border.color Theme.gray5
    , paddingXY 6 0
    , width fill
    , Font.color Theme.black
    , Font.size 14
    , Border.rounded 0
    , Font.family
        [ Font.typeface "Metropolis"
        , Font.typeface "Avenir Next"
        , Font.typeface "Helvetica Neue"
        , Font.sansSerif
        ]
    , focused
        [ Border.color Theme.primary
        , Border.shadow { offset = ( 0, 1 ), size = 0.01, blur = 0, color = Theme.primary }
        ]
    ]


attrsFromSettings : Input msg -> List (Attribute msg)
attrsFromSettings (Settings settings) =
    let
        onEnterAttrs =
            case settings.onEnterMsg of
                Just onEnterMsg ->
                    [ onEnter onEnterMsg ]

                Nothing ->
                    []
    in
    onEnterAttrs


renderInput : Input msg -> Element msg
renderInput ((Settings settings) as inputSettings) =
    case settings.inputType of
        Text ->
            Input.text (baseAttrs ++ attrsFromSettings inputSettings)
                { onChange = settings.onChange
                , text = settings.value
                , placeholder = makePlaceholder inputSettings
                , label = makeHiddenLabel inputSettings
                }

        Username ->
            Input.username (baseAttrs ++ attrsFromSettings inputSettings)
                { onChange = settings.onChange
                , text = settings.value
                , placeholder = makePlaceholder inputSettings
                , label = makeHiddenLabel inputSettings
                }

        CurrentPassword ->
            Input.currentPassword (baseAttrs ++ attrsFromSettings inputSettings)
                { onChange = settings.onChange
                , text = settings.value
                , placeholder = makePlaceholder inputSettings
                , label = makeHiddenLabel inputSettings
                , show = False
                }

        NewPassword ->
            Input.newPassword (baseAttrs ++ attrsFromSettings inputSettings)
                { onChange = settings.onChange
                , text = settings.value
                , placeholder = makePlaceholder inputSettings
                , label = makeHiddenLabel inputSettings
                , show = False
                }

        Email ->
            Input.email (baseAttrs ++ attrsFromSettings inputSettings)
                { onChange = settings.onChange
                , text = settings.value
                , placeholder = makePlaceholder inputSettings
                , label = makeHiddenLabel inputSettings
                }

        Search ->
            Input.search (baseAttrs ++ attrsFromSettings inputSettings)
                { onChange = settings.onChange
                , text = settings.value
                , placeholder = makePlaceholder inputSettings
                , label = makeHiddenLabel inputSettings
                }

        Spellchecked ->
            Input.spellChecked (baseAttrs ++ attrsFromSettings inputSettings)
                { onChange = settings.onChange
                , text = settings.value
                , placeholder = makePlaceholder inputSettings
                , label = makeHiddenLabel inputSettings
                }

        Multiline ->
            Input.multiline (baseAttrs ++ attrsFromSettings inputSettings)
                { onChange = settings.onChange
                , text = settings.value
                , placeholder = makePlaceholder inputSettings
                , label = makeHiddenLabel inputSettings
                , spellcheck = settings.spellChecked
                }


makePlaceholder : Input msg -> Maybe (Placeholder msg)
makePlaceholder (Settings settings) =
    case settings.placeholder of
        Just placeholder ->
            Just <|
                Input.placeholder
                    [ Font.family
                        [ Font.typeface "Metropolis"
                        , Font.typeface "Avenir Next"
                        , Font.typeface "Helvetica Neue"
                        , Font.sansSerif
                        ]
                    , Font.size 12
                    ]
                <|
                    Element.text placeholder

        Nothing ->
            Nothing


makeHiddenLabel : Input msg -> Label msg
makeHiddenLabel (Settings settings) =
    Input.labelHidden settings.label

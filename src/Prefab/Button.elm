module Prefab.Button exposing
    ( Size(..), Style(..), Variant(..)
    , new, view
    , withDisable, withIconLeft, withIconRight, withSize, withStyle, withVariant
    )

{-| Button Module

Closely modeled after the Clarity Design System's button component. <https://clarity.design/documentation/button>


# Options

@docs Size, Style, Variant


# Button

@docs new, view


# Adding Options

@docs withDisable, withIconLeft, withIconRight, withSize, withStyle, withVariant

-}

import Element exposing (Attribute, Color, Element, centerX, centerY, el, fill, height, mouseOver, paddingXY, px, row, text, width)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import FontAwesome exposing (Icon)
import Theme exposing (addAlpha)


type Button msg
    = Settings
        { label : String
        , onClick : Maybe msg
        , style : Style
        , size : Size
        , variant : Variant
        , iconLeft : Maybe (Icon msg)
        , iconRight : Maybe (Icon msg)
        , canDisable : Bool
        , allCaps : Bool
        }


{-| Change the Variant of the button
-}
type Variant
    = Solid
    | Outline
    | Flat


{-| Change the Style of the button
-}
type Style
    = Primary
    | Secondary
    | Success
    | Danger
    | Warning
    | Info


{-| Change the Size of the button
-}
type Size
    = Normal
    | Small
    | Large
    | Block


styleToColor : Style -> Color
styleToColor style =
    case style of
        Primary ->
            Theme.primary

        Secondary ->
            Theme.secondary

        Success ->
            Theme.success

        Danger ->
            Theme.danger

        Warning ->
            Theme.warning

        Info ->
            Theme.info


{-| Create a new button with a label and an optional onClick message
-}
new : { label : String, onClick : Maybe msg } -> Button msg
new settings =
    Settings
        { label = settings.label
        , onClick = settings.onClick
        , style = Primary
        , size = Normal
        , variant = Solid
        , iconLeft = Nothing
        , iconRight = Nothing
        , canDisable = False
        , allCaps = True
        }


attrsFromSettings : Button msg -> List (Attribute msg)
attrsFromSettings (Settings settings) =
    let
        sizeAttrs : List (Attribute msg)
        sizeAttrs =
            case settings.size of
                Normal ->
                    [ height (px 36) ]

                Small ->
                    [ height (px 24) ]

                Large ->
                    [ height (px 48) ]

                Block ->
                    [ width fill, height (px 36) ]

        variantAttrs : List (Attribute msg)
        variantAttrs =
            case settings.variant of
                Solid ->
                    [ Background.color (styleToColor settings.style)
                    , Font.color Theme.white
                    , mouseOver
                        [ Background.color <| addAlpha 0.9 <| styleToColor settings.style ]
                    ]

                Outline ->
                    [ Background.color Theme.transparent
                    , Border.width 1
                    , Border.color (styleToColor settings.style)
                    , Font.color (styleToColor settings.style)
                    , mouseOver
                        [ Background.color <| addAlpha 0.2 <| styleToColor settings.style ]
                    ]

                Flat ->
                    [ Border.width 0
                    , Background.color Theme.transparent
                    , Font.color (styleToColor settings.style)
                    ]

        disabledAttrs : List (Attribute msg)
        disabledAttrs =
            if settings.canDisable && settings.onClick == Nothing then
                []

            else
                []
    in
    sizeAttrs ++ variantAttrs ++ disabledAttrs


{-| Change the Style of the button
-}
withStyle : Style -> Button msg -> Button msg
withStyle style (Settings settings) =
    Settings
        { settings
            | style = style
        }


{-| Change the Size of the button
-}
withSize : Size -> Button msg -> Button msg
withSize size (Settings settings) =
    Settings
        { settings
            | size = size
        }


{-| Change the Variant of the button
-}
withVariant : Variant -> Button msg -> Button msg
withVariant variant (Settings settings) =
    Settings
        { settings
            | variant = variant
        }


{-| Add an icon to the left of the button
-}
withIconLeft : Icon msg -> Button msg -> Button msg
withIconLeft icon (Settings settings) =
    Settings
        { settings
            | iconLeft = Just icon
        }


{-| Add an icon to the right of the button
-}
withIconRight : Icon msg -> Button msg -> Button msg
withIconRight icon (Settings settings) =
    Settings
        { settings
            | iconRight = Just icon
        }


{-| Disable the button
-}
withDisable : Button msg -> Button msg
withDisable (Settings settings) =
    Settings
        { settings
            | canDisable = True
        }


{-| Change the button to not be all caps
-}
withoutCaps : Button msg -> Button msg
withoutCaps (Settings settings) =
    Settings
        { settings
            | allCaps = False
        }


baseAttrs : List (Attribute msg)
baseAttrs =
    [ Border.rounded 3
    , paddingXY 12 0
    , Font.size 12
    , Font.center
    , Font.family
        [ Font.typeface "Metropolis"
        , Font.typeface "Avenir Next"
        , Font.typeface "Helvetica Neue"
        , Font.sansSerif
        ]
    , Font.medium
    ]


{-| View the button
-}
view : List (Attribute msg) -> Button msg -> Element msg
view extraAttrs ((Settings settings) as btnSettings) =
    let
        labelText =
            text <|
                if settings.allCaps then
                    String.toUpper settings.label

                else
                    settings.label
    in
    Input.button (baseAttrs ++ attrsFromSettings btnSettings ++ extraAttrs)
        { onPress =
            if settings.canDisable then
                Nothing

            else
                settings.onClick
        , label =
            case ( settings.iconLeft, settings.iconRight ) of
                ( Nothing, Nothing ) ->
                    el [ centerX, centerY ] labelText

                ( Just icon, Nothing ) ->
                    row [] [ el [ centerX, centerY ] labelText ]

                ( Nothing, Just icon ) ->
                    row [] [ el [ centerX, centerY ] labelText ]

                ( Just iconLeft, Just iconRight ) ->
                    row [] [ el [ centerX, centerY ] labelText ]
        }

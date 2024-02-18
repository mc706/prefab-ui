module Prefab.Link exposing (Link, Size, Style, Variant, new, view, withIconLeft, withIconRight, withSize, withStyle, withVariant)

import Element exposing (Attribute, Color, Element, centerX, centerY, el, height, link, mouseOver, paddingXY, px, row, text)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import FontAwesome exposing (Icon)
import Theme exposing (addAlpha)


type Link msg
    = Settings
        { label : String
        , path : String
        , style : Style
        , size : Size
        , variant : Variant
        , iconLeft : Maybe (Icon msg)
        , iconRight : Maybe (Icon msg)
        }


type Variant
    = Solid
    | Outline
    | Flat


type Style
    = Primary
    | Secondary
    | Success
    | Danger
    | Warning
    | Info


type Size
    = Normal
    | Small
    | Large


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


new : { label : String, path : String } -> Link msg
new { label, path } =
    Settings
        { label = label
        , path = path
        , style = Primary
        , size = Normal
        , variant = Solid
        , iconLeft = Nothing
        , iconRight = Nothing
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


attrsFromSettings : Link msg -> List (Attribute msg)
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
    in
    sizeAttrs ++ variantAttrs


withStyle : Style -> Link msg -> Link msg
withStyle style (Settings settings) =
    Settings
        { settings
            | style = style
        }


withSize : Size -> Link msg -> Link msg
withSize size (Settings settings) =
    Settings
        { settings
            | size = size
        }


withVariant : Variant -> Link msg -> Link msg
withVariant variant (Settings settings) =
    Settings
        { settings
            | variant = variant
        }


withIconLeft : Icon msg -> Link msg -> Link msg
withIconLeft icon (Settings settings) =
    Settings
        { settings
            | iconLeft = Just icon
        }


withIconRight : Icon msg -> Link msg -> Link msg
withIconRight icon (Settings settings) =
    Settings
        { settings
            | iconRight = Just icon
        }


view : List (Attribute msg) -> Link msg -> Element msg
view extraAttrs ((Settings settings) as btnSettings) =
    link (baseAttrs ++ attrsFromSettings btnSettings ++ extraAttrs)
        { url = settings.path
        , label =
            case ( settings.iconLeft, settings.iconRight ) of
                ( Nothing, Nothing ) ->
                    el [ centerX, centerY ] <| text settings.label

                ( Just icon, Nothing ) ->
                    row [] [ el [ centerX, centerY ] <| text settings.label ]

                ( Nothing, Just icon ) ->
                    row [] [ el [ centerX, centerY ] <| text settings.label ]

                ( Just iconLeft, Just iconRight ) ->
                    row [] [ el [ centerX, centerY ] <| text settings.label ]
        }

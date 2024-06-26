module Prefab.Link exposing
    ( new, view
    , withIconLeft, withIconRight, withSize, withStyle, withVariant, withoutCaps, withLabelHidden
    , Size(..), Style(..), Variant(..)
    )

{-| A link styled as a button.


# Link

Styles like buttons


# Creating

@docs new, view


# Modifying

@docs withIconLeft, withIconRight, withSize, withStyle, withVariant, withoutCaps, withLabelHidden


# Types

@docs Size, Style, Variant

-}

import Element exposing (Attribute, Color, Element, centerX, centerY, el, height, link, mouseOver, paddingXY, px, row, spacing, text)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import FontAwesome exposing (Icon, WithoutId)
import Prefab.Icon as Icon
import Theme exposing (addAlpha)


type Link msg
    = Settings
        { label : String
        , path : String
        , style : Style
        , size : Size
        , variant : Variant
        , iconLeft : Maybe (Icon WithoutId)
        , iconRight : Maybe (Icon WithoutId)
        , allCaps : Bool
        , labelHidden : Bool
        }


{-| The style of the button
-}
type Variant
    = Solid
    | Outline
    | Flat


{-| The style of the button
-}
type Style
    = Primary
    | Secondary
    | Success
    | Danger
    | Warning
    | Info


{-| The size of the button
-}
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


{-| Create a new link styled as a button
-}
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
        , allCaps = True
        , labelHidden = False
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


{-| Modify the style of the button
-}
withStyle : Style -> Link msg -> Link msg
withStyle style (Settings settings) =
    Settings
        { settings
            | style = style
        }


{-| Modify the size of the button
-}
withSize : Size -> Link msg -> Link msg
withSize size (Settings settings) =
    Settings
        { settings
            | size = size
        }


{-| Modify the variant of the button
-}
withVariant : Variant -> Link msg -> Link msg
withVariant variant (Settings settings) =
    Settings
        { settings
            | variant = variant
        }


{-| Add an icon to the left of the button
-}
withIconLeft : Icon WithoutId -> Link msg -> Link msg
withIconLeft icon (Settings settings) =
    Settings
        { settings
            | iconLeft = Just icon
        }


{-| Add an icon to the right of the button
-}
withIconRight : Icon WithoutId -> Link msg -> Link msg
withIconRight icon (Settings settings) =
    Settings
        { settings
            | iconRight = Just icon
        }


{-| Remove all caps from the link
-}
withoutCaps : Link msg -> Link msg
withoutCaps (Settings settings) =
    Settings
        { settings
            | allCaps = False
        }


{-| Hide the label of the link
-}
withLabelHidden : Link msg -> Link msg
withLabelHidden (Settings settings) =
    Settings
        { settings
            | labelHidden = True
        }


{-| View the link styled as a button
-}
view : List (Attribute msg) -> Link msg -> Element msg
view extraAttrs ((Settings settings) as btnSettings) =
    let
        labelText =
            text <|
                if settings.allCaps then
                    String.toUpper settings.label

                else
                    settings.label
    in
    link (baseAttrs ++ attrsFromSettings btnSettings ++ extraAttrs)
        { url = settings.path
        , label =
            case ( settings.iconLeft, settings.iconRight ) of
                ( Nothing, Nothing ) ->
                    el [ centerX, centerY ] labelText

                ( Just icon, Nothing ) ->
                    row [ spacing 8 ]
                        [ Icon.icon [] icon
                        , if settings.labelHidden then
                            Element.none

                          else
                            el [ centerX, centerY ] labelText
                        ]

                ( Nothing, Just icon ) ->
                    row [ spacing 8 ]
                        [ if settings.labelHidden then
                            Element.none

                          else
                            el [ centerX, centerY ] labelText
                        , Icon.icon [] icon
                        ]

                ( Just iconLeft, Just iconRight ) ->
                    row [ spacing 8 ]
                        [ Icon.icon [] iconLeft
                        , if settings.labelHidden then
                            Element.none

                          else
                            el [ centerX, centerY ] labelText
                        , Icon.icon [] iconRight
                        ]
        }

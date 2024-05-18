module Prefab.Alert exposing
    ( new, view
    , withDismiss, withSize, withType
    , AlertSize(..), AlertType(..)
    )

{-| A simple alert component that can be used to display messages to the user.

See [clarity.design alerts](https://clarity.design/documentation/alert)


# Creating

@docs new, view


# Modifying

@docs withDismiss, withSize, withType


# Types

@docs AlertSize, AlertType

-}

import Element exposing (Attribute, Color, Element, height, padding, px, row, spacing)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import FontAwesome.Solid as Solid
import Prefab.Button as Button
import Prefab.Icon as Icon
import Prefab.Text as Text
import Theme exposing (addAlpha)


{-| The type of alert to display
-}
type AlertType
    = Success
    | Info
    | Warning
    | Danger


{-| The size of the alert to display
-}
type AlertSize
    = Normal
    | Compact


type Alert msg
    = Settings
        { alertType : AlertType
        , message : String
        , size : AlertSize
        , onClose : Maybe msg
        , dismissText : Maybe String
        }


{-| Create a new alert with the given message and default settings
-}
new : { message : String } -> Alert msg
new { message } =
    Settings
        { alertType = Info
        , message = message
        , size = Normal
        , onClose = Nothing
        , dismissText = Nothing
        }


{-| Set the type of alert
-}
withType : AlertType -> Alert msg -> Alert msg
withType alertType (Settings settings) =
    Settings
        { settings | alertType = alertType }


{-| Set the size of the alert
-}
withSize : AlertSize -> Alert msg -> Alert msg
withSize size (Settings settings) =
    Settings
        { settings | size = size }


{-| Set a dismiss button with the given message
-}
withDismiss : msg -> Alert msg -> Alert msg
withDismiss onClose (Settings settings) =
    Settings
        { settings | onClose = Just onClose }


baseAttrs : List (Attribute msg)
baseAttrs =
    [ spacing 12, Border.rounded 3, Border.width 1, Text.fontFamily ]


colorFromStyle : AlertType -> Color
colorFromStyle alertType =
    case alertType of
        Success ->
            Theme.success

        Info ->
            Theme.info

        Warning ->
            Theme.warning

        Danger ->
            Theme.danger


attrsFromSettings : Alert msg -> List (Attribute msg)
attrsFromSettings (Settings settings) =
    let
        typeAttrs =
            [ Border.color (colorFromStyle settings.alertType)
            , Background.color <| addAlpha 0.2 <| colorFromStyle settings.alertType
            ]

        sizeAttrs =
            case settings.size of
                Normal ->
                    [ height (px 40)
                    , padding 10
                    ]

                Compact ->
                    [ height (px 24)
                    , padding 5
                    ]
    in
    typeAttrs ++ sizeAttrs


{-| Display the alert
-}
view : List (Attribute msg) -> Alert msg -> Element msg
view attrs ((Settings settings) as alertSettings) =
    row (baseAttrs ++ attrsFromSettings alertSettings ++ attrs)
        [ displayAlertIcon alertSettings
        , Text.sectionHeader [] settings.message
        , displayDismissButton alertSettings
        ]


displayAlertIcon : Alert msg -> Element msg
displayAlertIcon (Settings settings) =
    case settings.alertType of
        Success ->
            Icon.icon [ Font.color Theme.success ] Solid.checkCircle

        Info ->
            Icon.icon [ Font.color Theme.info ] Solid.infoCircle

        Warning ->
            Icon.icon [ Font.color Theme.warning ] Solid.triangleExclamation

        Danger ->
            Icon.icon [ Font.color Theme.danger ] Solid.circleExclamation


displayDismissButton : Alert msg -> Element msg
displayDismissButton (Settings settings) =
    case ( settings.onClose, settings.dismissText ) of
        ( Just msg, Just dismissText ) ->
            Button.new { onClick = Just msg, label = dismissText }
                |> Button.withVariant Button.Flat
                |> Button.view []

        ( Just msg, Nothing ) ->
            Button.new { onClick = Just msg, label = "Dismiss" }
                |> Button.withVariant Button.Flat
                |> Button.view []

        _ ->
            Element.none

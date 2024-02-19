module Prefab.Text exposing
    ( body, form, grid, h1, h2, h3, h4, h5, h6, headerSmall, helpText, label, sectionHeader, table
    , fontFamily
    )

{-| A collection of text elements with predefined styles.


# Text Helpers

@docs body, form, grid, h1, h2, h3, h4, h5, h6, headerSmall, helpText, label, sectionHeader, table

-}

import Element exposing (Attribute, Element, el, text)
import Element.Font as Font
import Theme


fontFamily : Attribute msg
fontFamily =
    Font.family
        [ Font.typeface "Metropolis"
        , Font.typeface "Avenir Next"
        , Font.typeface "Helvetica Neue"
        , Font.sansSerif
        ]


fontFamilyWith : String -> Attribute msg
fontFamilyWith typeface =
    Font.family
        [ Font.typeface typeface
        , Font.typeface "Metropolis"
        , Font.typeface "Avenir Next"
        , Font.typeface "Helvetica Neue"
        , Font.sansSerif
        ]


baseTextAttrs : List (Attribute msg)
baseTextAttrs =
    [ Font.color Theme.black
    , fontFamily
    ]


textInternal : List (Attribute msg) -> List (Attribute msg) -> String -> Element msg
textInternal attrs extraAttrs key =
    el (baseTextAttrs ++ attrs ++ extraAttrs) <| text key


{-| A large header text element.
-}
h1 : List (Attribute msg) -> String -> Element msg
h1 =
    textInternal
        [ fontFamilyWith "Metropolis Light"
        , Font.size 32
        , Font.color Theme.black
        ]


{-| A medium header text element.
-}
h2 : List (Attribute msg) -> String -> Element msg
h2 =
    textInternal
        [ fontFamilyWith "Metropolis Light"
        , Font.size 28
        , Font.color Theme.black
        ]


{-| A small header text element.
-}
h3 : List (Attribute msg) -> String -> Element msg
h3 =
    textInternal
        [ fontFamilyWith "Metropolis Light"
        , Font.size 22
        , Font.color Theme.black
        ]


{-| A very small header text element.
-}
h4 : List (Attribute msg) -> String -> Element msg
h4 =
    textInternal
        [ fontFamilyWith "Metropolis Light"
        , Font.size 18
        , Font.color Theme.black
        ]


{-| A very very small header text element.
-}
h5 : List (Attribute msg) -> String -> Element msg
h5 =
    textInternal
        [ fontFamilyWith "Metropolis Regular"
        , Font.size 16
        , Font.color Theme.gray6
        ]


{-| A very very very small header text element.
-}
h6 : List (Attribute msg) -> String -> Element msg
h6 =
    textInternal
        [ fontFamilyWith "Metropolis Medium"
        , Font.size 14
        , Font.color Theme.gray7
        ]


{-| A body text element.
-}
body : List (Attribute msg) -> String -> Element msg
body =
    textInternal
        [ fontFamilyWith "Metropolis Regular"
        , Font.size 14
        , Font.color Theme.gray6
        ]


{-| A section header text element.
-}
sectionHeader : List (Attribute msg) -> String -> Element msg
sectionHeader =
    textInternal
        [ fontFamilyWith "Metropolis Medium"
        , Font.size 13
        , Font.color Theme.gray7
        ]


{-| A table text element.
-}
table : List (Attribute msg) -> String -> Element msg
table =
    textInternal
        [ fontFamilyWith "Metropolis Regular"
        , Font.size 13
        , Font.color Theme.gray6
        ]


{-| A grid text element.
-}
grid : List (Attribute msg) -> String -> Element msg
grid =
    table


{-| A form text element.
-}
form : List (Attribute msg) -> String -> Element msg
form =
    table


{-| A form text element.
-}
label : List (Attribute msg) -> String -> Element msg
label =
    textInternal
        [ Font.family [ Font.typeface "Metropolis Semibold", Font.typeface "Metropolis" ]
        , Font.size 12
        , Font.semiBold
        , Font.color Theme.gray6
        ]


{-| A small header text element.
-}
headerSmall : List (Attribute msg) -> String -> Element msg
headerSmall =
    textInternal
        [ Font.family [ Font.typeface "Metropolis Semibold", Font.typeface "Metropolis" ]
        , Font.size 11
        , Font.semiBold
        , Font.color Theme.gray6
        ]


{-| A help text element.
-}
helpText : List (Attribute msg) -> String -> Element msg
helpText =
    textInternal
        [ Font.family [ Font.typeface "Metropolis Regular", Font.typeface "Metropolis" ]
        , Font.size 11
        , Font.color Theme.gray6
        ]

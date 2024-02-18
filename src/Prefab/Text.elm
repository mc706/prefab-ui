module Prefab.Text exposing (body, fontFamily, form, grid, h1, h2, h3, h4, h5, h6, headerSmall, helpText, label, sectionHeader, table)

{-| A collection of text elements with predefined styles.


# Text Helpers

@docs body, fontFamily, form, grid, h1, h2, h3, h4, h5, h6, headerSmall, helpText, label, sectionHeader, table

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


h1 : List (Attribute msg) -> String -> Element msg
h1 =
    textInternal
        [ fontFamilyWith "Metropolis Light"
        , Font.size 32
        , Font.color Theme.black
        ]


h2 : List (Attribute msg) -> String -> Element msg
h2 =
    textInternal
        [ fontFamilyWith "Metropolis Light"
        , Font.size 28
        , Font.color Theme.black
        ]


h3 : List (Attribute msg) -> String -> Element msg
h3 =
    textInternal
        [ fontFamilyWith "Metropolis Light"
        , Font.size 22
        , Font.color Theme.black
        ]


h4 : List (Attribute msg) -> String -> Element msg
h4 =
    textInternal
        [ fontFamilyWith "Metropolis Light"
        , Font.size 18
        , Font.color Theme.black
        ]


h5 : List (Attribute msg) -> String -> Element msg
h5 =
    textInternal
        [ fontFamilyWith "Metropolis Regular"
        , Font.size 16
        , Font.color Theme.gray6
        ]


h6 : List (Attribute msg) -> String -> Element msg
h6 =
    textInternal
        [ fontFamilyWith "Metropolis Medium"
        , Font.size 14
        , Font.color Theme.gray7
        ]


body : List (Attribute msg) -> String -> Element msg
body =
    textInternal
        [ fontFamilyWith "Metropolis Regular"
        , Font.size 14
        , Font.color Theme.gray6
        ]


sectionHeader : List (Attribute msg) -> String -> Element msg
sectionHeader =
    textInternal
        [ fontFamilyWith "Metropolis Medium"
        , Font.size 13
        , Font.color Theme.gray7
        ]


table : List (Attribute msg) -> String -> Element msg
table =
    textInternal
        [ fontFamilyWith "Metropolis Regular"
        , Font.size 13
        , Font.color Theme.gray6
        ]


grid =
    table


form =
    table


label : List (Attribute msg) -> String -> Element msg
label =
    textInternal
        [ Font.family [ Font.typeface "Metropolis Semibold", Font.typeface "Metropolis" ]
        , Font.size 12
        , Font.semiBold
        , Font.color Theme.gray6
        ]


headerSmall : List (Attribute msg) -> String -> Element msg
headerSmall =
    textInternal
        [ Font.family [ Font.typeface "Metropolis Semibold", Font.typeface "Metropolis" ]
        , Font.size 11
        , Font.semiBold
        , Font.color Theme.gray6
        ]


helpText : List (Attribute msg) -> String -> Element msg
helpText =
    textInternal
        [ Font.family [ Font.typeface "Metropolis Regular", Font.typeface "Metropolis" ]
        , Font.size 11
        , Font.color Theme.gray6
        ]

module Theme exposing
    ( white, primary, secondary, gray1, gray2, gray3, gray4, gray5, gray6, gray7, gray8, gray9, black, red, danger, warning, blue, green, success, link, info, transparent
    , addAlpha
    )

{-| This module contains the color palette for the application.


# Colors

@docs white, primary, secondary, gray1, gray2, gray3, gray4, gray5, gray6, gray7, gray8, gray9, black, red, danger, warning, blue, green, success, link, info, transparent


# Helpers

@docs addAlpha

|

-}

import Element exposing (Color, fromRgb, rgb255, toRgb)


{-| White color |
-}
white : Color
white =
    rgb255 255 255 255


{-| Primary color |
-}
primary : Color
primary =
    rgb255 19 65 225


{-| Secondary color |
-}
secondary : Color
secondary =
    rgb255 49 49 49


{-| Gray color 1 |
-}
gray1 : Color
gray1 =
    rgb255 229 229 229


{-| Gray color 2 |
-}
gray2 : Color
gray2 =
    rgb255 203 203 203


{-| Gray color 3 |
-}
gray3 : Color
gray3 =
    rgb255 178 178 178


{-| Gray color 4 |
-}
gray4 : Color
gray4 =
    rgb255 191 191 191


{-| Gray color 5 |
-}
gray5 : Color
gray5 =
    rgb255 180 180 180


{-| Gray color 6 |
-}
gray6 : Color
gray6 =
    rgb255 96 96 96


{-| Gray color 7 |
-}
gray7 : Color
gray7 =
    rgb255 49 49 49


{-| Gray color 8 |
-}
gray8 : Color
gray8 =
    rgb255 37 37 37


{-| Gray color 9 |
-}
gray9 : Color
gray9 =
    rgb255 8 7 7


{-| Black color |
-}
black : Color
black =
    rgb255 0 0 0


{-| Red color |
-}
red : Color
red =
    rgb255 255 145 145


{-| Danger color |
-}
danger : Color
danger =
    red


{-| Warning color |
-}
warning : Color
warning =
    rgb255 255 204 102


{-| Blue color |
-}
blue : Color
blue =
    rgb255 19 65 225


{-| Green color |
-}
green : Color
green =
    rgb255 15 155 129


{-| Success color |
-}
success : Color
success =
    green


{-| Link color |
-}
link : Color
link =
    rgb255 128 156 255


{-| Info color |
-}
info : Color
info =
    link


{-| Transparent color |
-}
transparent : Color
transparent =
    addAlpha 0 <| rgb255 255 255 255


{-| Add alpha channel to color |
-}
addAlpha : Float -> Color -> Color
addAlpha alphaChannel color =
    let
        rgb =
            toRgb color
    in
    fromRgb { rgb | alpha = alphaChannel }

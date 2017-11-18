module Css.App exposing (..)

import Css exposing (..)
import Html.CssHelpers exposing (withNamespace)
import Css.Namespace exposing (namespace)
import Css.Media exposing (mediaQuery)


appNamespace =
    withNamespace "App"


type AppCss
    = Header
    | Logo
    | Grid
    | BreadcrumbItem
    | RightSideIcons
    | NavListItem
    | NavListFlex


css =
    (stylesheet << namespace appNamespace.name)
        [ class Header
            [ padding (px 0)
            , overflow (hidden)
            , backgroundColor (hex "673BB7")
            , property "box-shadow" "0px 2px 4px -1px rgba(0, 0, 0, 0.2), 0px 4px 5px 0px rgba(0, 0, 0, 0.14), 0px 1px 10px 0px rgba(0, 0, 0, 0.12)"
            ]
        , class Logo
            [ property "font" "30pt Roboto"
            , textShadow4 (px 1) (px 1) (px 1) (rgba 0 0 0 1)
            , margin (px 0)
            , firstLetter
                [ property "font" "40pt Roboto" ]
            ]
        , class Grid
            [ justifyContent spaceBetween
            , padding4 (px 0) (px 16) (px 0) (px 16)
            ]
        , class RightSideIcons
            [ flexBasis (px 0)
            , flexGrow (num 1)
            , maxWidth (pct 100)
            ]
        , class BreadcrumbItem
            [ fontSize (px 16)
            , focus [ textDecoration none, color inherit ]
            , hover [ textDecoration none, color inherit ]
            , textDecoration none
            , color inherit
            ]
        , class NavListItem
            [ cursor pointer
            , property "flex" "1 1 auto"
            , property "-webkit-user-select" "none"
            , property "-moz-user-select" "none"
            , property "-ms-user-select" "none"
            , property "user-select" "none"
            ]
        , mediaQuery [ "(max-width: 839px) and (min-width:480px)" ]
            [ class NavListItem
                [ display inlineFlex ]
            , class NavListFlex
                [ displayFlex ]
            ]
        ]

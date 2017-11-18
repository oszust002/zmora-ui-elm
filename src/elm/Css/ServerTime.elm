module Css.ServerTime exposing (..)

import Css exposing (..)
import Html.CssHelpers exposing (withNamespace)
import Css.Namespace exposing (namespace)


serverTimeNamespace =
    withNamespace "ServerTime"


type ServerTimeCss
    = TimeChip


css =
    (stylesheet << namespace serverTimeNamespace.name)
        [ class TimeChip
            [ color inherit
            , backgroundColor (rgba 255 255 255 0.3)
            ]
        ]

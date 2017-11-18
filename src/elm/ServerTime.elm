module ServerTime exposing (..)

import Material.Button as Button
import Material.Icon as Icon
import Material.Chip as Chip
import Html exposing (..)
import Msgs exposing (Msg(..))
import Material
import Material.Typography as Typography
import Material.Options as Options
import Css.ServerTime exposing (ServerTimeCss(..), serverTimeNamespace)
import Utils exposing (timeToString)
import Date.Extra.Format exposing (isoTimeFormat)
import Model exposing (AppOptions)


{ id, class, classList } =
    serverTimeNamespace


view : Material.Model -> AppOptions -> Html Msg
view mdl options =
    case options.showChip of
        True ->
            Chip.button
                [ Options.onClick ToggleTime
                , Options.attribute (class [ TimeChip ])
                ]
                [ Chip.contact span [] [ Icon.view "schedule" [ Options.css "font-size" "32px" ] ]
                , Chip.content []
                    [ Options.styled span [ Typography.body2 ] [ text (timeToString options.time isoTimeFormat) ]
                    ]
                ]

        False ->
            Button.render Mdl
                [ 0 ]
                mdl
                [ Button.icon, Options.onClick ToggleTime ]
                [ Icon.view "schedule" [ Icon.size24 ] ]

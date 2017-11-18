module Breadcrumbs exposing (..)

import Routes exposing (Route(..), pathFromRoute)
import Html exposing (..)
import Msgs exposing (Msg(..))
import Html.Attributes exposing (href)
import List
import Utils exposing (onPreventDefaultClick)


view : Route -> List Route -> List (Attribute Msg) -> Html Msg
view route excluded itemStyles =
    let
        homeString =
            case route of
                Home ->
                    "Home"

                Contests ->
                    "Contests"

                _ ->
                    ""

        routePath =
            case pathFromRoute route of
                Just path ->
                    path

                Nothing ->
                    ""
    in
        case (List.member route excluded) of
            True ->
                div [] []

            False ->
                a (itemStyles ++ [ href routePath, onPreventDefaultClick (NewUrl routePath) ]) [ text homeString ]

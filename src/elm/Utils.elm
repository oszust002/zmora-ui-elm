module Utils exposing (timeToString, onPreventDefaultClick)

import Html exposing (Attribute)
import Date.Extra.Config.Config_pl_pl exposing (config)
import Date.Extra.Format exposing (format)
import Html.Events exposing (onWithOptions, defaultOptions)
import Json.Decode exposing (Decoder)
import Time exposing (Time)
import Date exposing (Date)


timeToString : Time -> String -> String
timeToString time timeFormat =
    Date.fromTime time
        |> format config timeFormat


onPreventDefaultClick : msg -> Attribute msg
onPreventDefaultClick message =
    onWithOptions "click"
        { defaultOptions | preventDefault = True }
        (preventDefault2
            |> Json.Decode.andThen (maybePreventDefault message)
        )


preventDefault2 : Decoder Bool
preventDefault2 =
    Json.Decode.map2
        (invertedOr)
        (Json.Decode.field "ctrlKey" Json.Decode.bool)
        (Json.Decode.field "metaKey" Json.Decode.bool)


maybePreventDefault : msg -> Bool -> Decoder msg
maybePreventDefault msg preventDefault =
    case preventDefault of
        True ->
            Json.Decode.succeed msg

        False ->
            Json.Decode.fail "Normal link"


invertedOr : Bool -> Bool -> Bool
invertedOr x y =
    not (x || y)

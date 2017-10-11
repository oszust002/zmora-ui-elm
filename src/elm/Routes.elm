module Routes exposing (..)

import Navigation exposing (Location)
import UrlParser as Url exposing ((</>), Parser, oneOf, s, string, parsePath)


type Route
    = Home
    | Contests
    | NotFound


route : Parser (Route -> a) a
route =
    oneOf
        [ Url.map Home (s "")
        , Url.map Contests (s "contests")
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parsePath route location) of
        Just route ->
            route

        Nothing ->
            NotFound

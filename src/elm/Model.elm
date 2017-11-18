module Model exposing (..)

import Time exposing (Time)
import Routes exposing (Route)
import Material


type alias AppOptions =
    { showChip : Bool
    , time : Time
    , width : Int
    , height : Int
    }


type alias Model =
    { appOptions : AppOptions
    , number : Int
    , route : Route
    , mdl : Material.Model
    }


type alias Flags =
    { time : Time
    , width : Int
    , height : Int
    }


initialAppOptions : Flags -> AppOptions
initialAppOptions flags =
    { showChip = False
    , time = flags.time
    , width = flags.width
    , height = flags.height
    }


initialModel : AppOptions -> Route -> Model
initialModel options route =
    { appOptions = options
    , number = 0
    , route = route
    , mdl = Material.model
    }

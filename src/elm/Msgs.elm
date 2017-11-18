module Msgs exposing (..)

import Time exposing (Time)
import Material
import Navigation exposing (Location)


type Msg
    = NoOp
    | Increment
    | OnLocationChange Location
    | NewUrl String
    | Mdl (Material.Msg Msg)
    | ToggleTime
    | Tick Time
    | Resize Int Int

module Types exposing (..)

import Time exposing (Time)


type alias Model =
    { drinkTimes : List Time
    , offset : Int
    , configOpen : Bool
    }


type Msg
    = Drink
    | SetOffset Int
    | ToggleConfig
    | SetMode String

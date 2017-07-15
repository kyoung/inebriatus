module Types exposing (..)

import Time exposing (Time)


type alias Model =
    { drinkTimes : List Time
    , offset : Int
    , configOpen : Bool
    }


type Msg
    = Drink Time.Time
    | GetTimeAndDrink
    | SetOffset Int
    | ToggleConfig
    | SetMode String

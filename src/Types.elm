module Types exposing (..)

import Time exposing (Time)


type alias Model =
    { drinkTimes : List Time
    , offset : Int
    , configOpen : Bool
    , mode : Mode
    }


type Msg
    = Drink Time.Time
    | GetTimeAndDrink
    | SetOffset Int
    | ToggleConfig
    | SetMode Mode


type Mode
    = PercentageClickFourOz

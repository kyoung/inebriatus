module Types exposing (..)

import Time exposing (Time)


type alias Model =
    { drinkTimes : List Time
    , offset : Float
    , configOpen : Bool
    , mode : Mode
    , lightsLit : Float
    , lightsTotal : Int
    }


type Msg
    = Drink Time.Time
    | GetTimeAndDrink
    | SetOffset String
    | ToggleConfig
    | SetMode Mode


type Mode
    = PercentageClickFourOz

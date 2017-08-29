module Types exposing (..)

import Time exposing (Time)


type alias Model =
    { drinkTimes : List Time
    , offset : Float
    , configOpen : Bool
    , mode : Mode
    , lightsLit : Float
    , lightsTotal : Int
    , lastTick : Time
    }


type Msg
    = Drink Time.Time
    | GetTimeAndDrink
    | SetOffset String
    | ToggleConfig
    | SetMode String
    | Tick Time.Time


type Mode
    = PercentageClickFourOz
    | WorkDrinks


modeString : Mode -> String
modeString mode =
    case mode of
        PercentageClickFourOz ->
            "% click, 4oz. (Farmhouse)"

        WorkDrinks ->
            "click per half drink (Corporate Event)"

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
    | SetMode String


type Mode
    = PercentageClickFourOz
    | WorkDrinks


modeString : Mode -> String
modeString mode =
  case mode of
    PercentageClickFourOz -> "% click, 4oz."
    WorkDrinks -> "click per drink"

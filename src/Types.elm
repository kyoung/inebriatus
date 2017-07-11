module Types exposing (..)

import Time exposing ( Time )

type alias Model = { drinkTimes : List Time
                   , offset: Int
                   }

type Msg = Drink | SetOffset Int

module State exposing (init, subscriptions, update)

import Task
import Time exposing (Time)
import Types exposing (..)


init : ( Model, Cmd Msg )
init =
    ( { drinkTimes = []
      , offset = 1
      , configOpen = False
      , mode = Types.PercentageClickFourOz
      , lightsLit = 0.0
      , lightsTotal = 12
      }
    , Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    case action of
        GetTimeAndDrink ->
            ( model, Task.perform Drink Time.now )

        Drink time ->
            ( { model | drinkTimes = List.append model.drinkTimes [ time ], lightsLit =  calcLights ( List.append model.drinkTimes [ time ] ) }, Cmd.none )

        SetOffset value ->
            case String.toFloat value  of
              Err msg ->
                ( model, Cmd.none )
              Ok val ->
                ( { model | offset = val / 50 }, Cmd.none )

        ToggleConfig ->
            ( { model | configOpen = not model.configOpen }, Cmd.none )

        SetMode newMode ->
            let
              f = \nm ->
                if ( modeString PercentageClickFourOz ) == nm then
                   PercentageClickFourOz
                else if ( modeString WorkDrinks ) == nm then
                   WorkDrinks
                else
                   PercentageClickFourOz
            in
              ( { model | mode = f newMode }, Cmd.none )


calcLights : List Time -> Float
calcLights drinkTimes =
  let
    ua_per_drink = 1.25
    target_ua = 52.5
    metabol_per_sec = 0.00089
    target_light = 7
  in

    toFloat ( List.length drinkTimes )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none

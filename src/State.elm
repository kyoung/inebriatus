module State exposing (init, subscriptions, sumDrink, sumUA, update)

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
      , lastTick = 0
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    case action of
        GetTimeAndDrink ->
            ( model, Task.perform Drink Time.now )

        Drink time ->
            ( { model
                | drinkTimes = List.append model.drinkTimes [ time ]
                , lightsLit = calcLights (List.append model.drinkTimes [ time ]) model.lastTick model.offset
              }
            , Cmd.none
            )

        Tick time ->
            ( { model | lastTick = time, lightsLit = calcLights model.drinkTimes time model.offset }, Cmd.none )

        SetOffset value ->
            case String.toFloat value of
                Err msg ->
                    ( model, Cmd.none )

                Ok val ->
                    ( { model | offset = val / 50 }, Cmd.none )

        ToggleConfig ->
            ( { model | configOpen = not model.configOpen }, Cmd.none )

        SetMode newMode ->
            let
                f =
                    \nm ->
                        if modeString PercentageClickFourOz == nm then
                            PercentageClickFourOz
                        else if modeString WorkDrinks == nm then
                            WorkDrinks
                        else
                            PercentageClickFourOz
            in
            ( { model | mode = f newMode }, Cmd.none )


zeroBlock : Float -> Float
zeroBlock n =
    if n > 0 then
        n
    else
        0


calcLights : List Time -> Time -> Float -> Float
calcLights drinkTimes tNow offset =
    let
        target_ua =
            52.5

        target_light =
            7

        ( last_ua, last_t ) =
            sumUA drinkTimes offset

        current_ua =
            zeroBlock
                (last_ua
                    - (metabolUAPerSec
                        * offset
                        * Time.inSeconds (tNow - last_t)
                      )
                )
    in
    (current_ua / target_ua) * target_light


uaPerDrink =
    1.25


metabolUAPerSec =
    0.00089


sumDrink : Float -> ( Float, Time ) -> ( Float, Time ) -> ( Float, Time )
sumDrink offset ( t2_ua, t2_time ) ( t1_ua, t1_time ) =
    if t1_time == 0 then
        ( uaPerDrink, t2_time )
    else
        ( t1_ua
            + uaPerDrink
            - zeroBlock
                (metabolUAPerSec
                    * offset
                    * Time.inSeconds (t2_time - t1_time)
                )
        , t2_time
        )


sumUA : List Time -> Float -> ( Float, Time )
sumUA drinkTimes offset =
    let
        base_data =
            List.map2 (,) (List.repeat (List.length drinkTimes) 0) drinkTimes

        offsetSumDrink =
            sumDrink offset
    in
    List.foldl offsetSumDrink ( 0, 0 ) base_data


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every Time.second Types.Tick

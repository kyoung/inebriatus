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
            ( { model | drinkTimes = List.append model.drinkTimes [ time ], lightsLit = calcLights (List.append model.drinkTimes [ time ]) model.lastTick }, Cmd.none )

        Tick time ->
            ( { model | lastTick = time, lightsLit = calcLights model.drinkTimes time }, Cmd.none )

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


positiveVal : Float -> Float
positiveVal n =
    if n > 0 then
        n
    else
        0


calcLights : List Time -> Time -> Float
calcLights drinkTimes tNow =
    let
        target_ua =
            52.5

        target_light =
            7

        metabol_per_sec =
            0.00089

        ( last_ua, last_t ) =
            sum_ua drinkTimes

        current_ua =
            last_ua - positiveVal (metabol_per_sec * (Time.inSeconds tNow - Time.inSeconds last_t))
    in
    (current_ua / target_ua) * target_light


sum_ua : List Time -> ( Float, Time )
sum_ua drinkTimes =
    let
        ua_per_drink =
            1.25

        metabol_per_sec =
            0.00089

        base_data =
            List.map2 (,) (List.repeat (List.length drinkTimes) 0) drinkTimes

        sum_drink ( t1_ua, t1_t ) ( t2_ua, t2_t ) =
            if t1_t == 0 then
                ( ua_per_drink, t2_t )
            else
                ( t1_ua + ua_per_drink - positiveVal (metabol_per_sec * (Time.inSeconds t2_t - Time.inSeconds t1_t)), t2_t )
    in
    List.foldl sum_drink ( 0, 0 ) base_data


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every Time.second Types.Tick

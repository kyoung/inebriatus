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
      }
    , Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    case action of
        GetTimeAndDrink ->
            ( model, Task.perform Drink Time.now )

        Drink time ->
            ( { model | drinkTimes = List.append model.drinkTimes [ time ] }, Cmd.none )

        SetOffset value ->
            ( model, Cmd.none )

        ToggleConfig ->
            ( { model | configOpen = not model.configOpen }, Cmd.none )

        SetMode newMode ->
            ( { model | mode = newMode }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none

module State exposing (init, subscriptions, update)

import Types exposing (..)


init : ( Model, Cmd Msg )
init =
    ( { drinkTimes = [], offset = 1, configOpen = False }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    case action of
        Drink ->
            ( model, Cmd.none )

        SetOffset value ->
            ( model, Cmd.none )

        ToggleConfig ->
            ( model, Cmd.none )

        SetMode mode ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none

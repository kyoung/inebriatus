module State exposing (init, update, subscriptions)

import Types exposing ( Model, Msg )

init : ( Model, Cmd Msg )
init =
  ({ drinkTimes = [], offset = 1 }, Cmd.none)

update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
  (model, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions _ =
  Sub.none

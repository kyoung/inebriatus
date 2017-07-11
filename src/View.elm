module View exposing (..)

import Html exposing (Html, text, div, br, p)
import Types exposing ( Model, Msg )

root : Model -> Html Msg
root model =
  div
    []
    [ p [] [text "inebriatus"]
    , p [] [text "Offset: ", text (toString model.offset)]
    , p [] [text "Drink times: ", text (String.concat (List.map toString model.drinkTimes))]
    ]

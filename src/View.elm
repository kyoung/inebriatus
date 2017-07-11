module View exposing (..)

import Html exposing (Html, body, br, div, p, text)
import Types exposing (Model, Msg)


root : Model -> Html Msg
root model =
    body
        []
        [ div
            []
            [ p [] [ text "inebriatus" ]
            , p [] [ text "Offset: ", text (toString model.offset) ]
            , p [] [ text "Drink times: ", text (String.concat (List.map toString model.drinkTimes)) ]
            ]
        ]

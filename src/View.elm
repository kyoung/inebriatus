module View exposing (..)

import Html exposing (Html, body, br, div, p, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Types exposing (Model, Msg)


root : Model -> Html Msg
root model =
    div
        [ class "container" ]
        [ p [] [ text "inebriatus" ]
        , indicator model
        , configurator model
        ]


indicator : Model -> Html Msg
indicator model =
    div
        [ class "indicator" ]
        [ p [] [ text "indicator" ]
        , p [] [ text "Drink Times: ", text (String.concat (List.map toString model.drinkTimes)) ]
        ]


configurator : Model -> Html Msg
configurator model =
    div
        [ class "configurator" ]
        [ div
            [ onClick Types.ToggleConfig ]
            [ p [] [ text "close " ] ]
        , p [] [ text "configurator" ]
        , p [] [ text "Offset: ", text (toString model.offset) ]
        ]

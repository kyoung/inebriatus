module View exposing (..)

import Elements exposing (..)
import Html exposing (Html, body, br, button, div, li, p, text, ul)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import List exposing (map)
import Types exposing (Model, Msg)


-- use this instead http://package.elm-lang.org/packages/mdgriffith/style-elements/3.2.3


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
        , button [ onClick Types.GetTimeAndDrink ] [ text "Drink" ]
        , ul
            []
            (map (\l -> li [] [ text (toString l) ]) model.drinkTimes)
        ]


configurator : Model -> Html Msg
configurator model =
    if model.configOpen then
        configuratorOpen model
    else
        configuratorClosed model


configuratorOpen : Model -> Html Msg
configuratorOpen model =
    div
        [ class "configurator" ]
        [ div
            [ onClick Types.ToggleConfig ]
            [ p [] [ text "close " ] ]
        , p [] [ text "configurator" ]
        , p [] [ text "Offset: ", text (toString model.offset) ]
        ]


configuratorClosed : Model -> Html Msg
configuratorClosed model =
    div
        []
        [ p [ onClick Types.ToggleConfig ] [ text "configurator " ] ]

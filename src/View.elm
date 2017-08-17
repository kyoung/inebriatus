module View exposing (..)

import Html exposing (div, input, p, text)
import Html.Attributes as Hattr exposing (class, max, min, style, type_, value)
import Html.Events exposing (onClick, onInput)
import List exposing (map)
import Svg exposing (svg)
import Svg.Attributes as Sattr exposing (..)
import Types exposing (Model, Msg)


columnStyle =
    Hattr.style
        [ ( "display", "flex" )
        , ( "flex-direction", "column" )
        , ( "align-items", "center" )
        ]


fullWidthStyle =
    Hattr.style [ ( "width", "100%" ) ]


fullHeightStyle =
    Hattr.style [ ( "height", "100%" ) ]


spreadStyle style_ =
    case style_ of
        "even" ->
            Hattr.style [ ( "justify-content", "space-evenly" ) ]

        "full" ->
            Hattr.style [ ( "justify-content", "space-between" ) ]

        "center" ->
            Hattr.style [ ( "justify-content", "center" ) ]

        _ ->
            Hattr.style [ ( "justify-content", "flex-start" ) ]


rowStyle =
    Hattr.style
        [ ( "display", "flex" )
        , ( "flex-direction", "row" )
        ]


pointerStyle =
    Hattr.style
        [ ( "cursor", "pointer" ) ]


sysFontStyle =
    Hattr.style
        [ ( "font-family", "-apple-system, BlinkMacSystemFont, \"Segoe UI\", \"Roboto\", \"Oxygen\", \"Ubuntu\", \"Cantarell\", \"Fira Sans\", \"Droid Sans\", \"Helvetica Neue\", sans-serif" ) ]


darkBandStyle =
    Hattr.style
        [ ( "background-color", "#333333" )
        , ( "color", "#dddddd" )
        ]


bttnStyle =
    Hattr.style
        [ ( "background-color", "#00a4bb" )
        , ( "color", "#fff" )
        , ( "padding", "5px 30px 5px 30px" )
        ]


smallText =
    Hattr.style [ ( "font-size", "0.7em" ) ]


root : Model -> Html.Html Msg
root model =
    div
        [ columnStyle
        , spreadStyle "full"
        , fullHeightStyle
        , sysFontStyle
        ]
        [ titleBar
        , drinkAndIndicator model
        , configurator model
        ]


titleBar =
    div [ Hattr.style [ ( "padding-top", "40px" ) ] ] [ text "INEBRIATVS" ]


drinkAndIndicator model =
    div
        [ columnStyle ]
        [ indicator model
        , drink
        ]


indicator model =
    div
        [ rowStyle ]
        (List.map
            (\n -> indicatorLight model.lightsLit n)
            (List.range 0 (model.lightsTotal - 1))
        )


indicatorLight : Float -> Int -> Html.Html Msg
indicatorLight lit n =
    if toFloat n < lit then
        svg
            [ Hattr.style
                [ ( "viewBox", "0 0 10 10" )
                , ( "height", "15px" )
                , ( "width", "15px" )
                ]
            ]
            [ Svg.circle
                [ fill (lightColour n)
                , cx "5"
                , cy "5"
                , r "4"
                , stroke "black"
                , strokeWidth "1"
                ]
                []
            ]
    else
        svg
            [ Hattr.style
                [ ( "viewBox", "0 0 10 10" )
                , ( "height", "15px" )
                , ( "width", "15px" )
                ]
            ]
            [ Svg.circle
                [ fill "#ffffff"
                , cx "5"
                , cy "5"
                , r "4"
                , stroke "black"
                , strokeWidth "1"
                ]
                []
            ]


lightColour : Int -> String
lightColour n =
    if n < 4 then
        "#0000ff"
    else if n < 7 then
        "#ffd700"
    else
        "#ff0000"


drink =
    div
        [ pointerStyle
        , onClick Types.GetTimeAndDrink
        , bttnStyle
        ]
        [ text "BIBE" ]


configurator model =
    if model.configOpen then
        configuratorOpen model
    else
        configuratorClosed model


configuratorOpen model =
    div
        [ columnStyle
        , darkBandStyle
        , fullWidthStyle
        , Hattr.style [ ( "padding-bottom", "20px" ) ]
        ]
        [ div
            [ onClick Types.ToggleConfig
            , pointerStyle
            , Hattr.style [ ( "padding", "20px 0 20px 0" ) ]
            ]
            [ text "CONFIGVRA" ]
        , configuratorDrinkIndexSetter model
        , configuratorDrinkMode model
        ]


configuratorDrinkMode model =
    div
        [ rowStyle
        , smallText
        ]
        [ div
            [ Hattr.style [ ( "margin-right", "20px" ) ] ]
            [ text "drink mode" ]
        , Html.select
            [ onInput Types.SetMode ]
            (List.map
                (\m -> Html.option [ value (Types.modeString m) ] [ text (Types.modeString m) ])
                [ Types.PercentageClickFourOz, Types.WorkDrinks ]
            )
        ]


configuratorDrinkIndexSetter model =
    div
        [ rowStyle
        , smallText
        ]
        [ div
            [ Hattr.style [ ( "margin-right", "20px" ) ] ]
            [ text "drink offset" ]
        , input
            [ Hattr.type_ "range"
            , Hattr.min "0"
            , Hattr.max "100"
            , Hattr.value <| toString (model.offset * 50)
            , onInput Types.SetOffset
            ]
            []
        , div
            [ Hattr.style [ ( "width", "20px" ) ] ]
            [ text (toString model.offset) ]
        ]


configuratorClosed model =
    div
        [ darkBandStyle
        , fullWidthStyle
        , columnStyle
        ]
        [ div
            [ onClick Types.ToggleConfig
            , pointerStyle
            , Hattr.style [ ( "padding", "10px 0 10px 0" ) ]
            ]
            [ text "CONFIGVRA" ]
        ]

module View exposing (..)

import Html exposing (div, input, text, p)
import Html.Attributes as Hattr exposing (class, min, max, value, type_, style)
import Html.Events exposing (onClick, onInput)

import Svg exposing (svg)
import Svg.Attributes as Sattr exposing (..)

import List exposing (map)

import Types exposing (Model, Msg)


columnStyle =
  Hattr.style
    [ ( "display", "flex" )
    , ( "flex-direction", "column" )
    , ( "align-items", "center" )
    ]

rowStyle =
  Hattr.style
    [ ( "display", "flex" )
    , ( "flex-direction", "row" )
    ]

pointerStyle =
  Hattr.style
    [ ( "cursor", "pointer" ) ]


root : Model -> Html.Html Msg
root model =
  div
    [ columnStyle ]
    [ titleBar
    , indicator model
    , drink
    , configurator model ]
  -- Element.viewport stylesheet <|
  --   column Main
  --     [ Element.Attributes.height <| fill 1 ]
  --     [ titleBar
  --     , indicator model
  --     , drink
  --     , configurator model ]


titleBar =
  div [] [ text "INEBRIATVS" ]


indicator model =
  div
    [ rowStyle ]
    ( List.map
        ( \n -> indicatorLight model.lightsLit n  )
        ( List.range 0 ( model.lightsTotal - 1 ) ) )



indicatorLight : Float -> Int  -> Html.Html Msg
indicatorLight lit n =
  if ( toFloat n ) < lit then
    svg
      [ Hattr.style
          [ ( "viewBox", "0 0 10 10" )
          , ( "height", "15px" ) ]
      ]
      [ Svg.circle
          [ fill ( lightColour n )
          , cx "5"
          , cy "5"
          , r "4"
          , stroke "black"
          , strokeWidth "1"]
          []
      ]
  else
    svg
      [ Hattr.style
          [ ( "viewBox", "0 0 10 10" )
          , ( "height", "15px" ) ]
      ]
      [ Svg.circle
          [ fill "#ffffff"
          , cx "5"
          , cy "5"
          , r "4"
          , stroke "black"
          , strokeWidth "1"]
          []
      ]

lightColour : Int -> String
lightColour n =
  if n < 4 then
    "#0000ff"
  else if n < 7 then
    "#ffff00"
  else
    "#ff0000"

drink =
  div
    [ pointerStyle
    , onClick Types.GetTimeAndDrink ]
    [ text "BIBE" ]
  -- el Drink [ onClick Types.GetTimeAndDrink ] <| Element.button ( el Drink [] ( Element.text "BIBE" ) )


configurator model =
  if model.configOpen then
    configuratorOpen model
  else
    configuratorClosed model


configuratorOpen model =
  div
    [ columnStyle ]
    [ div
        [ onClick Types.ToggleConfig
        , pointerStyle ]
        [ text "CONFIGVRA" ]
    , configuratorDrinkIndexSetter model ]


  -- column Configurator
  --   []
  --   [ el None [ onClick Types.ToggleConfig] ( Element.text "CONFIGVRA")
  --   , el None [] ( Element.text ( toString model.offset ))
  --   , configuratorDrinkIndexSetter model
  --   ]


configuratorDrinkIndexSetter model =
  div
    [ rowStyle ]
    [ text "drink offset"
    , input
        [ Hattr.type_ "range"
        , Hattr.min "0"
        , Hattr.max "100"
        , Hattr.value <| toString ( model.offset * 50 )
        , onInput Types.SetOffset ] []
    , text ( toString model.offset )
    ]

  -- row ConfiguratorSlider
  --   []
  --   [ Element.html (
  --     input
  --     [ type_ "range"
  --     , min "0"
  --     , max "100"
  --     , value <| toString ( model.offset * 50 )
  --     , onInput Types.SetOffset ] [] )
  --   ]


configuratorClosed model =
  div
    [ onClick Types.ToggleConfig
    , pointerStyle ]
    [ text "CONFIGVRA" ]
  -- el Configurator [ onClick Types.ToggleConfig] ( Element.text "CONFIGVRA")

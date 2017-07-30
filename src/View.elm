module View exposing (..)

import Color
import Element exposing (..)
import Element.Attributes exposing (..)
import Element.Events exposing (onClick)
import Style exposing (..)
import Style.Border as Border
import Style.Color as Color

import Html exposing (Html)
import Html.Attributes exposing (class)
import List exposing (map)
import Types exposing (Model, Msg)


-- using http://package.elm-lang.org/packages/mdgriffith/style-elements/3.2.3


type Styles
  = None
  | Main
  | Indicator
  | Configurator
  | Light
  | LitLight
  | Drink


stylesheet : StyleSheet Styles variation
stylesheet =
  Style.stylesheet
    [ style None []
    , style Main
      [ Border.all 1
      , Color.text Color.darkCharcoal
      , Color.background Color.white
      ]
    , style Indicator
      [ Border.all 1
      ]
    , style Configurator
      [ Border.all 1
      , Style.cursor "pointer"
      ]
    , style Light
      [ Border.all 1
      ]
    , style LitLight
      [ Border.all 1
      ,  Color.background Color.darkCharcoal
      ]
    , style Drink
      [ Style.cursor "pointer"
      ]
    ]


root : Model -> Html Msg
root model =
  Element.viewport stylesheet <|
    column Main
      [ Element.Attributes.height <| fill 1 ]
      [ titleBar
      , indicator model
      , drink
      , configurator model ]


titleBar =
  el None [] ( Element.text "INEBRIATVS" )


indicator model =
  row Indicator
    []
    ( List.map ( \n -> indicatorLight model.lightsLit n  ) ( List.range 0 ( model.lightsTotal - 1 ) ) )


indicatorLight : Float -> Int  -> Element Styles variation msg
indicatorLight lit n =
  if ( toFloat n ) < lit then
    circle 10 LitLight [] <| el None [] ( Element.text "" )
  else
    circle 10 Light [] <| el None [] ( Element.text "" )


drink =
  el Drink [ onClick Types.GetTimeAndDrink ] <| Element.button ( el Drink [] ( Element.text "BIBE" ) )


configurator model =
  if model.configOpen then
    configuratorOpen model
  else
    configuratorClosed model


configuratorOpen model =
  column Configurator
    []
    [ el None [ onClick Types.ToggleConfig] ( Element.text "CONFIGVRA")
    , el None [] ( Element.text ( toString model.offset ))
    ]


configuratorClosed model =
  el Configurator [ onClick Types.ToggleConfig] ( Element.text "CONFIGVRA")

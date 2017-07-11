module Main exposing (..)

import Html exposing (program)
import State
import Types
import View


main : Program Never Types.Model Types.Msg
main =
    program
        { init = State.init
        , update = State.update
        , subscriptions = State.subscriptions
        , view = View.root
        }



-- http://blog.jenkster.com/2016/04/how-i-structure-elm-apps.html

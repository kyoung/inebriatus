module App exposing (main)

-- http://blog.jenkster.com/2016/04/how-i-structure-elm-apps.html

import Html exposing(program)
import State
import View
import Types


main : Program Never Types.Model Types.Msg
main =
    program
        { init = State.init
        , update = State.update
        , subscriptions = State.subscriptions
        , view = View.root
        }

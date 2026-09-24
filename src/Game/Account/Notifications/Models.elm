module Game.Account.Notifications.Models exposing (..)

import Game.Account.Notifications.Shared exposing (..)
import Game.Meta.Types.Notifications exposing (..)


type alias Model =
    Notifications Content


initialModel : Model
initialModel =
    empty

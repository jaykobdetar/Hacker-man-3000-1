module Apps.BounceManager.Config exposing (..)

import Apps.BounceManager.Messages exposing (..)
import Core.Flags exposing (Flags)
import Game.Account.Bounces.Models as Bounces
import Game.Account.Database.Models as Database
import Game.Meta.Types.Desktop.Apps exposing (Reference)


type alias Config msg =
    { toMsg : Msg -> msg
    , flags : Flags
    , batchMsg : List msg -> msg
    , awaitEvent : String -> ( String, msg ) -> msg
    , reference : Reference
    , bounces : Bounces.Model
    , database : Database.Model
    , accountId : String
    , onRequestBounceReload : String -> Reference -> msg
    , onWaitForBounce : String -> Reference -> msg
    }

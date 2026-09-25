module Apps.FloatingHeads.Config exposing (..)

import Apps.Browser.Shared as Browser
import Apps.FloatingHeads.Messages exposing (..)
import Apps.Params as AppParams exposing (AppParams)
import Game.Meta.Types.Desktop.Apps exposing (Reference)
import Game.Storyline.Emails.Config as Emails
import Game.Storyline.Models as Storyline
import Game.Storyline.Shared exposing (ContactId, Reply)
import Html exposing (Attribute)


type alias Config msg =
    { toMsg : Msg -> msg
    , batchMsg : List msg -> msg
    , reference : Reference
    , draggable : Attribute msg
    , story : Storyline.Model
    , username : String
    , onReply : ContactId -> Reply -> msg
    , onCloseApp : msg
    , onOpenApp : AppParams -> msg
    }


contentConfig : Config msg -> Emails.Config msg
contentConfig config =
    { username = config.username
    , onOpenBrowser =
        Browser.OpenAtUrl
            >> AppParams.Browser
            >> config.onOpenApp
    }

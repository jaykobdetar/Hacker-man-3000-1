module OS.Toasts.Config exposing (..)

import Apps.Params as AppParams exposing (AppParams)
import Game.Account.Notifications.Config as AccountNotifications
import Game.Meta.Types.Context exposing (Context)
import Game.Meta.Types.Desktop.Apps as DesktopApp exposing (DesktopApp(..))
import Game.Servers.Notifications.Config as ServerNotifications
import Game.Servers.Shared exposing (CId)
import OS.Toasts.Messages exposing (..)


type alias Config msg =
    { toMsg : Msg -> msg
    , batchMsg : List msg -> msg
    , activeGatewayCId : CId
    , onOpenApp : AppParams -> CId -> msg
    , onNewApp : DesktopApp -> Maybe Context -> Maybe AppParams -> CId -> msg
    }


accountActionConfig : Config msg -> AccountNotifications.ActionConfig msg
accountActionConfig config =
    { batchMsg = config.batchMsg
    , openThunderbird =
        config.onNewApp Email Nothing Nothing config.activeGatewayCId
    }


serverActionConfig : Config msg -> ServerNotifications.ActionConfig msg
serverActionConfig config =
    { batchMsg = config.batchMsg
    , openTaskManager =
        config.onNewApp TaskManager Nothing Nothing config.activeGatewayCId
    , openHackedDatabase =
        config.onNewApp DBAdmin Nothing Nothing config.activeGatewayCId
    , openExplorerInFile =
        -- TODO: Explorer params
        \_ -> config.onNewApp Explorer Nothing Nothing config.activeGatewayCId
    }

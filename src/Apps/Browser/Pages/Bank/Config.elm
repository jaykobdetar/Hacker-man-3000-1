module Apps.Browser.Pages.Bank.Config exposing (Config)

import Apps.Browser.Pages.Bank.Messages exposing (..)
import Game.Account.Finances.Requests.Login as LoginRequest
import Game.Account.Finances.Requests.Transfer as TransferRequest


type alias Config msg =
    { toMsg : Msg -> msg
    , onLogin : LoginRequest.Payload -> msg
    , onTransfer : TransferRequest.Payload -> msg
    , onLogout : msg
    }

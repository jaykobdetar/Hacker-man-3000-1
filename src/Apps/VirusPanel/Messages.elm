module Apps.VirusPanel.Messages exposing (Msg(..))

import Apps.VirusPanel.Models exposing (..)
import Game.Account.Database.Shared exposing (..)
import Game.Meta.Types.Network exposing (NIP)


type Msg
    = GoTab MainTab
    | SetModal (Maybe ModalAction)
    | ChangeActiveVirus NIP
    | SetActiveVirus (Maybe String)
    | Select (Maybe CollectBehavior)
    | Collect
    | Check NIP
    | CheckAll
    | HandleCollected (Result CollectWithBankError ())

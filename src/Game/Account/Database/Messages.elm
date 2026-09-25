module Game.Account.Database.Messages exposing (Msg(..))

import Events.Account.Handlers.ServerPasswordAcquired as ServerPasswordAcquired
import Events.Account.Handlers.VirusCollected as VirusCollected
import Game.Account.Database.Models
    exposing
        ( HackedBankAccount
        , HackedBankAccountID
        )


type Msg
    = HandlePasswordAcquired ServerPasswordAcquired.Data
    | HandleDatabaseAccountRemoved HackedBankAccountID
    | HandleDatabaseAccountUpdated HackedBankAccountID HackedBankAccount
    | HandleCollectedVirus VirusCollected.Data

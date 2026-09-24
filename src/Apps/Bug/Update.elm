module Apps.Bug.Update exposing (update)

import Apps.Bug.Config exposing (..)
import Apps.Bug.Messages as Hackerbug exposing (Msg(..))
import Apps.Bug.Models exposing (Model)
import Core.Error as Error
import Game.Account.Notifications.Shared as AccountNotifications
import Native.Panic
import Utils.React as React exposing (React)


type alias UpdateResponse msg =
    ( Model, React msg )


update :
    Config msg
    -> Hackerbug.Msg
    -> Model
    -> UpdateResponse msg
update config msg model =
    case msg of
        -- -- Context
        DummyToast ->
            onDummyToast config model

        PoliteCrash ->
            onPoliteCrash config model

        UnpoliteCrash ->
            onUnpoliteCrash model


onDummyToast : Config msg -> Model -> UpdateResponse msg
onDummyToast { onAccountToast } model =
    AccountNotifications.Generic "Hi" "Hello"
        |> onAccountToast
        |> React.msg
        |> (,) model


onPoliteCrash : Config msg -> Model -> UpdateResponse msg
onPoliteCrash { onPoliteCrash } model =
    "This is a polite crash."
        |> Error.fakeTest
        |> onPoliteCrash
        |> React.msg
        |> (,) model


onUnpoliteCrash : Model -> UpdateResponse msg
onUnpoliteCrash model =
    "This is an unpolite crash."
        |> Error.fakeTest
        |> uncurry Native.Panic.crash

module Core.View exposing (view)

import Core.Config exposing (..)
import Core.Error as Error
import Core.Messages exposing (..)
import Core.Models exposing (..)
import Core.Panic as Panic
import Game.Account.Models as Account
import Game.Models as Game
import Html exposing (..)
import Landing.View as Landing
import OS.View as OS
import Setup.View as Setup


view : Model -> Html Msg
view model =
    case model.state of
        Home home ->
            Landing.view (landingConfig model.windowLoaded model.flags)
                home.landing

        Setup setup ->
            onSetup setup model

        Play play ->
            onPlay play model

        Panic code message ->
            Panic.view code message


onSetup : SetupModel -> Model -> Html Msg
onSetup { game, setup } model =
    Setup.view (setupConfig game.account.id game.account.mainframe game.flags)
        setup


onPlay : PlayModel -> Model -> Html Msg
onPlay { game, os } { contextMenu } =
    let
        volatile_ =
            ( Game.getGateway game
            , Game.getActiveServer game
            )

        ctx =
            Account.getContext <| Game.getAccount game
    in
    case volatile_ of
        ( Just gtw, Just srv ) ->
            OS.view (osConfig game contextMenu ctx srv gtw) os

        ( Nothing, _ ) ->
            "Player doesn't have a Gateway [View.play]"
                |> Error.astralProj
                |> uncurry Panic.view

        ( _, Nothing ) ->
            "Player doesn't have an active server [View.play]"
                |> Error.astralProj
                |> uncurry Panic.view

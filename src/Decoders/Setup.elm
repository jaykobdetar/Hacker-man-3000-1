module Decoders.Setup exposing (..)

import Json.Decode as Decode
    exposing
        ( Decoder
        , Value
        , andThen
        , fail
        , list
        , map
        , string
        , succeed
        )
import Setup.Models as Setup
import Setup.Types as Setup exposing (Page(..))
import Utils.Json.Decode exposing (commonError)


remainingPages : Decoder Setup.Pages
remainingPages =
    map Setup.remainingPages pages


pages : Decoder Setup.Pages
pages =
    list page


page : Decoder Setup.Page
page =
    andThen pageFromString string


pageFromString : String -> Decoder Setup.Page
pageFromString str =
    case str of
        "welcome" ->
            succeed Welcome

        "server" ->
            succeed Mainframe

        "pick_location" ->
            succeed PickLocation

        "choose_theme" ->
            succeed ChooseTheme

        "finish" ->
            succeed Finish

        _ ->
            fail <| commonError "Setup.Models.Page" str

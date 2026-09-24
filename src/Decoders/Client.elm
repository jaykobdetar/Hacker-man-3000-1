module Decoders.Client exposing (setupPages)

import Decoders.Setup
import Json.Decode as Decode exposing (Decoder, field, oneOf, succeed)
import Setup.Types as Setup


setupPages : Decoder Setup.Pages
setupPages =
    Decoders.Setup.remainingPages
        |> field "pages"
        |> field "setup"
        |> field "client"

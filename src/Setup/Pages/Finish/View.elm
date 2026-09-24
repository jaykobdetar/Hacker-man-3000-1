module Setup.Pages.Finish.View exposing (Config, view)

import Html exposing (..)
import Html.CssHelpers
import Html.Events exposing (onClick)
import Setup.Pages.Helpers exposing (withHeader)
import Setup.Resources exposing (..)


{ id, class, classList } =
    Html.CssHelpers.withNamespace prefix


type alias Config msg =
    { onNext : msg, onPrevious : msg }


view : Config msg -> Html msg
view { onNext, onPrevious } =
    withHeader [ class [ StepWelcome ] ]
        [ h2 [] [ text "Good bye!" ]
        , p []
            [ text "It was really good, wasn't it?" ]
        , p []
            [ text "Well.. You're ready to leave now." ]
        , p []
            [ text "Maybe you'll find someone else to help you... Maybe Black Mesa!" ]
        , p []
            [ text "What are you waiting fool? Run, Forrest, run!" ]
        , div []
            [ button [ onClick onPrevious ] [ text "BACK" ]
            , button [ onClick onNext ] [ text "FINISH HIM" ]
            ]
        ]

module Landing.Messages exposing (Msg(..))

import Landing.Login.Messages as Login
import Landing.SignUp.Messages as SignUp


type Msg
    = SignUpMsg SignUp.Msg
    | LoginMsg Login.Msg
    | NoOp

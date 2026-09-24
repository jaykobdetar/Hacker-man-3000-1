module Utils.Json.Decode exposing
    ( commonError
    , date
    , exclusively
    , message
    , optionalMaybe
    , report
    )

import Core.Flags as Flags exposing (Flags)
import Date exposing (Date)
import Json.Decode
    exposing
        ( Decoder
        , andThen
        , fail
        , field
        , map
        , string
        , succeed
        )
import Json.Decode.Pipeline exposing (optional)


date : Decoder Date
date =
    string |> andThen decodeDate


exclusively : a -> Decoder a -> Decoder a
exclusively val =
    andThen (decodeExclusively val)


optionalMaybe : String -> Decoder a -> Decoder (Maybe a -> b) -> Decoder b
optionalMaybe name decoder =
    optional name (map Just decoder) Nothing


message : (String -> Decoder b) -> Decoder b
message =
    flip andThen (field "message" string)


report : String -> Flags -> Result String a -> Result String a
report info flags result =
    case result of
        Err msg ->
            if Flags.isDev flags then
                let
                    _ =
                        Debug.log ("⚠ " ++ info ++ ": \n" ++ msg)
                in
                result

            else
                result

        Ok _ ->
            result


commonError : String -> a -> String
commonError type_ error =
    "Trying to decode "
        ++ type_
        ++ ", but value "
        ++ toString error
        ++ " is not supported."



-- internals


decodeDate : String -> Decoder Date
decodeDate str =
    case Date.fromString str of
        Ok date ->
            succeed date

        Err err ->
            fail err


decodeExclusively : a -> a -> Decoder a
decodeExclusively wanting received =
    if wanting == received then
        succeed wanting

    else
        fail <|
            "A field is requiring a value '"
                ++ toString wanting
                ++ "', but received value '"
                ++ toString received
                ++ "'."

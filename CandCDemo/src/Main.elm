module Main exposing (..)

import Html exposing (Html, text, div, label, input, p, form, button)
import Html.Attributes exposing (src, id, for, value, type_, autocomplete)
import Html.Events exposing (onInput, onSubmit, onClick)


{-
   import Ports exposing (emitFormData, receiveFormData)
   import Models exposing (Model)
-}
---- MODEL ----


type alias Model =
    { firstName : String
    , lastName : String
    }


init : ( Model, Cmd Msg )
init =
    ( Model "" "", Cmd.none )



---- UPDATE ----


type Msg
    = UpdateFirstName String
    | UpdateLastName String
    | SubmitForm
    | ExternalData Model


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateFirstName str ->
            ( { model | firstName = str }, Cmd.none )

        UpdateLastName str ->
            ( { model | lastName = str }, Cmd.none )

        ExternalData m ->
            ( m, Cmd.none )

        SubmitForm ->
            ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    form [ onSubmit SubmitForm ]
        [ p [] [ text "Elm App" ]
        , inputGroup "First Name: " "firstName" model.firstName UpdateFirstName
        , inputGroup "Last Name: " "lastName" model.lastName UpdateLastName
        , button [ type_ "submit" ] [ text "Submit" ]
        ]


inputGroup : String -> String -> String -> (String -> Msg) -> Html Msg
inputGroup lbl idName val msgType =
    div []
        [ label [ for idName ] [ text lbl ]
        , input [ id idName, value val, onInput msgType, autocomplete False ] []
        , p [] [ text val ]
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        }

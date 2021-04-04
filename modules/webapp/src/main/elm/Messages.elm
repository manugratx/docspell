module Messages exposing
    ( Messages
    , fromIso2
    , get
    , toIso2
    )

import Messages.App
import Messages.CollectiveSettingsPage
import Messages.ItemDetailPage
import Messages.LoginPage
import Messages.ManageDataPage
import Messages.NewInvitePage
import Messages.QueuePage
import Messages.RegisterPage
import Messages.UploadPage
import Messages.UserSettingsPage
import UiLanguage exposing (UiLanguage(..))


{-| The messages record contains all strings used in the application.
-}
type alias Messages =
    { lang : UiLanguage
    , iso2 : String
    , label : String
    , flagIcon : String
    , app : Messages.App.Texts
    , collectiveSettings : Messages.CollectiveSettingsPage.Texts
    , login : Messages.LoginPage.Texts
    , register : Messages.RegisterPage.Texts
    , newInvite : Messages.NewInvitePage.Texts
    , upload : Messages.UploadPage.Texts
    , itemDetail : Messages.ItemDetailPage.Texts
    , queue : Messages.QueuePage.Texts
    , userSettings : Messages.UserSettingsPage.Texts
    , manageData : Messages.ManageDataPage.Texts
    }


get : UiLanguage -> Messages
get lang =
    case lang of
        English ->
            gb

        German ->
            de


{-| Get a ISO-3166-1 code of the given lanugage.
-}
toIso2 : UiLanguage -> String
toIso2 lang =
    get lang |> .iso2


{-| Return the UiLanguage from given iso2 code. If the iso2 code is not
known, return Nothing.
-}
readIso2 : String -> Maybe UiLanguage
readIso2 iso =
    let
        isIso lang =
            iso == toIso2 lang
    in
    List.filter isIso UiLanguage.all
        |> List.head


{-| return the language from the given iso2 code. if the iso2 code is
not known, return English as a default.
-}
fromIso2 : String -> UiLanguage
fromIso2 iso =
    readIso2 iso
        |> Maybe.withDefault English



--- Messages Definitions


gb : Messages
gb =
    { lang = English
    , iso2 = "gb"
    , label = "English"
    , flagIcon = "flag-icon flag-icon-gb"
    , app = Messages.App.gb
    , collectiveSettings = Messages.CollectiveSettingsPage.gb
    , login = Messages.LoginPage.gb
    , register = Messages.RegisterPage.gb
    , newInvite = Messages.NewInvitePage.gb
    , upload = Messages.UploadPage.gb
    , itemDetail = Messages.ItemDetailPage.gb
    , queue = Messages.QueuePage.gb
    , userSettings = Messages.UserSettingsPage.gb
    , manageData = Messages.ManageDataPage.gb
    }


de : Messages
de =
    { lang = German
    , iso2 = "de"
    , label = "Deutsch"
    , flagIcon = "flag-icon flag-icon-de"
    , app = Messages.App.de
    , collectiveSettings = Messages.CollectiveSettingsPage.de
    , login = Messages.LoginPage.de
    , register = Messages.RegisterPage.de
    , newInvite = Messages.NewInvitePage.de
    , upload = Messages.UploadPage.de
    , itemDetail = Messages.ItemDetailPage.de
    , queue = Messages.QueuePage.de
    , userSettings = Messages.UserSettingsPage.de
    , manageData = Messages.ManageDataPage.de
    }

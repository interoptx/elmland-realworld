module Auth exposing (User, onPageLoad)

import Api.User
import Auth.Action
import Dict
import Route exposing (Route)
import Route.Path
import Shared


type alias User =
    Maybe Api.User.User


onPageLoad : Shared.Model -> Route () -> Auth.Action.Action User
onPageLoad shared route =
    case shared.signInStatus of
        Shared.NotSignedIn ->
            Auth.Action.loadPageWithUser Nothing

        Shared.SignedInWithToken token ->
            Auth.Action.showLoadingPage
                { title = "Signing in..."
                , body =
                    []
                }

        Shared.SignedInWithUser user ->
            Auth.Action.loadPageWithUser (Just user)

        Shared.FailedToSignIn user ->
            Auth.Action.pushRoute
                { path = Route.Path.Login
                , query = Dict.fromList [ ( "from", route.url.path ) ]
                , hash = Nothing
                }

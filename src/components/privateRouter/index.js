import React from "react";
import { Route, Redirect } from "react-router-dom";
// token
import { getToken } from "../../utils/session";
// console.log(getToken());

const PrivateRouter =({component: Component, ...rest}) => {
    return (
        <Route
          {...rest}
          render={routeProps => (
           getToken() ? <Component {...routeProps} /> : <Redirect to="/" />
          )}
        />
      );
}

export default PrivateRouter;

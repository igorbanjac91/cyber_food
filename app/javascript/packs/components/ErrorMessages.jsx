import React from "react";
import PorpTypes from "prop-types"

import _ from "lodash";

const ErrorMessage = props => {
  const data = _.get(props.errorMessage, "response.data", null)
  const message = _.get(props.errorMessage, "message", null)
  if (data) {
    const keys = Object.keys(data);
    return keys.map(key => {
      return (
        <div key={new Date()} className="alert alert-danger" role="alert">
          <p>{key}</p>
          <ul>
            <li>{data[key].map(message => message)}</li>
          </ul>
        </div>
      )
    })
  } else if (message) {
    return (
      <div className="alert alert-danger" role="alert">
        <p>{message}</p>
      </div>
    );
  } else {
    return (
      <div className="alert alert-danger" role="alert">
        <p>Ther was an error</p>
      </div>
    )
  }
}

export default ErrorMessage

ErrorMessage.prototype = {
  errorMessage: PorpTypes.object.isRequired
};
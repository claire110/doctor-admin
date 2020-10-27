import React from 'react';
import axios from "axios";
import { Redirect } from "react-router-dom";

// GET 
export default class Logout extends React.Component {

  handleLogout = event => {
    event.preventDefault();

    axios.get(`http://localhost:80/doctor-admin/src/api/api?action=logout`,{withCredentials: true})
    
      .then(res => {
        // console.log(res);
        // console.log(res.data);
        console.log(res.status);
        localStorage.removeItem('login');
        localStorage.setItem('previlege', res.data); //test
        // localStorage.setItem('userid', res.data);  //test
        // session
        sessionStorage.removeItem('previlege'); //test
        sessionStorage.removeItem('tokenAdmin'); //test
        this.props.history.push("/index");

      }).catch((error) => {
        console.log(error)
    });
  }

  render() {
    return (
      <div>
        <form onSubmit={this.handleLogout}>
          <label>
          </label>
          <button type="submit">LOGOUT</button>
        </form>
      </div>
    )
  }
}
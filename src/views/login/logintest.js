import React, {Component} from 'react';
// whitelist, redirect.
import{withRouter} from 'react-router-dom';
import axios from "axios";

// ANTD
import { Form, Input, Button, Checkbox } from 'antd';
import { UserOutlined, LockOutlined } from '@ant-design/icons';
import 'antd/dist/antd.css'
// CSS
import "./index.css";
import { validate_password, validate_username } from "../../utils/validate";
// token
import { setToken } from '../../utils/session';

class Login extends React.Component {
    constructor(props) {
      super(props);
      this.state = {
        username: '',
        password: '',
        loading: false
    };
  
      this.handleChange = this.handleChange.bind(this);
      this.handleSubmit = this.handleSubmit.bind(this);
    }
  
    handleChange(evt, field) {
      this.setState({ [field]: evt.target.value });
    } 
  
    handleSubmit(event) {
        event.preventDefault();
    
        const userObject = new FormData();
    
        userObject.append('username', this.state.username);
        userObject.append('password', this.state.password);
      
        axios.post(`http://localhost:80/reacttest/src/api/api?action=login`,userObject, {
          withCredentials:true,
          headers: { 
             'Content-Type': 'multipart/form-data'
          }
        })
    
          .then(res => {
            console.log(res);
            console.log(res.data);
            localStorage.setItem('login', 'Yes');
            localStorage.setItem('previlege', res.data); //test
            // localStorage.setItem('userid', res.data); //test
    
          }).catch((error) => {
            console.log(error)
        });
        this.setState({ username: '', password: ''})
      }
  
    render() {
      return (
        <form onSubmit={this.handleSubmit}>
          <label>
            名字:
            <input type="text" value={this.state.username} onChange={(event)=>this.handleChange(event, "username")} />
          </label>
          <label>
            pass:
            <input type="text" value={this.state.password} onChange={(event)=>this.handleChange(event, "password")} />
          </label>
          <input type="submit" value="提交" />
        </form>
      );
    }
  }

  export default Login 
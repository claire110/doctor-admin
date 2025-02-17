import React, {Component, Fragment} from 'react';
// whitelist, redirect.
import{withRouter} from 'react-router-dom';
import axios from "axios";

// ANTD
import { Form, Input, Button, message } from 'antd';
import { UserOutlined, LockOutlined } from '@ant-design/icons';
import 'antd/dist/antd.css'
// CSS
import "./index.css";
import { validate_password, validate_username } from "../../utils/validate";
// token
import { setToken } from '../../utils/session';
// // encrypt Password
// import CryptoJs from "crypto-js";

class Login extends Component{
    constructor(){
        super();
        this.state = {
            username: '',
            password: '',
            loading: false
        };
        this.handleChange = this.handleChange.bind(this);
        this.onFinish = this.onFinish.bind(this);
    }
    
    onFinish (event){
        const userObject = new FormData();
        this.setState({
            loading: true
        })
    
        userObject.append('username', this.state.username);
        userObject.append('password', this.state.password);
        //userObject.append('password', CryptoJs.MD5( this.state.password).toString);

        // axios.post(`http://localhost:80/doctor-admin/src/api/api?action=login`,userObject, {
        axios.post(`http://localhost:80/doctorbooking/api/api?action=login`,userObject, {
          withCredentials:true,
          headers: { 
             'Content-Type': 'multipart/form-data'
          } 
        })
        .then(res => {
            this.setState({
                loading: false
            })    
            // set token
            setToken(res.data);
            
            //router, redirect to admin page
            this.props.history.push("/index");

            // console.log(res);
            // console.log(res.data);
            console.log(res.status);
            localStorage.setItem('login', 'Yes');
            localStorage.setItem('previlege', res.data); //test
        })
        .catch((error) => {
            this.setState({
                loading: false
            })   
            console.log(error)

            if (error.response.status === 401) {
                message.info("Password or username is incorrect");
            }
            if (error.response.status === 400) {
                message.info("please input a valid username and password");
            }
            if (error.response.status === 501) {
                message.info("Input can not be empty");
            }
            if (error.response.status === 429) {
                message.info("rate limit exceeded");
            }
            
            return error;
        });
        // console.log('Success:', event);
    };
    
    onFinishFailed = errorInfo => {
        console.log('Failed:', errorInfo);
    };

    handleChange (evt, field) {
        this.setState({ [field]: evt.target.value });
    }
    
    render(){
        const {loading}  = this.state;
        return(
            <Fragment >
                <div className="homeLogo">
                        <img alt="homeLogo" src="../logo.png"/>
                </div>
                
                <div className="hompage">
                    <h1>Book Your Doctor Online</h1>
                </div>  
                
                <div className="login">
                    <div className="loginContent">
                        <Form
                            className="loginForm"
                            name="basic"
                            initialValues={{ remember: true }}
                            onFinish={this.onFinish}
                            onFinishFailed={this.onFinishFailed}
                            >
                                {/* <div className="loginPic">
                                    <img alt="homeLogo" src="../1.png"/>
                                </div> */}
                            {/* <h3 className="loginText">Login</h3> */}
                            <Form.Item name="username"
                                rules={[
                                    {required: true, message: 'Please input your username!' },
                                    {pattern: validate_username, message:"Username is invalid, 2 characters at least." }
                                ]}>
                                <Input placeholder="Username" 
                                    prefix={<UserOutlined className="site-form-item-icon" />} 
                                    value={this.state.username}
                                    onChange={(event)=>this.handleChange(event, "username")}
                                />
                            </Form.Item>

                            <Form.Item name="password"
                                rules={[
                                    {required: true, message: 'Please input password!' },
                                    {pattern: validate_password, message:"Password must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters.." }
                                ]}>
                                <Input.Password placeholder="Password"
                                    prefix={<LockOutlined className="site-form-item-icon"/>}
                                    type="password"
                                    value={this.state.password}
                                    onChange={(event)=>this.handleChange(event, "password")}
                                />
                            </Form.Item>
                            {/* 
                            <Form.Item name="remember" valuePropName="checked">
                                <Checkbox>Remember me</Checkbox>
                            </Form.Item> */}

                            <Form.Item>
                                <Button type="primary" 
                                    loading={loading} 
                                    htmlType="submit" 
                                    className="loginFormButton" block> Login
                                </Button>
                            </Form.Item>
                        </Form>
                    </div>
                </div>
            </Fragment>
        ) 
    }
}

export default withRouter(Login);
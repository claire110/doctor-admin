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

class Login extends Component{
    constructor(){
        super();
        this.state = {
            username: '',
            password: '',
            loading: false
        };
        this.handleChange = this.handleChange.bind(this);
    }
    
    onFinish = (event) => {
        const userObject = new FormData();
        this.setState({
            loading: true
        })
    
        userObject.append('username', this.state.username);
        userObject.append('password', this.state.password);
        // userObject.append('password', Cryptojs.MD5(this.state.password).toString());
      
        axios.post(`http://localhost:80/doctor-admin/src/api/api?action=login`,userObject, {
          withCredentials:true,
          headers: { 
             'Content-Type': 'multipart/form-data'
          }
        }).then(res => {
            this.setState({
                loading: false
            })    
            // set token todo server
            // const data = res.data.data
            // console.log(data);
            // setToken(data.token);
            setToken(res.data);
            
            //router, redirect to admin page
            this.props.history.push("/index");

            console.log(res);
            console.log(res.data);
            localStorage.setItem('login', 'Yes');
            localStorage.setItem('previlege', res.data); //test
            // localStorage.setItem('userid', res.data); //test
    
          }).catch((error) => {
            this.setState({
                loading: false
            })    
            console.log(error)
        });
        this.setState({ username: '', password: ''})

        console.log('Success:', event);
    };
    
    onFinishFailed = errorInfo => {
        console.log('Failed:', errorInfo);
    };

    handleChange (evt, field) {
        // check it out: we get the evt.target.name (which will be either "email" or "password")
        // and use it to target the key on our `state` object with the same name, using bracket syntax
        this.setState({ [field]: evt.target.value });
    }
    
    render(){
        const {loading}  = this.state;
        return(
            <div className="loginForm">
                <div className="loginContent">
                    <h4 className="loginText">Login</h4>
                    <Form
                        name="basic"
                        initialValues={{ remember: true }}
                        onFinish={this.onFinish}
                        onFinishFailed={this.onFinishFailed}
                        >
                        {/* <form noValidate autoComplete="off" onSubmit={this.handleSubmit}> */}
                        <Form.Item
                            name="username"
                            rules={[{ required: true, message: 'Please input your username!' },
                            {pattern: validate_username, message:"Username is invalid, 3 characters at least." }
                            //    ({ getFieldValue }) => ({
                            //         validator(rule, value) {
                            //           if (value.length < 3) {
                            //             return Promise.reject("Username is invalid, 3 characters at least.");
                            //           }else{
                            //              return Promise.resolve();
                            //           }
                            //         },
                            //     }),
                        ]}
                        >
                            <Input prefix={<UserOutlined className="site-form-item-icon" />} placeholder="Username" onChange={(event)=>this.handleChange(event, "username")}/>
                        </Form.Item>

                        <Form.Item
                            name="password"
                            rules={[
                                { required: true, message: 'Please input your password!' },
                                // {pattern:/(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}/, message:"Password must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters.." }
                                {pattern: validate_password, message:"Password must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters.." }
                            ]}
                        >
                            <Input.Password prefix={<LockOutlined className="site-form-item-icon"/>}
                            type="password"
                            placeholder="Password"
                            onChange={(event)=>this.handleChange(event, "password")}/>
                        </Form.Item>

                        <Form.Item name="remember" valuePropName="checked">
                            <Checkbox>Remember me</Checkbox>
                        </Form.Item>

                        <Form.Item>
                            <Button type="primary" loading={loading} htmlType="submit" className="loginFormButton" block>
                            Login
                            </Button>
                        </Form.Item>
                    </Form>
                    {/* </form> */}
                </div>
            </div>

        ) 
    }
}

export default withRouter(Login);
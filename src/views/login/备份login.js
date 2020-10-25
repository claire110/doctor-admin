import React, {Component} from 'react';
// ANTD
import { Form, Input, Button, Checkbox } from 'antd';
import { UserOutlined, LockOutlined } from '@ant-design/icons';
import 'antd/dist/antd.css'
// CSS
import "./index.css";
import { validate_password, validate_username } from "../../utils/validate";
// API
import {login} from "../../api/account";


class Login extends Component{
    constructor(){
        super();
        this.state = {};
    }
    
    onFinish = (values) => {
        login().then(response => {
            console.log(response)

        }).catch(error =>{

        })
        console.log('Received values of form', values);
    };
    
    onFinishFailed = errorInfo => {
        console.log('Failed:', errorInfo);
    };
        
    render(){
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
                            <Input prefix={<UserOutlined className="site-form-item-icon" />} placeholder="Username" />
                        </Form.Item>

                        <Form.Item
                            name="password"
                            rules={[
                                { required: true, message: 'Please input your password!' },
                                // {pattern:/(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}/, message:"Password must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters.." }
                                {pattern: validate_password, message:"Password must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters.." }
                            ]}
                        >
                            <Input.Password prefix={<LockOutlined className="site-form-item-icon" />}
                            type="password"
                            placeholder="Password"/>
                        </Form.Item>

                        <Form.Item name="remember" valuePropName="checked">
                            <Checkbox>Remember me</Checkbox>
                        </Form.Item>

                        <Form.Item>
                            <Button type="primary" htmlType="submit" className="loginFormButton" block>
                            Login
                            </Button>
                        </Form.Item>
                    </Form>
                </div>
            </div>

        ) 
    }
}

export default Login;
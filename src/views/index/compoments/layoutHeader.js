import React, { Component, Fragment } from "react";
import axios from "axios";
// import {formateTime} from "../../../components/formateTime"
// antd
import { Row, Col } from 'antd';
import { Button } from 'antd';
import { LogoutOutlined} from '@ant-design/icons';
// css
import "./layoutHeader.css";

class layoutHeader extends Component {
    constructor(props){
        super(props);
        this.state = {
        };
    }
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
                window.location.reload(false);
                // this.props.history.push("/index");

            }).catch((error) => {
                console.log(error)
            });
    }

    render(){
        return(
            <Fragment >
                <Row>
                    <Col span={4}>
                        <h2>
                            <span id="logo">
                                <img alt="logo" src="../logo.png"/>
                            </span>  
                        </h2> 
                    </Col>
                    <Col span={8} offset={12} className="logoutHover">
                        <Button type="text" icon={<LogoutOutlined />} className="logoutButton" onClick={this.handleLogout}>Logout</Button >
                    </Col>
                </Row>
            </Fragment> 
        )
    }
}

export default layoutHeader;
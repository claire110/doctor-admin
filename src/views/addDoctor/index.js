import React, {Component} from 'react';
import axios from "axios";
// ANTD
import { Form, Input, Button, DatePicker, Upload, message} from 'antd';

import { UserOutlined, UploadOutlined, HeartOutlined, MailOutlined, PhoneOutlined,
    ProfileOutlined, StarOutlined, ScheduleOutlined} from '@ant-design/icons';
import 'antd/dist/antd.css'
// CSS
import "./index.css";

class AddDoctor extends Component{
    constructor(){
        super();
        this.state = {
            dfirstname: '',
            dlastname: '',
            ddateofbirth: '',
            demail: '',
            dcontactnumber: '',
            dpicurl: '',
            dintro: '',
            dmedicalcenter: '',
            dareaofspec: '',
            loading: false
        };
        this.handleChange = this.handleChange.bind(this);
    }

    handleChange (evt, field) {
        // check it out: we get the evt.target.name (which will be either "email" or "password")
        // and use it to target the key on our `state` object with the same name, using bracket syntax
        this.setState({ [field]: evt.target.value });
    }
    
    onFinish = event => {
        // event.preventDefault();

        const userObject = new FormData();

        this.setState({
            loading: true
        })

        userObject.append('dfirstname', this.state.dfirstname);
        userObject.append('dlastname', this.state.dlastname);
        userObject.append('ddateofbirth', this.state.ddateofbirth);
        userObject.append('demail', this.state.demail);
        userObject.append('dcontactnumber', this.state.dcontactnumber);
        userObject.append('dpicurl', this.state.dpicurl);
        userObject.append('dintro', this.state.dintro);
        userObject.append('dmedicalcenter', this.state.dmedicalcenter);
        userObject.append('dareaofspec', this.state.dareaofspec);
    
        axios.post(`http://localhost:80/reacttest/src/api/api?action=doctorRegister`,userObject, {
            withCredentials:true,
            headers: { 
                'Content-Type': 'multipart/form-data'
            }
        })
            .then(res => {
                this.setState({
                    loading: false
                })
                // console.log(res);
                // console.log(res.data);
                message.info("Added Successfully");
            })
            .catch((error) => {
                this.setState({
                    loading: false
                })
                console.log(error)
            });
        // this.setState({ doctorid: '', plandate: '', starttime: '', endtime:''})
            console.log('Success:', event);
    }
        
    onFinishFailed = errorInfo => {
        console.log('Failed:', errorInfo);
    };

    // config = {
    //     rules: [{ type: 'object', required: true, message: 'Please select time!' }],
    // };

    normFile = e => {
        console.log('Upload event:', e);
        if (Array.isArray(e)) {
            return e;
        }
        return e && e.filelist;
    };
        
    render(){
        const {loading}  = this.state;
        return(
            <div className="addDoctorForm">
                <div className="addDoctorContent">
                <h2 className="addDoctorText">Doctor Registration</h2>
                    <Form
                        name="basic"
                        initialValues={{ remember: true }}
                        onFinish={this.onFinish}
                        onFinishFailed={this.onFinishFailed}
                        >
                        <Form.Item
                            name="firstName"
                            rules={[{ required: true, message: 'Please input your first name!' }]}
                        >
                            <Input prefix={<UserOutlined className="site-form-item-icon" />} placeholder="First name" 
                                onChange={(event)=>this.handleChange(event, "dfirstname")}/>
                        </Form.Item>

                        <Form.Item
                            name="lastName"
                            rules={[{ required: true, message: 'Please input your last name!' }]}
                        >
                            <Input prefix={<HeartOutlined  className="site-form-item-icon" />} placeholder="Last name" 
                                onChange={(event)=>this.handleChange(event, "dlastname")}/>
                        </Form.Item>

                        <Form.Item name="date-picker" 
                            // rules={[{ required: true, message: 'Please input the date of birth!' }]}
                            label="Date of Birth" {...this.config} >
                            <Input placeholder="Date of Birth"  onChange={(event)=>this.handleChange(event, "ddateofbirth")}/>
                            {/* <DatePicker placeholder="Date of Birth"  onChange={(event)=>this.handleChange(event, "ddateofbirth")}/> */}
                        </Form.Item>

                        <Form.Item
                            name="email"
                            rules={[
                            {
                                type: 'email',
                                message: 'The input is not valid E-mail!',
                            },
                            {
                                required: true,
                                message: 'Please input your E-mail!',
                            },
                            ]}
                        >
                            <Input prefix={<MailOutlined className="site-form-item-icon" />} placeholder="Email"
                                onChange={(event)=>this.handleChange(event, "demail")}/>
                        </Form.Item>

                        <Form.Item
                            name="phone"
                            rules={[
                                // {
                                //     type: 'number',
                                //     message: 'The input is not valid contact number!',
                                // },
                                {   required: true, 
                                    message: 'Please input the contact number!' 
                                },
                            ]}
                        >
                            <Input prefix={<PhoneOutlined className="site-form-item-icon" />} placeholder="Contact Number"
                                onChange={(event)=>this.handleChange(event, "dcontactnumber")}/>
                        </Form.Item>

                        <Form.Item
                            name="intro"
                            rules={[{ required: true, message: 'Please input some introduction!' }]}
                        >
                            <Input prefix={<ProfileOutlined className="site-form-item-icon" />} placeholder="Introduction" 
                                onChange={(event)=>this.handleChange(event, "dintro")}/>
                        </Form.Item>

                        <Form.Item
                            name="medicalCenter"
                            rules={[{ required: true, message: 'Please input medical center name!' }]}
                        >
                            <Input prefix={<ScheduleOutlined className="site-form-item-icon" />} placeholder="Medical Center" 
                                onChange={(event)=>this.handleChange(event, "dmedicalcenter")}/>
                        </Form.Item>

                        <Form.Item
                            name="areaOfInterst"
                            rules={[{ required: true, message: 'Please input area of interst!' }]}
                        >
                            <Input prefix={<StarOutlined className="site-form-item-icon" />} placeholder="Area Of Interest" 
                                onChange={(event)=>this.handleChange(event, "dareaofspec")}/>
                        </Form.Item>

                        <Form.Item
                            name="upload"
                            label="Upload a photo"
                            valuePropName="filelist"
                            getValueFromEvent={this.normFile}
                            // rules={[{ required: true, message: 'Please upload a photo!' }]}
                        >
                            <Input  onChange={(event)=>this.handleChange(event, "dpicurl")}></Input>
                            {/* <Upload name="photo" action="/upload.do" listType="picture" 
                                onChange={(event)=>this.handleChange(event, "dpicurl")}
                            >
                                <Button icon={<UploadOutlined />} >Click to upload</Button>
                            </Upload> */}

                        </Form.Item>


                        <Form.Item>
                            <Button type="primary" loading={loading} htmlType="submit" block>
                            Submit
                            </Button>
                        </Form.Item>
                    </Form>
                </div>
            </div>
        ) 
    }
}

export default AddDoctor;
import React, {Component} from 'react';
import axios from "axios";
// ANTD
import { Form, Input, Button, DatePicker, TimePicker} from 'antd';

import { UserOutlined } from '@ant-design/icons';
import 'antd/dist/antd.css'
// CSS
import "./index.css";

class AddDoctor extends Component{
    constructor(){
        super();
        this.state = {
            doctorid: '',
            plandate: '',
            starttime: '',
            endtime: '',
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
        const userObject = new FormData();
        this.setState({
            loading: true
        })

        userObject.append('doctorid', this.state.doctorid);
        userObject.append('plandate', this.state.plandate);
        userObject.append('starttime', this.state.starttime);
        userObject.append('endtime', this.state.endtime);
      
        axios.post(`http://localhost:80/reacttest/src/api/api?action=apptPlan`,userObject, {
          headers: { 
             'Content-Type': 'multipart/form-data'
          }
        })
          .then(res => {
            this.setState({
                loading: false
            })  
            console.log(res);
            console.log(res.data);
          }).catch((error) => {
            this.setState({
                loading: false
            })  
            console.log(error)
        });
        this.setState({ doctorid: '', plandate: '', starttime: '', endtime:''})

        console.log('Success:', event);
    };
    
    onFinishFailed = errorInfo => {
        console.log('Failed:', errorInfo);
    };

    // config = {
    //     rules: [{ type: 'object', required: true, message: 'Please select time!' }],
    //   };

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
                <h2 className="addDoctorText">Appointment Plan</h2>
                    <Form
                        name="basic"
                        initialValues={{ remember: true }}
                        onFinish={this.onFinish}
                        onFinishFailed={this.onFinishFailed}
                        >
                        <Form.Item
                            name="doctorName"
                            rules={[{ required: true, message: 'Please input doctor name!' }]}
                            label="doctor Name"
                            onChange={(event)=>this.handleChange(event, "doctorid")} 
                        >
                            <Input prefix={<UserOutlined className="site-form-item-icon" />} placeholder="First name" 
                                onChange={(event)=>this.handleChange(event, "doctorid")} />
                        </Form.Item>

                        <Form.Item name="date-picker" 
                            // rules={[{ required: true, message: 'Please input the appointment date!' }]}
                            label="Appointment date" {...this.config}>
                            {/* <DatePicker placeholder="Appointment date"
                            onChange={(event)=>this.handleChange(event, "plandate")} /> */}
                            <Input placeholder="Appointment date"
                            onChange={(event)=>this.handleChange(event, "plandate")} />
                        </Form.Item>

                        <Form.Item 
                            // name="time-picker" 
                            label="TimePicker" 
                            // rules={[{ required: true, message: 'Please input start time!' }]}
                            label="Start time" {...this.config}>
                            {/* <TimePicker  placeholder="Start Time"
                                onChange={(event)=>this.handleChange(event, "starttime")} /> */}
                                <Input  placeholder="Start Time"
                                onChange={(event)=>this.handleChange(event, "starttime")} 
                            />
                        </Form.Item>

                        <Form.Item 
                            // name="time-picker" 
                            label="TimePicker" 
                            rules={[{ required: true, message: 'Please input end time!' }]}
                            label="End time" {...this.config}>
                            {/* <TimePicker  placeholder="End Time"
                                 onChange={(event)=>this.handleChange(event, "endtime")}
                            /> */}
                            <Input  placeholder="End Time"
                                 onChange={(event)=>this.handleChange(event, "endtime")}
                            />
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
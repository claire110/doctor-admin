import React, {Component} from 'react';
import axios from "axios";
// ANTD
import { Form, Input, Button, message, DatePicker, TimePicker} from 'antd';
import { UserOutlined } from '@ant-design/icons';
import 'antd/dist/antd.css'
//VALIDATION
import { validate_date, validate_stime,validate_etime } from "../../utils/validate";
// CSS
import "./index.css";

class apptPlan extends Component{
    constructor(props){
        super(props);
        this.state = {
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

        userObject.append('doctorid', this.props.location.state.doctorid);
        userObject.append('plandate', this.state.plandate);
        userObject.append('starttime', this.state.starttime);
        userObject.append('endtime', this.state.endtime);
      
        axios.post(`http://localhost:80/doctor-admin/src/api/api?action=apptPlan`,userObject, {
            withCredentials:true,
            headers: { 
                'Content-Type': 'multipart/form-data'
            }
        })
        .then(res => {
            this.setState({
                loading: false
            })  
            message.info("Added Successfully");
            console.log(res.status);
            // console.log(res);
            // console.log(res.data);
        })
        .catch((error) => {
            this.setState({
                loading: false
            })  
            console.log(error)

            if (error.response.status === 401) {
                message.info("Please login firstly.");
            }

            if (error.response.status === 400) {
                message.info("Please make sure the input is valid.");
            }

            if (error.response.status === 501) {
                message.info("There are something wrong on the process, please try again..");
            }
        });
        this.setState({ plandate: '', starttime: '', endtime:''})

        console.log('Success:', event);
    };
    
    onFinishFailed = errorInfo => {
        console.log('Failed:', errorInfo);
    };

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
            <div className="apptPlanForm">
                <div className="apptPlanContent">
                <h2 className="apptPlanText">Appointment Plan</h2>
                    <Form
                        layout="vertical"
                        name="basic"
                        initialValues={{ remember: true }}
                        onFinish={this.onFinish}
                        onFinishFailed={this.onFinishFailed}
                        size="large"
                        >
                        {/* <Form.Item
                            name="doctorID"
                            rules={[{ required: true, message: 'Please input doctor name!' }]}
                            label="Doctor ID"
                            onChange={(event)=>this.handleChange(event, "doctorid")} 
                        >
                            <Input prefix={<UserOutlined className="site-form-item-icon" />} placeholder="First name" 
                                onChange={(event)=>this.handleChange(event, "doctorid")} />
                        </Form.Item> */}

                        <Form.Item name="date-picker" 
                            rules={[
                                {required: true, message: 'Please input the appointment date!' },
                                {pattern: validate_date, message:"Please enter a valid date. format: yyyy-mm-dd.."}
                            ]}
                            label="Appointment date" {...this.config}>
                            {/* <DatePicker placeholder="Appointment date"
                            onChange={(event)=>this.handleChange(event, "plandate")} /> */}
                            <Input placeholder="Appointment date"
                            onChange={(event)=>this.handleChange(event, "plandate")} />
                        </Form.Item>

                        <Form.Item 
                            // name="time-picker" 
                            name="startTime" 
                            rules={[
                                {required: true, message: 'Please input start time!' },
                                {pattern: validate_stime, message:"Please enter a valid time. format: HH:mm"}
                            ]}
                            label="Start time" {...this.config}>
                            {/* <TimePicker  placeholder="Start Time"
                                onChange={(event)=>this.handleChange(event, "starttime")} /> */}
                                <Input  placeholder="Start Time"
                                onChange={(event)=>this.handleChange(event, "starttime")} 
                            />
                        </Form.Item>

                        <Form.Item 
                            // name="time-picker" 
                            name="endTime" 
                            rules={[
                                {required: true, message: 'Please input end time!' },
                                {pattern: validate_etime, message:"Please enter a valid time. format: HH:mm"}
                            ]}
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

export default apptPlan;
import React, {Component} from 'react';
import axios from "axios";
// ANTD
import { Form, Input, Button, DatePicker, Upload, message} from 'antd';
import { UserOutlined, UploadOutlined, HeartOutlined, MailOutlined, PhoneOutlined,
    ProfileOutlined, StarOutlined, ScheduleOutlined, InboxOutlined } from '@ant-design/icons';
//VALIDATION
import { validate_name, validate_phone,validate_date } from "../utils/validate";
import 'antd/dist/antd.css'
// CSS

const normFile = e => {
    console.log('Upload event:', e);
    if (Array.isArray(e)) {
      return e;
    }
    return e && e.fileList;
  };

  function handleChangeDate(date, dateString) {
    console.log(date, dateString);
  }

class AddDoctor extends Component{
    constructor(){
        super();
        this.state = {
            dfirstname: '',
            dlastname: '',
            ddateofbirth: '',
            dpicurl: '',
            loading: false
        };
        this.handleChange = this.handleChange.bind(this);
    }

    handleChange (evt, field) {
        // target.name === 'ddateofbirth' ? ddateofbirth : dateString;
        this.setState({ [field]: evt.target.value });
      
    }

    // handleChangeDate(e) {
    //     this.setState({ [e.target.name] : e.target.value });
    //  }
 
    
    
    onFinish = event => {
        // event.preventDefault();
        const userObject = new FormData();

        this.setState({
            loading: true
        })

        userObject.append('dfirstname', this.state.dfirstname);
        userObject.append('dlastname', this.state.dlastname);
        userObject.append('ddateofbirth', this.state.ddateofbirth);
        userObject.append('dpicurl', this.state.dpicurl);

    
        axios.post(`http://localhost:80/doctor-admin/src/api/api?action=doctorRegister`,
        userObject, {
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
            console.log(res.status);
            message.info("Added Successfully");
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
                message.info("There are something wrong on the process, please try again.");
            }
        });
        //this.setState({ dfirstname: '', dlastname: '', ddateofbirth: '', demail:'', dcontactnumber:'', dpicurl:'', dintro:'',  dmedicalcenter:'',  dareaofspec:''})
        console.log('Success:', event);
    }
        
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
            <div className="addDoctorForm">
                <div className="addDoctorContent">
                <h2 className="addDoctorText">Doctor Registration</h2>
                    <Form
                        name="basic"
                        initialValues={{ remember: true }}
                        onFinish={this.onFinish}
                        onFinishFailed={this.onFinishFailed}
                        size="large"
                        >
                        <Form.Item
                            name="firstName"
                            rules={[
                                {required: true, message: 'Please input your first name!' },
                                {pattern: validate_name, message:"Please input a valid firstname, 2 characters at least.."}
                        ]}
                        >
                            <Input prefix={<UserOutlined className="site-form-item-icon" />} placeholder="First name" 
                                onChange={(event)=>this.handleChange(event, "dfirstname")}/>
                        </Form.Item>

                        <Form.Item
                            name="lastName"
                            rules={[
                                {required: true, message: 'Please input your last name!' },
                                {pattern: validate_name, message:"Please input a valid lastname, 2 characters at least."}
                            ]}
                        >
                            <Input prefix={<HeartOutlined  className="site-form-item-icon" />} placeholder="Last name" 
                                onChange={(event)=>this.handleChange(event, "dlastname")}/>
                        </Form.Item>

                        <Form.Item name="date-picker" 
                            rules={[
                                {required: true, message: 'Please input the date of birth!' },
                                ({ getFieldValue }) => ({
                                    validator(role, value){
                                        console.log(value)
                                    }
                                })
                                // {pattern: validate_date, message:"Please enter a valid date. format: yyyy-mm-dd.."}
                            ]}
                            label="Date of Birth" {...this.config} >
                            {/* <Input placeholder="Date of Birth"  onChange={(event)=>this.handleChange(event, "ddateofbirth")}/> */}
                            <DatePicker name="ddateofbirth" placeholder="Date of Birth"  value={this.state.ddateofbirth} />
                        </Form.Item>

                        {/* <Form.Item
                            name="upload"
                            label="Upload a photo"
                            valuePropName="filelist"
                            getValueFromEvent={this.normFile}
                            rules={[{ required: true, message: 'Please upload a photo!' }]}
                        >
                            <Upload name="photo" action="/upload.do" listType="picture" 
                               
                            >
                                <Button icon={<UploadOutlined />} >Click to upload</Button>
                            </Upload>

                        </Form.Item> */}

                        <input type="file" id="myFile" name="filename" onChange={(event)=>this.handleChange(event, "dpicurl")}/>

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
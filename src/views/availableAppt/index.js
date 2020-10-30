import React, { Component, Fragment} from "react";
import axios from "axios";
import { Link } from "react-router-dom";
// antd
import {Form, Input, Button, Table, message, Modal} from "antd";
// css
import "./index.css";



class availableAppt extends Component {
    constructor(props){
        super(props);
        this.state = {

            pageNumber: 1,
            pageSize: 10,
            keyWork:"",

            
            // modal: cancel notification 
            visible:false,
            doctorID:"",

            // table header
            columns:[
                {title:"PlanID", dataIndex:"planID", key:"planID"},
                {title:"First Name", dataIndex:"firstName", key:"firstName"},
                {title:"Last Name", dataIndex:"lastName", key:"lastName"},
                {title:"Medical Center", dataIndex:"medicalCenter", key:"medicalCenter"},
                {title:"Date", dataIndex:"planDate", key:"planDate"},
                {title:"Start Time", dataIndex:"planTimeStart", key:"planTimeStart"},
                {title:"End Time", dataIndex:"planTimeEnd", key:"planTimeEnd"},
                {title:"Management", dataIndex:"management", key:"management", width:250,
                    render:(text, rowData) =>{
                        return(
                            <div>
                                <Button className="planButton" type="primary">
                                    <Link to={{pathname: "/index/apptEdit", 
                                        state:{planid: rowData.planID, doctorid: rowData.doctorID, plandate: rowData.planDate, starttime: rowData.planTimeStart, endtime: rowData.planTimeEnd, firstname: rowData.firstName, lastname: rowData.lastName}}} >Edit</Link>
                                </Button>
                                <Button className="delApptButton" onClick={()=>this.delApptPlan(rowData.planID)} >Delete</Button>
                            </div>
                        )
                    } 
                }   
            ],

            // tabel data
            data:[{},],
           
        };
    }

    // load data 
    componentDidMount() {
        this.loadData();
    }

    // get availabel appt list
    loadData = () => {
        const available = {
            pageNumber: this.state.pageNumber,
            pageSize: this.state.pageSize,
        }
        
        axios.get(`http://localhost:80/doctor-admin/src/api/api?action=availableAppt`,
        {withCredentials:true})
        .then(res => {
            console.log(res.data);
            const available = res.data;
            if(available){
                this.setState({ 
                    data:available 
                });
            }
        })
        .catch((error) => {
            console.log(error)

            if (error.response.status === 204) {
                message.info("Sorry, there are not any doctors' information.");
            }

            if (error.response.status === 401) {
                message.info("Please login firstly.");
            }

            if (error.response.status === 400) {
                message.info("Invalid, The plan is not exist.");
            }
        });
    }

    // delete appt plan
    delApptPlan(planID){
        console.log(planID)
        if(!planID){return false;}
        axios.delete(`http://localhost:80/doctor-admin/src/api/api?action=delApptPlan&planid=${planID}`,{withCredentials:true})
        .then(res => {
            // console.log(res);
            console.log(res.data);
            message.info("Successfully Deleted");

            //refresh page, load data again
            this.loadData();
            
        })
        .catch((error) => {
            console.log(error)

            if (error.response.status === 401) {
                message.info("Please login firstly.");
            }

            if (error.response.status === 501) {
                message.info("The plan does not exist.");
            }

            if (error.response.status === 400) {
                message.info("Invalid, Please select the time you want to delete.");
            }
      });
    }

    render(){
        const { columns, data } = this.state;
        return(
            <Fragment>
                
                {/* security, noopener */}
                {/* <a className="addDoctor" style={{display: "table-cell"}} 
                   href = "/index/add" target = "_blank" rel = "noopener noreferrer"> */}

                {/* <a className="addDoctor" style={{display: "table-cell"}} href = "/index/add">
                    <Button className="addDoctorButton" type="primary" htmlType="submit">
                        Add New Doctor
                    </Button>
                </a> */}

                <Table rowKey="planID" columns={columns} dataSource={data} bordered></Table>

            </Fragment>
        )
    }
}

export default availableAppt;
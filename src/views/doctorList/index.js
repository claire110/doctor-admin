import React, { Component, Fragment} from "react";
import axios from "axios";
import { Link } from "react-router-dom";
// antd
import {Button, Table, message} from "antd";
// css
import "./index.css";
// // api
// import { getDoctorList, deleteDoctor } from "../../services/index";

class DoctorList extends Component {
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
                {title:"DoctorID", dataIndex:"doctorID", key:"doctorIdMenu", width:100},
                {title:"First Name", dataIndex:"firstName", key:"firstName"},
                {title:"Last Name", dataIndex:"lastName", key:"lastName"},
                {title:"Medical Center", dataIndex:"medicalCenter", key:"medicalCenter"},
                {title:"Management", dataIndex:"management", key:"management", width:200,
                    render:(text, rowData) =>{
                        return(
                            <div>
                                <Button className="delDoctorButton" onClick={()=>this.delDoctor(rowData.doctorID)} >Delete</Button>
                                <Button className="planButton" type="primary">
                                    <Link to={{pathname: "/index/plan", state:{doctorid: rowData.doctorID}}} >Plan</Link>
                                </Button>
                            </div>
                        )
                    } 
                }   
            ],

            // tabel data
            data:[],   
        };
    }

    // load data 
    componentDidMount() {
        this.loadData();
    }

    // get doctor list
    loadData = () => {
        const doctors = {
            pageNumber: this.state.pageNumber,
            pageSize: this.state.pageSize,
        }
        
        axios.get(`http://localhost:80/doctor-admin/src/api/api?action=readDoctorName`,{withCredentials:true})
        // getDoctorList()
        .then(res => {
            console.log(res.data);
            const doctors = res.data;

            if(doctors){
                this.setState({ 
                    data:doctors 
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
        });
    }

    // delete doctor
    delDoctor(doctorID){
        console.log(doctorID)
        if(!doctorID){
            message.info("The doctor's information does not exist");
            return false;
        }

        // deleteDoctor()
        axios.delete(`http://localhost:80/doctor-admin/src/api/api?action=delDoctor&doctorid=${doctorID}`,{withCredentials:true})
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
                message.info("The doctor's information does not exist.");
            }

            if (error.response.status === 400) {
                message.info("Invalid, Please select the doctor you want to delete.");
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
                
                <a className="addDoctor" style={{display: "table-cell"}} href = "/index/add">
                    <Button className="addDoctorButton" type="primary" htmlType="submit">
                        Add New Doctor
                    </Button>
                </a>
            

                <Table rowKey="doctorID" columns={columns} dataSource={data} bordered />

            </Fragment>
        )
    }
}


export default DoctorList;
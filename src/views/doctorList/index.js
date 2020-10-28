import React, { Component, Fragment} from "react";
import axios from "axios";
import { Link } from "react-router-dom";
// antd
import {Form, Input, Button, Table, message, Modal} from "antd";
// css
import "./index.css";



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
                {title:"DoctorID", dataIndex:"doctorID", key:"doctorID", width:100},
                {title:"First Name", dataIndex:"firstName", key:"firstName"},
                {title:"Last Name", dataIndex:"lastName", key:"lastName"},
                {title:"Medical Center", dataIndex:"medicalCenter", key:"medicalCenter"},
                {title:"Management", dataIndex:"management", key:"management", width:250,
                    render:(text, rowData) =>{
                        return(
                            <div>
                                
                                <Button type="primary">Edit</Button>
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
            data:[{},],
           
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
        
        axios.get(`http://localhost:80/doctor-admin/src/api/api?action=readDoctorName`,
        {withCredentials:true})
        .then(res => {
            console.log(res.data);
            const doctors = res.data;

            if(doctors){
                this.setState({ 
                    data:doctors 
                });
            }
           
        }).catch((error) => {
            // message.error('error message info' + error.message)
            console.log(error)
        });
    }

    // delete doctor
    delDoctor(doctorID){
        console.log(doctorID)
        if(!doctorID){return false;}
        axios.delete(`http://localhost:80/doctor-admin/src/api/api?action=delDoctor&doctorid=${doctorID}`,{withCredentials:true})
        .then(res => {
            // console.log(res);
            console.log(res.data);
            message.info("Successfully Deleted");

            //refresh page, load data again
            this.loadData();
            
        }).catch((error) => {
            console.log(error)
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

                <Table rowKey="doctorID" columns={columns} dataSource={data} bordered></Table>

            </Fragment>
        )
    }
}

export default DoctorList;
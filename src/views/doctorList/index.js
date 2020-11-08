import React, { Component, Fragment} from "react";
import axios from "axios";
import { Link } from "react-router-dom";
// antd
import {Button, Table, message} from "antd";
import { UsergroupAddOutlined, DeleteOutlined, SnippetsOutlined } from '@ant-design/icons';
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
                {title:"DoctorID", dataIndex:"doctorID", key:"doctorIdMenu", width:70, fixed: 'left',responsive: ['md'],
                    defaultSortOrder: 'descend',
                    sorter: (a, b) => a.doctorID - b.doctorID,
                 
                 
                },
                {title:"First Name", dataIndex:"firstName", key:"firstName",  width: 80, fixed: 'left',
                    sorter: (a, b) => a.firstName.localeCompare(b.firstName),
                },
                {title:"Last Name", dataIndex:"lastName", key:"lastName", width: 80, fixed: 'left',
                    sorter: (a, b) => a.lastName.localeCompare(b.lastName),
                },
                {title:"Medical Center", dataIndex:"medicalCenter", key:"medicalCenter", width: 100,
                    sorter: (a, b) => a.medicalCenter.localeCompare(b.medicalCenter),
                },
                {title:"Date Of Birth", dataIndex:"dateOfBirth", key:"dateOfBirth", width: 100,
                    sorter: (a, b) => new Date(a.dateOfBirth) - new Date(b.dateOfBirth),
                },
                {title:"Email", dataIndex:"email", key:"email", width: 100,
                    sorter: (a, b) => a.email.localeCompare(b.email),
                },
                {title:"Contact Number", dataIndex:"contactNumber", key:"contactNumber", width: 100},
                {title:"area Of Spec", dataIndex:"areaOfSpec", key:"areaOfSpec", width: 100},
                {title:"Introduction", dataIndex:"Intro", key:"Intro", width: 200},
                {title:"Management", dataIndex:"management", key:"management", width:180, fixed: 'right',
                    render:(text, rowData) =>{
                        return(
                            <div>
                                <Button className="planButton" type="primary" icon={<SnippetsOutlined />}>
                                    <Link to={{pathname: "/index/plan", state:{doctorid: rowData.doctorID}}}><span className="plan" >Plan</span></Link>
                                </Button>
                                <Button className="delDoctorButton" icon={<DeleteOutlined />} onClick={()=>this.delDoctor(rowData.doctorID)} >Delete</Button>
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
        // const doctors = {
        //     pageNumber: this.state.pageNumber,
        //     pageSize: this.state.pageSize,
        // }
        
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
                    <Button className="addDoctorButton" type="primary" icon={<UsergroupAddOutlined />} htmlType="submit">
                        Add New Doctor
                    </Button>
                </a>
            
                <h2>Doctor List</h2>
                <Table rowKey="doctorID" columns={columns} dataSource={data} scroll={{ x: 1500, y: 600 }}/>

            </Fragment>
        )
    }
}


export default DoctorList;
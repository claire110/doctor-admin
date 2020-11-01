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
                {title:"ratingID", dataIndex:"ratingID", key:"ratingID"},
                {title:"Doctor First Name", dataIndex:"firstName", key:"firstName"},
                {title:"Doctor Last Name", dataIndex:"lastName", key:"lastName"},
                {title:"Scale", dataIndex:"scale", key:"scale"},
                {title:"content", dataIndex:"content", key:"content"},
                {title:"Rating Time", dataIndex:"ratingTime", key:"ratingTime"},
                {title:"Appointment Date", dataIndex:"planDate", key:"planDate"},
                {title:"Start Time", dataIndex:"planTimeStart", key:"planTimeStart"},
                {title:"Management", dataIndex:"management", key:"management", width:125,
                    render:(text, rowData) =>{
                        return(
                            <div>
                                <Button className="ratingButton" type="primary" htmlType="submit" onClick={()=>this.delRating(rowData.ratingID)} >Delete</Button>
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

    // get raing list
    loadData = () => {
        const allRatings = {
            pageNumber: this.state.pageNumber,
            pageSize: this.state.pageSize,
        }
        
        axios.get(`http://localhost:80/doctor-admin/src/api/api?action=allRatings`,
        {withCredentials:true})
        .then(res => {
            console.log(res.data);
            const allRatings = res.data;

            if(allRatings){
                this.setState({ 
                    data:allRatings 
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

    // delete rating
    delRating(ratingID){
        console.log(ratingID)
        if(!ratingID){return false;}
        axios.delete(`http://localhost:80/doctor-admin/src/api/api?action=adminDelRating&ratingid=${ratingID}`,{withCredentials:true})
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
                message.info("The rating does not exist.");
            }

            if (error.response.status === 400) {
                message.info("Invalid, Please select the rating you want to delete.");
            }
      });
    }

    render(){
        const { columns, data } = this.state;
        return(
            <Fragment>
                <Table rowKey="ratingID" columns={columns} dataSource={data} bordered></Table>
            </Fragment>
        )
    }
}

export default DoctorList;
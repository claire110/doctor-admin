import React, { Component, Fragment} from "react";
import axios from "axios";
// antd
import {Button, Table, message} from "antd";
import { DeleteFilled} from '@ant-design/icons';
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
                {title:"ratingID", dataIndex:"ratingID", key:"ratingID", responsive: ['md'],
                    defaultSortOrder: 'descend',
                    sorter: (a, b) => a.ratingID - b.ratingID,
                },
                {title:"Doctor First Name", dataIndex:"firstName", key:"firstName",
                    sorter: (a, b) => a.firstName.localeCompare(b.firstName),
                },
                {title:"Doctor Last Name", dataIndex:"lastName", key:"lastName", responsive: ['md'],
                    sorter: (a, b) => a.lastName.localeCompare(b.lastName),
                },
                {title:"Scale", dataIndex:"scale", key:"scale", responsive: ['md'],
                    sorter: (a, b) => a.ratingID - b.ratingID,
                },
                {title:"content", dataIndex:"content", key:"content", responsive: ['md']},
                {title:"Rating Time", dataIndex:"ratingTime", key:"ratingTime", responsive: ['md'],
                    sorter: (a, b) => new Date(a.ratingTime) - new Date(b.ratingTime),
                },
                {title:"Appointment Date", dataIndex:"planDate", key:"planDate", responsive: ['md'],
                    sorter: (a, b) => new Date(a.planDate) - new Date(b.planDate),
                },
                {title:"Start Time", dataIndex:"planTimeStart", key:"planTimeStart", responsive: ['md']},
                {title:"Management", dataIndex:"management", key:"management", width:125,
                    render:(text, rowData) =>{
                        return(
                            <div>
                                <Button className="ratingButton" type="primary" icon={<DeleteFilled />} htmlType="submit" onClick={()=>this.delRating(rowData.ratingID)} >Delete</Button>
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
        // const allRatings = {
        //     pageNumber: this.state.pageNumber,
        //     pageSize: this.state.pageSize,
        // }
        
        // axios.get(`http://localhost:80/doctor-admin/src/api/api?action=allRatings`,
        axios.get(`http://localhost:80/doctorbooking/api/api?action=allRatings`,
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
        // axios.delete(`http://localhost:80/doctor-admin/src/api/api?action=adminDelRating&ratingid=${ratingID}`,{withCredentials:true})
        axios.delete(`http://localhost:80/doctorbooking/api/api?action=adminDelRating&ratingid=${ratingID}`,{withCredentials:true})
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
                <h2>Rating List</h2>
                <Table rowKey="ratingID" columns={columns} dataSource={data} bordered
                 expandable={{
                    expandedRowRender: record => <div style={{ margin: 0}}>
                        <p>Dr Name: {record.firstName}<span> </span>{record.lastName}</p>
                        <p>Rating Time: {record.ratingTime}</p>
                        <p>Scale: {record.scale}</p>
                        <p>Content: {record.content}</p>
                        </div>,
                  }}></Table>
            </Fragment>
        )
    }
}

export default DoctorList;
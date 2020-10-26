import React from 'react';
import axios from "axios";
import ReactDOM from 'react-dom';

// antd
import { Table, Tag, Space } from 'antd';

// GET 
class DoctorList extends React.Component {
  state = {
    doctors: []
  }

  componentDidMount() {
    axios.get(`http://localhost:80/doctor-admin/src/api/api?action=readDoctorName`,{withCredentials:true})
      .then(res => {
       console.log(res.data);
        const doctors = res.data;
        this.setState({ doctors });
      }).catch((error) => {
        // message.error('error message info' + error.message)
        console.log(error)
      });
  }

//   Table

columns = [
    {
        title: 'Doctor ID',
        dataIndex: 'docotorid',
        key: 'docotorid',
      },
    {
      title: 'First Name',
      dataIndex: 'firstName',
      key: 'firstName',
      render: text => <a>{text}</a>,
    },
    {
      title: 'Last Name',
      dataIndex: 'lastName',
      key: 'lastName',
    },
    {
        title: 'Medical Center',
        dataIndex: 'medicalCenter',
        key: 'medicalCenter',
      },
  
    
    {
      title: 'Action',
      key: 'action',
      render: (text, record) => (
        <Space size="middle">
          <a>Delete</a>
          <a>Add Appointment</a>
        </Space>
      ),
    },
  ];



  render() {
    // const {data,columns,mountNode} = this.state;
    return ( 
      
      <ul>
        { this.state.doctors.map(doctor => 
        <div className="doctorinfo" > 
          {doctor.doctorID} 
          {doctor.firstName},
          {doctor.lastName},
          {doctor.medicalCenter}
          <button>delete</button>
        </div>
      







        // data =[
        //     {
        //         key: (doctor.doctorID),
        //         doctorid: (doctor.doctorID),
        //         firstName: (doctor.firstName),
        //         lastName: (doctor.lastName),
        //         medicalCenter: (doctor.medicalCenter)
        //       } 
        //   ],
        //   ReactDOM.render(<Table columns={columns} dataSource={data} />, mountNode)
        )}
      </ul>
    )
  }
}

export default DoctorList;

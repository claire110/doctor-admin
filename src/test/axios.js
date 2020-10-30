import React, {Component} from 'react';
import axios from "axios";



class test extends React.Component{
    constructor(props){
      super(props);
      this.state = {};
    }

    loadData = () => {
        const baseURL = "http://localhost:80/doctor-admin/src/api/api"
        axios.defaults.baseURL = baseURL

        axios({
            url:"/post",
            params: {id:2}
        })
        axios.get("/posts",{
            params: {id: 3}
        })
    }

    render(){
      return(
          <h1>test</h1>
      )
    }
}


export default test
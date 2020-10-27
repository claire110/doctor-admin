import React from 'react';
import {Switch, Route, Link} from 'react-router-dom';
// component
import Add from '../../views/addDoctor/index'
import Plan from '../../views/apptPlan/index'
import DoctorList from '../../views/doctorList/index'
import DoctorDelete from '../../views/delDoctor/index'
import Logout from '../../views/logout/index'
// private component
import PrivateRouter from '../privateRouter/index'



class ContainerMain extends React.Component{
  constructor(props){
    super(props);
    this.state = {};
  }

  render(){
    return(
      <div>
          <Switch>
            <PrivateRouter component ={DoctorList} exact path="/index" />
            <PrivateRouter component ={Add} exact path="/index/add" />
            <PrivateRouter component ={Plan} exact path="/index/plan" />
            <PrivateRouter component ={DoctorDelete} exact path="/index/delete" />
            <PrivateRouter component ={Logout} exact path="/index/logout" />
          </Switch>
      </div>
    )
  }
}

export default ContainerMain;

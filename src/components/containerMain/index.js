import React from 'react';
import {Switch, Route} from 'react-router-dom';
// component
import Add from '../../views/addDoctor/index'
import Plan from '../../views/apptPlan/index'
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
            <PrivateRouter component ={Add} exact path="/index/add" />
            <PrivateRouter component ={Plan} exact path="/index/plan" />
          </Switch>
      </div>
    )
  }
}

export default ContainerMain;

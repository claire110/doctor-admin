import React from 'react';
import {Switch, Route, BrowserRouter, Link} from 'react-router-dom';
import './App.css';
// component
import Login from './views/login/index'
// import Add from './views/addDoctor/index'
// import Plan from './views/apptPlan/index'
import Index from './views/index/index'
// private component
import PrivateRouter from './components/privateRouter/index'



// import Home from './views/Home'
// import About from './views/About'
// import News from './views/News'


class App extends React.Component{
  constructor(props){
    super(props);
    this.state = {};
  }

  render(){
    return(
      <div className="test">
        <BrowserRouter>
          <Switch>
            {/* <Route render={() => false ? 11: <Login />} exact path="/" /> */}
            {/* <Route render={() => <Login />} exact path="/" /> */}
            <Route component ={Login} exact path="/" />
            <PrivateRouter component ={Index} path="/index" />
            {/* <Route component ={Add} exact path="/add" />
            <Route component ={Plan} exact path="/plan" /> */}
            {/* <Route component ={Login} exact path="/" />
            <Route component ={Index} exact path="/index" />
            <Route component ={Add} exact path="/add" />
            <Route component ={Plan} exact path="/plan" /> */}
          </Switch>
        </BrowserRouter>
      </div>
    )
  }
}

export default App;

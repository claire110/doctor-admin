import React, { Component, Fragment } from "react";
// css
import "./layoutHeader.css";

class layoutHeader extends Component {
    constructor(props){
    super(props);
    this.state = {};
}

    render(){
        return(
            <Fragment >
                <h1 className="logo"><span id="logo">LOGO</span></h1>
            </Fragment> 
        )
    }
}

export default layoutHeader;
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
                <h2 className="logo">
                    <span id="logo"><img src="./logo.png"></img></span>
                    
                </h2>
                
            </Fragment> 
        )
    }
}

export default layoutHeader;
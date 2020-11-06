import React, { Component, Fragment } from "react";
import {formateTime} from "../../../components/formateTime"

class layoutTime extends Component {
    constructor(props){
        super(props);
        this.state = {
            currentTime:formateTime(Date.now())
        };
    }
    
    componentDidMount() {
        this.getTime()
    }

    getTime = () => {
        this.intervalId = setInterval(() => {
          const currentTime = formateTime(Date.now())
          this.setState({
            currentTime
          })
        },1000)
    }

    render(){
        const {currentTime} = this.state
        return(
            <Fragment >
                <span>{currentTime}</span>
            </Fragment> 
        )
    }
}

export default layoutTime;
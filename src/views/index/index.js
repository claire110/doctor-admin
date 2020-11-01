import React, { Component } from "react";
//layout component
import LayoutAside from "./compoments/layoutAside";
import LayoutHeader from "./compoments/layoutHeader";
import ContainerMain from "../../components/containerMain/index";
// css
import "./layout.css";
// antd
import { Layout } from 'antd';
const { Header, Footer, Sider, Content } = Layout;

class Index extends Component {
    constructor(props){
    super(props);
    this.state = {};
}

    render(){
        return(
            <Layout className="layout">
                <Header className="header" style={{ backgroundColor:'#002766'}}><LayoutHeader/></Header>
                <Layout>
                    <Sider width="250px"><LayoutAside/></Sider>
                    <Content className="content">
                        <ContainerMain />
                    </Content>
                </Layout>
                  <Footer>Footer</Footer>
            </Layout>
        )
    }
}

export default Index;
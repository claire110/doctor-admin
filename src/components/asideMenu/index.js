import React, { Component, Fragment} from "react";
import { Link } from "react-router-dom";
// antd
import { Collapse, Menu} from 'antd';
// icon
import { UserOutlined} from '@ant-design/icons';
// router
import Router from '../../router/index';
// import Item from "antd/lib/list/Item";


const { SubMenu } = Menu;

class AsideMenu extends Component {
    constructor(props){
    super(props);
    this.state = {};
}

// Menu
renderMenu = ({title,key}) => {
   return(
        <Menu.Item key={key}>
            <Link to={key}><span>{title}</span></Link>
        </Menu.Item>
   ) 
}

// // subMenu
renderSubMenu =({title, key, child}) => {
    return <SubMenu key={key} icon={<UserOutlined />} title={title}>
        {
            child && child.map(Item =>{
                return Item.child && Item.child.length > 0 ? this.renderSubMenu(Item):this.renderMenu(Item)
            })
        }
    </SubMenu>
}


    render(){
        return(
           <Fragment>
               <Menu
                    theme="dark"
                    mode="inline"
                    defaultSelectedKeys={['1']}
                    defaultOpenKeys={['sub1']}
                    style={{ height: '100%', borderRight: 0 }}
                    >
                     {
                         Router && Router.map(firstItem =>{
                            return firstItem.child && firstItem.child.length > 0 ? this.renderSubMenu(firstItem): this.renderMenu(firstItem);
                         })
                     }
                    {/* <SubMenu key="sub1" icon={<UserOutlined />} title="Doctor Management">
                        <Menu.Item key="0">option1</Menu.Item>
                        <Menu.Item key="1">option2</Menu.Item>
                    </SubMenu>
                    <Menu.Item key="2" icon={<UserOutlined />}>Appt plan</Menu.Item> */}
                   
                </Menu>
           </Fragment>
        )
    }
}

export default AsideMenu;
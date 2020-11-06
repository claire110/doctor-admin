import React from 'react';
// icon
import {FundProjectionScreenOutlined, UsergroupAddOutlined, ScheduleOutlined, UserAddOutlined} from '@ant-design/icons';

const router = [
    {
        title: "Doctor Management",
        icon:"index",
        key: "/index",
        child:[
            {key:"/index", title:"Dcotor list", icon: <UsergroupAddOutlined />,},
            {
                key: "/index/add",
                title: "Add Doctor",
                icon: <UserAddOutlined />
            },
        ]
    },
    {
        title: "Available Times",
        icon: <ScheduleOutlined />,
        key: "/index/available"  
    },
    {
        title: "Rating Management",
        icon: <FundProjectionScreenOutlined />,
        key: "/index/rating"  
    },
    {
        title: "axios",
        icon: "bars",
        key: "/index/test"  
    }
]

export default router;
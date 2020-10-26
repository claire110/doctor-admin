

const router = [
    {
        title: "Doctor Management",
        icon: "index",
        key: "/index",
        child:[
            {key:"/index", title:"Dcotor list", icon: "",},
            {
                key: "/index/add",
                title: "Add Doctor",
                icon: ""
            },
            {
                key: "/index/delete",
                title: "Delete Doctor",
                icon: ""
            },
        ]
    },
    {
        title: "Appointment Plan",
        icon: "bars",
        key: "/index/plan"  
    },
    {
        title: "Logout",
        icon: "bars",
        key: "/index/logout"  
    }
]

export default router;
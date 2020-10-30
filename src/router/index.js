

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
        ]
    },
    {
        title: "Available Times",
        icon: "bars",
        key: "/index/available"  
    },
    {
        title: "Rating Management",
        icon: "bars",
        key: "/index/rating"  
    },
    {
        title: "Logout",
        icon: "bars",
        key: "/index/logout"  
    },
    {
        title: "axios",
        icon: "bars",
        key: "/index/test"  
    }
]

export default router;
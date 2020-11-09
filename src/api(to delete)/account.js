import service from "../../src/utils/request";

// Login
export function login(){
    return service.request({
        url: "http://localhost:80/doctor-admin/src/api/api?action=login",
        method: "post",
    })
}
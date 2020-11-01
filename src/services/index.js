import axios from 'axios'
import apis from './apis'

const ajax = axios.create({
    baseURL: apis.baseURL
})

export const getDoctorList = () => {
    return ajax.get(apis.getDoctorList,{withCredentials:true})
}

// export const deleteDoctor = () => {
//     return ajax.delete(apis.deleteDoctor,{withCredentials:true})
// }

 

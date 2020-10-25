// const { createProxyMiddleware } = require('http-proxy-middleware');

// module.exports = function(app){
//     app.use(createProxyMiddleware("/devApi",{
//         target:"http://localhost:80/doctor-admin/src/api/api?action=login",  //server url
//         changeOrigin:true,
//         pathRewrite:{
//             "^/devApi":"",
//         }
//     }))
//     // app.use(proxy("/manage/api",{
//     //     target:"http://admintest.happymmal.com:7000",
//     //     changeOrigin:true,
//     // }))
// }
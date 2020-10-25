<?php

header('Content-Type: application/json;charset=utf-8');// all echo statements are json_encode
header("Access-Control-Allow-Origin: *");
include('se.php');
include('db.php');
session_start();

$doctordb = new doctorModel; //instantiate database to start using 

$result = $doctordb->showDoctorinfo();
if($result == false) {
    http_response_code(204); // no content
} elseif(is_array($result)) {
    http_response_code(200); //success
    echo json_encode($result);
} 
?>
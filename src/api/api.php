<?php

header('Content-Type: application/json');// all echo statements are json_encode
header("Access-Control-Allow-Headers: content-type");
// header("Access-Control-Allow-Origin: *");

// Allow from any origin
if (isset($_SERVER['HTTP_ORIGIN'])) {
    header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");
    header('Access-Control-Allow-Credentials: true');
    header('Access-Control-Max-Age: 86400');    // cache for 1 day
}

// Access-Control headers are received during OPTIONS requests
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {

    if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_METHOD']))
        header("Access-Control-Allow-Methods: PUT, POST, GET, DELETE, PATCH, OPTIONS");         

    if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']))
        header("Access-Control-Allow-Headers:        
        {$_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']}");

    exit(0);
}

include('se.php');
include('db.php');
session_start();

$doctordb = new doctorModel; //instantiate database to start using

    if(!isset($_SESSION['sessionOBJ'])) {//check session
        $_SESSION['sessionOBJ'] = new doctorSession(); //instantiate session to start using
        // throw new APIException("NO SESSION");
        // http_response_code(401);
    }

    // //if session pre-exists, check ratelimit, referrer
    // if($_SESSION['sessionOBJ']->rateLimit() === false) {
    //     //throw new APIException("Rate limit exceeded");
    //     http_response_code(429);//too many requests
    //     die();
    // }

    // if($_SESSION['sessionOBJ']->Rate24HourCheck() === false) {
    //     //throw new APIException("Rate limit exceeded");
    //     http_response_code(429);//too many requests
    //     die();
    // }

    // if($_SESSION['sessionOBJ']->domainLock() == false) {
    //     throw new APIException("invalid referrer");
    //     http_response_code(501);
    //     die();
    // }

    //input sanitation
    function testInput($data){
        $data = trim($data);//removes whitespace and other predefined characters from both sides of a string
        $data = stripslashes($data);//removes backslashes
        $data = htmlspecialchars($data);//Convert special characters to HTML entities
        $data = htmlentities($data);//Convert characters to HTML entities
        return $data;
    }

    // data validation
    function validate_data($unsafe, $type){
        switch($type){
            case 'username':
                if(strlen($unsafe) > 2){
                    return true;
                }
                return false;
    
            case 'password':
                    if(preg_match("/^(?![0-9]+$)(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$/",$unsafe)){
                        return true;
                    }
                 return false;
    
            case 'firstname':
                if(strlen($unsafe) > 1){
                    if(preg_match("/^[A-Za-z]+$/",$unsafe)){
                        return true;
                    }
                }
                return false;
        
            case 'lastname':
                if(strlen($unsafe) > 1){
                    if(preg_match("/^[A-Za-z]+$/",$unsafe)){
                        return true;
                    }
                }
                return false;
    
            case 'dateofbirth':   
                if(preg_match("/^([0-9]{4})-([0-9]{2})-([0-9]{2})$/",$unsafe)){
                    return true;
                }
                return false;
    
            case 'email':   
                if(preg_match("/^([0-9A-Za-z\\-_\\.]+)@([0-9a-z]+\\.[a-z]{2,3}(\\.[a-z]{2})?)$/i",$unsafe)){
                    return true;
                }
                return false;
    
            case 'contactnumber':   
                if(preg_match("/^[0-9]{10}$/",$unsafe)){
                        return true;
               }
                 return false;

            case 'address':   
                if(strlen($unsafe) > 1){
                        return true;
               }
                 return false;

            case 'content':
                if(strlen($unsafe) >= 1){
                    return true;
                }
                return false;

            case 'scale':
                if(preg_match("/^[1-5]$/",$unsafe)){
                    return true;
                }
                return false;
    
            case 'searchValue':
                if(strlen($unsafe) >= 1){
                    return true;
                }
                return false;

            default:
                return false;
        }
    }
    
    // base case
    if(isset($_GET['action'])) {
        switch($_GET['action']) {
            case 'login':
                if(!empty($_POST['username']) && !empty($_POST['password'])) {
                    //input sanitation
                    $username = !empty($_POST['username'])? testInput(($_POST['username'])): null;
                    $password = !empty($_POST['password'])? testInput(($_POST['password'])): null;
                    //input validation
                    $safe_username = validate_data($username, 'username');
                    $safe_password = validate_data($password, 'password');

                    if($safe_username == true && $safe_password == true) {
                        $result = $_SESSION['sessionOBJ']->login($username, $password);
                        if($result == 0) {
                            http_response_code(401);//password or username is wrong
                        }  else{
                            echo json_encode($result);
                            //logging
                            $userid = $_SESSION['sessionOBJ']->getuserid();
                            $ip = $_SESSION['sessionOBJ']->getIP();
                            $browser = $_SESSION['sessionOBJ']->getBrowser();
                            $action = $_GET['action'];
                            $result = $doctordb->logging($userid, $action, $ip, $browser);
                            if($result == true) {
                               return true; // insert failed
                            } else{
                               return false; //insert logging success
                            }
                        }
                    } else{
                        http_response_code(400);//Invalid input
                    }
                } else{
                    http_response_code(501);//Input is empty
                    }
            break;
            case 'loggedin':
                $result = $_SESSION['sessionOBJ']->logged_in();
                if($result == true){
                    echo json_encode($result); //login
                    http_response_code(200); 
                }else{
                    http_response_code(401); 
                } 
            break;
            case 'userRegister':
                if(!empty($_POST['username']) && !empty($_POST["username"]) && !empty($_POST['password']) && !empty($_POST['firstname']) && !empty($_POST['lastname']) && !empty($_POST['dateofbirth']) && !empty($_POST['email']) && !empty($_POST['contactnumber']) && !empty($_POST['address']) && !empty($_POST['suburb'])&& !empty($_POST['state'])&& !empty($_POST['postcode'])&& !empty($_POST['postcode'])) {
                    //input sanitation
                    $username = !empty($_POST['username'])? testInput(($_POST['username'])): null;
                    $password = !empty($_POST['password'])? testInput(($_POST['password'])): null;
                    $firstname = !empty($_POST['firstname'])? testInput(($_POST['firstname'])): null;
                    $lastname = !empty($_POST['lastname'])? testInput(($_POST['lastname'])): null;
                    $dateofbirth = !empty($_POST['dateofbirth'])? testInput(($_POST['dateofbirth'])): null;
                    $email = !empty($_POST['email'])? testInput(($_POST['email'])): null;
                    $contactnumber = !empty($_POST['contactnumber'])? testInput(($_POST['contactnumber'])): null;
                    $address = !empty($_POST['address'])? testInput(($_POST['address'])): null;
                    $suburb = !empty($_POST['suburb'])? testInput(($_POST['suburb'])): null;
                    $state = !empty($_POST['state'])? testInput(($_POST['state'])): null;
                    $postcode = !empty($_POST['postcode'])? testInput(($_POST['postcode'])): null;         

                    //input validation
                    $safe_username = validate_data($username, 'username');
                    $safe_password = validate_data($password, 'password');
                    $safe_firstname = validate_data($firstname, 'firstname'); 
                    $safe_lastname = validate_data($lastname, 'lastname');
                    $safe_dateofbirth = validate_data($dateofbirth, 'dateofbirth');
                    $safe_email = validate_data($email, 'email');
                    $safe_contactnumber = validate_data($contactnumber, 'contactnumber');
                    $safe_address = validate_data($address, 'address');
                    $safe_suburb = validate_data($suburb, 'address');
                    $safe_state = validate_data($state, 'address');
                    $safe_postcode = validate_data($postcode, 'address');

                    if($safe_username == true && $safe_password == true && $safe_firstname == true && $safe_lastname == true && $safe_dateofbirth == true && $safe_email == true && $safe_contactnumber == true && $safe_address == true && $safe_suburb == true && $safe_state == true && $safe_postcode == true) { 
                        $result = $doctordb->usernameCheck($username);//username check
                        if($result == 0) {
                            $result = $doctordb->register_process($username, $password, $firstname, $lastname, $dateofbirth, $email, $contactnumber, $address, $suburb, $state, $postcode);
                            if($result == true) {
                                http_response_code(201);//success
                            } else {
                                http_response_code(501);//not implemented 
                            } 
                        } else{
                            http_response_code(409);//username repeated
                        } 
                    } else{
                        http_response_code(400); //Invalid input
                    }
                } else{
                    http_response_code(501);
                }
                break;

            case 'logout':
                if($_SESSION['sessionOBJ']->logged_in()) {
                    $result = $_SESSION['sessionOBJ']->logout_se();
                        if($result == true) {
                            http_response_code(200); //success
                        }else{
                            http_response_code(501);  // Not implemented 
                        }
                    }
                else{
                    http_response_code(401); // not login
                } 
                // logging
                    $userid = $_SESSION['sessionOBJ']->getuserid();
                    $ip = $_SESSION['sessionOBJ']->getIP();
                    $browser = $_SESSION['sessionOBJ']->getBrowser();
                    $action = $_GET['action'];
                    $result = $doctordb->logging($userid, $action, $ip, $browser);
                        if($result == true) {
                           return true; // insert failed
                        } else{
                           return false; //insert logging success
                        }
                break;
              
            case 'searchDoctorInfo':
                if(!empty($_GET['searchValue'])){
                    //input sanitation
                    $searchValue = !empty($_POST['searchValue'])? testInput(($_POST['searchValue'])): null;
                    //input validation
                    $safe_searchValue = validate_data($searchValue, 'searchValue');
                    if($safe_searchValue = true) { 
                        $result = $doctordb->searchDoctorInfo($_GET['searchValue']);
                        if($result == false) {
                            http_response_code(204);//no content
                        } else{
                            echo json_encode($result);//success
                        }
                    }else{
                        http_response_code(501); //searchValue empty
                    }
                }else{
                    http_response_code(501);//searchValue empty
                }
            break;         
            case 'showDoctorinfo':
                $result = $doctordb->showDoctorinfo();
                if($result == false) {
                    http_response_code(204); // no content
                } elseif(is_array($result)) {
                    http_response_code(200); //success
                    echo json_encode($result);
                } 
            break;
            case 'showRatinginfo':
                if(!empty($_GET['doctorid'])){
                    $result = $doctordb->showRatinginfo($_GET['doctorid']);
                    if($result == false) {
                        http_response_code(204);//no content
                    } else{
                        echo json_encode($result);//success
                    }
                }else{
                    http_response_code(501);//doctorid invalidate
                }
            break;
            case 'showAppinfo':
                if(!empty($_GET['doctorid'])){
                    $result = $doctordb->showAppinfo($_GET['doctorid']);
                    if($result == false) {
                        http_response_code(204);//no content
                    } else{
                        echo json_encode($result);//success
                    }
                }else{
                    http_response_code(501);//doctorid invalidate
                }
            break;
            case 'showAppHistory':
                if($_SESSION['sessionOBJ']->logged_in()) {
                    if(!empty($_SESSION['sessionOBJ']->getuserid())) {
                        $userid = $_SESSION['sessionOBJ']->getuserid();
                        $result = $doctordb->showAppHistory($userid);
                        if($result == false) {
                            http_response_code(204);//no content
                        } else{
                            echo json_encode($result);//success
                        }
                    }else{
                        http_response_code(501);//userid is wrong
                    }
                }else{
                    http_response_code(401); ////unauthorized, not login
                }
                // logging
                $userid = $_SESSION['sessionOBJ']->getuserid();
                $ip = $_SESSION['sessionOBJ']->getIP();
                $browser = $_SESSION['sessionOBJ']->getBrowser();
                $action = $_GET['action'];
                $result = $doctordb->logging($userid, $action, $ip, $browser);
                    if($result == true) {
                       return true; // insert failed
                    } else{
                       return false; //insert logging success
                    }
                break;

            case 'booking':
                if($_SESSION['sessionOBJ']->logged_in()) {
                    //input sanitation
                    $userid = $_SESSION['sessionOBJ']->getuserid();
                    $planid = !empty($_POST['planid'])? testInput(($_POST['planid'])): null;

                    $result = $doctordb->planidCheck($_GET['planid']);//planid check
                    if($result == 1) { //still available
                        $result = $doctordb->booking_process($userid, $_GET['planid']);
                        if($result == true) {
                            http_response_code(201); //add success
                        }else{
                            http_response_code(501); // not implement
                        }
                    }else{
                        http_response_code(409);//already booked, not available now
                    }
                }else{
                    http_response_code(401);//unauthorized
                }
                // logging
                $userid = $_SESSION['sessionOBJ']->getuserid();
                $ip = $_SESSION['sessionOBJ']->getIP();
                $browser = $_SESSION['sessionOBJ']->getBrowser();
                $action = $_GET['action'];
                $result = $doctordb->logging($userid, $action, $ip, $browser);
                    if($result == true) {
                       return true; // insert failed
                    } else{
                       return false; //insert logging success
                    }
                break;

            case 'cancelAppt': 
                if($_SESSION['sessionOBJ']->logged_in()) {
                    $userid = $_SESSION['sessionOBJ']->getuserid();//check userid
                    $method = $_SERVER['REQUEST_METHOD'];
                    if('DELETE' === $method) {
                        if(!empty($_GET['bookingid'])){
                            $result = $doctordb->cancelAppt_process($_GET['bookingid'], $userid);
                            if($result == true) {
                                http_response_code(200); //deleted success
                            }else{
                                http_response_code(409); //appt not exist
                            }
                        }else{
                            http_response_code(400);//bookingid invalid
                        } 
                    }else{
                        http_response_code(501);//not implement
                    } 
                }else {
                    http_response_code(401);//unauthorized
                }
                // logging
                $userid = $_SESSION['sessionOBJ']->getuserid();
                $ip = $_SESSION['sessionOBJ']->getIP();
                $browser = $_SESSION['sessionOBJ']->getBrowser();
                $action = $_GET['action'];
                $result = $doctordb->logging($userid, $action, $ip, $browser);
                    if($result == true) {
                       return true; // insert failed
                    } else{
                       return false; //insert logging success
                    }
                break;

            case 'readRating':
                if($_SESSION['sessionOBJ']->logged_in()) {
                    if(!empty($_GET['bookingid'])){
                        $result = $doctordb->readRating_process($_GET['bookingid']);
                        if($result == false) {
                            http_response_code(204);//no content
                        } else{
                            echo json_encode($result);//success
                        }
                    }else{
                        http_response_code(400);//doctorid invalidate
                    }
                }else {
                    http_response_code(401);//unauthorized
                }
                // logging
                $userid = $_SESSION['sessionOBJ']->getuserid();
                $ip = $_SESSION['sessionOBJ']->getIP();
                $browser = $_SESSION['sessionOBJ']->getBrowser();
                $action = $_GET['action'];
                $result = $doctordb->logging($userid, $action, $ip, $browser);
                    if($result == true) {
                       return true; // insert failed
                    } else{
                       return false; //insert logging success
                    }
                break;
            
            case 'getBookingid':
                if(!empty($_GET['bookingid'])){
                    $result = $doctordb->getBookingid_process($_GET['bookingid']);
                    if($result == false) {
                        http_response_code(204);//no content
                    } else{
                        echo json_encode($result);//success
                    }
                }else{
                    http_response_code(400);//doctorid invalidate
                }
                break;


            case 'addRating':
                if($_SESSION['sessionOBJ']->logged_in()) {
                    if(!empty($_POST["scale"]) && !empty($_POST['content'])){
                         //input sanitation
                        $scale = !empty($_POST['scale'])? testInput(($_POST['scale'])): null;
                        $content = !empty($_POST['content'])? testInput(($_POST['content'])): null;

                        //input validation
                        $safe_scale = validate_data($scale, 'scale');
                        $safe_content = validate_data($content, 'content');

                        if($safe_scale == true && $safe_content == true) {    
                            $result = $doctordb->bookingIDCheck($_GET['bookingid']);//bookingid check
                            if($result == 0) {
                                $result = $doctordb->addRating_process($_GET['bookingid'], $scale, $content);
                                if($result == true) {
                                    http_response_code(201); //add success
                                }else{
                                    http_response_code(501); //not implement
                                    //echo json_encode($result);
                                }
                            }else {
                                http_response_code(409);//already rated
                            }
                            }else{
                                http_response_code(400); //input invalidate
                            } 
                        }else{
                                http_response_code(501); //input empty
                            }  
                }else{
                    http_response_code(401);//unauthorized
                }
                // logging
                $userid = $_SESSION['sessionOBJ']->getuserid();
                $ip = $_SESSION['sessionOBJ']->getIP();
                $browser = $_SESSION['sessionOBJ']->getBrowser();
                $action = $_GET['action'];
                $result = $doctordb->logging($userid, $action, $ip, $browser);
                    if($result == true) {
                       return true; // insert failed
                    } else{
                       return false; //insert logging success
                    }
                break;  

                case 'updateRating':
                    if($_SESSION['sessionOBJ']->logged_in()) {
                        if(!empty($_POST["scale"]) && !empty($_POST['content'])){
                             //input sanitation
                            $scale = !empty($_POST['scale'])? testInput(($_POST['scale'])): null;
                            $content = !empty($_POST['content'])? testInput(($_POST['content'])): null;
                
                             //input validation
                            $safe_scale = validate_data($scale, 'scale');
                            $safe_content = validate_data($content, 'content');

                            if($safe_scale == true && $safe_content == true) { 
                                $result = $doctordb->updateRating_process($_GET['ratingid'], $scale, $content);
                                if($result == true) {
                                    http_response_code(201); //add success
                                }else{
                                    http_response_code(501); //not implement
                                }
                            }else{
                                http_response_code(400); //input invalidate
                            }  
                        }else{
                            http_response_code(501); //input is empty
                        }  

                    }else{
                        http_response_code(401);//unauthorized
                    }
                    // logging
                    $userid = $_SESSION['sessionOBJ']->getuserid();
                    $ip = $_SESSION['sessionOBJ']->getIP();
                    $browser = $_SESSION['sessionOBJ']->getBrowser();
                    $action = $_GET['action'];
                    $result = $doctordb->logging($userid, $action, $ip, $browser);
                        if($result == true) {
                           return true; // insert failed
                        } else{
                           return false; //insert logging success
                        }
                    break;  

            case 'delRating':
                if($_SESSION['sessionOBJ']->logged_in()) {
                    $method = $_SERVER['REQUEST_METHOD'];
                    if('DELETE' === $method) {
                        if(!empty($_GET['ratingid'])){
                            $result = $doctordb->ratingidCheck($_GET['ratingid']);//ratingid check
                            if($result == 0) {
                                $result = $doctordb->delRating_process($_GET['ratingid']);
                                if($result == true) {
                                    http_response_code(200); //deleted success
                                }else{
                                    http_response_code(501); //not implement
                                }
                            }else{
                                http_response_code(409);//already delete or not exist
                            }
                        }else{
                            http_response_code(400);//input invalidate
                        } 
                    }else{
                        http_response_code(501);//not implement
                    } 
                }else {
                    http_response_code(401);//unauthorized
                }
                // logging
                $userid = $_SESSION['sessionOBJ']->getuserid();
                $ip = $_SESSION['sessionOBJ']->getIP();
                $browser = $_SESSION['sessionOBJ']->getBrowser();
                $action = $_GET['action'];
                $result = $doctordb->logging($userid, $action, $ip, $browser);
                    if($result == true) {
                       return true; // insert failed
                    } else{
                       return false; //insert logging success
                    }
                break;

            
                case 'doctorRegister'://todo, privilege and validation check before insert
                if($_SESSION['sessionOBJ']->logged_in()) {
                    if(!empty($_POST['dfirstname']) && !empty($_POST["dlastname"]) && !empty($_POST['ddateofbirth']) && !empty($_POST['demail']) && !empty($_POST['dcontactnumber']) && !empty($_POST['dpicurl']) && !empty($_POST['dintro']) && !empty($_POST['dmedicalcenter']) && !empty($_POST['dareaofspec'])){
                        //input sanitation
                        $dfirstname = !empty($_POST['dfirstname'])? testInput(($_POST['dfirstname'])): null;
                        $dlastname = !empty($_POST['dlastname'])? testInput(($_POST['dlastname'])): null;
                        $ddateofbirth = !empty($_POST['ddateofbirth'])? testInput(($_POST['ddateofbirth'])): null;
                        $demail = !empty($_POST['demail'])? testInput(($_POST['demail'])): null;
                        $dcontactnumber = !empty($_POST['dcontactnumber'])? testInput(($_POST['dcontactnumber'])): null;
                        $dpicurl = !empty($_POST['dpicurl'])? testInput(($_POST['dpicurl'])): null;  
                        $dintro = !empty($_POST['dintro'])? testInput(($_POST['dintro'])): null;
                        $dmedicalcenter = !empty($_POST['dmedicalcenter'])? testInput(($_POST['dmedicalcenter'])): null;
                        $dareaofspec = !empty($_POST['dareaofspec'])? testInput(($_POST['dareaofspec'])): null;
                        
                        //input validation
                        $safe_dfirstname = validate_data($dfirstname, 'firstname');
                        $safe_dlastname = validate_data($dlastname, 'lastname');
                        $safe_ddateofbirth = validate_data($ddateofbirth, 'dateofbirth');
                        $safe_demail = validate_data($demail, 'email');
                        $safe_dcontactnumber = validate_data($dcontactnumber, 'contactnumber');
                        //$safe_dpicurl = validate_data($dpicurl, 'dpicurl');
                        $safe_dintro = validate_data($dintro, 'address');
                        $safe_dmedicalcenter = validate_data($dmedicalcenter, 'address');
                        $safe_dareaofspec = validate_data($dareaofspec, 'address');

                        // if($safe_dfirstname == true && $safe_dlastname == true && $safe_ddateofbirth == true && $safe_demail == true && $safe_dcontactnumber == true && $safe_dintro == true && $safe_dmedicalcenter == true && $safe_dareaofspec == true) { 
                            $result = $doctordb->addDoctor($dfirstname, $dlastname, $ddateofbirth, $demail, $dcontactnumber, $dpicurl, $dintro, $dmedicalcenter, $dareaofspec);
                            if($result == true) {
                                http_response_code(201);//success
                            } else {
                                http_response_code(501);//not implement
                            }
                        // }else{
                        //     http_response_code(400);//Invalid input
                        // }
                    }else{
                        http_response_code(501);//not implement
                    }
                }else {
                    http_response_code(401);//unauthorized
                }

                // logging
                $userid = $_SESSION['sessionOBJ']->getuserid();
                $ip = $_SESSION['sessionOBJ']->getIP();
                $browser = $_SESSION['sessionOBJ']->getBrowser();
                $action = $_GET['action'];
                $result = $doctordb->logging($userid, $action, $ip, $browser);
                    if($result == true) {
                       return true; // insert failed
                    } else{
                       return false; //insert logging success
                    }
            break;

            case 'apptPlan':
                if($_SESSION['sessionOBJ']->logged_in()) {
                    if(!empty($_POST['doctorid']) &&!empty($_POST['plandate']) && !empty($_POST["starttime"]) && !empty($_POST['endtime'])){
                        // //input sanitation
                        $doctorid = !empty($_POST['doctorid'])? testInput(($_POST['doctorid'])): null;
                        $plandate = !empty($_POST['plandate'])? testInput(($_POST['plandate'])): null;
                        $starttime = !empty($_POST['starttime'])? testInput(($_POST['starttime'])): null;
                        $endtime = !empty($_POST['endtime'])? testInput(($_POST['endtime'])): null;
                       
                        // //input validation
                        // $safe_dfirstname = validate_data($dfirstname, 'firstname');
                        // $safe_dlastname = validate_data($dlastname, 'lastname');
                        // $safe_plandate= validate_data($plandate, 'plandate');
                        // $safe_starttime = validate_data($starttime, 'starttime');
                        // $safe_endtime = validate_data($endtime, 'endtime');

                        // if($safe_dfirstname == true && $safe_dlastname == true && $safe_planDate && $safe_startTime && $safe_endTime) { 
                            $result = $doctordb->PlanAppt($doctorid, $plandate, $starttime, $endtime);
                            if($result == true) {
                                http_response_code(201);//success
                            } else {
                                http_response_code(501);//not implement
                            }
                        // }else{
                        //     http_response_code(400);//Invalid input
                        // }
                    }else{
                        http_response_code(501);//not implement
                    }
                }else {
                    http_response_code(401);//unauthorized
                }

                // logging
                $userid = $_SESSION['sessionOBJ']->getuserid();
                $ip = $_SESSION['sessionOBJ']->getIP();
                $browser = $_SESSION['sessionOBJ']->getBrowser();
                $action = $_GET['action'];
                $result = $doctordb->logging($userid, $action, $ip, $browser);
                    if($result == true) {
                       return true; // insert failed
                    } else{
                       return false; //insert logging success
                    }
            break;

            case 'readDoctorName':
                $result = $doctordb->readDoctorName();
                if($result == false) {
                    http_response_code(204); // no content
                } elseif(is_array($result)) {
                    http_response_code(200); //success
                    echo json_encode($result);
                } 

                // // logging
                $userid = $_SESSION['sessionOBJ']->getuserid();
                $ip = $_SESSION['sessionOBJ']->getIP();
                $browser = $_SESSION['sessionOBJ']->getBrowser();
                $action = $_GET['action'];
                $result = $doctordb->logging($userid, $action, $ip, $browser);
                    if($result == true) {
                       return true; // insert failed
                    } else{
                       return false; //insert logging success
                    }
            break;

            case 'delDoctor':
                if($_SESSION['sessionOBJ']->logged_in()) {
                    $method = $_SERVER['REQUEST_METHOD'];
                    if('DELETE' === $method) {
                        if(!empty($_GET['doctorid'])){
                                $result = $doctordb->delDoctor_process($_GET['doctorid']);
                                if($result == true) {
                                    http_response_code(200); //deleted success
                                }else{
                                    http_response_code(501); //not implement
                                }
                        }else{
                            http_response_code(400);//input invalidate
                        } 
                    }else{
                        http_response_code(501);//not implement
                    } 
                }else {
                    http_response_code(401);//unauthorized
                }
                // logging
                $userid = $_SESSION['sessionOBJ']->getuserid();
                $ip = $_SESSION['sessionOBJ']->getIP();
                $browser = $_SESSION['sessionOBJ']->getBrowser();
                $action = $_GET['action'];
                $result = $doctordb->logging($userid, $action, $ip, $browser);
                    if($result == true) {
                       return true; // insert failed
                    } else{
                       return false; //insert logging success
                    }
                break;
    
            default:
                http_response_code(501);//not implement
                throw new APIException("incorrect request");
                break;
        }
    } else{
        http_response_code(501);
    }
?>
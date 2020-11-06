<?php

class APIException extends Exception
{
}
class doctorSession{
    private $username;
    private $privilege;
    private $userid;
    private $referrer;
    private $ip;
    private $browser;
    private $lastrequestArray = null;
    private $_startTime;
    private $_requestCounter;

    

    public function __construct() {
        $this->privilege === '0';
        // IP
        if(isset($_SERVER['REMOTE_ADDR'])) {
            $this->ip = $_SERVER['REMOTE_ADDR'];
        } else {
            throw new APIException("No viable headers");
        }
        // browser
        if(isset($_SERVER['HTTP_USER_AGENT'])) {
            $this->browser = $_SERVER['HTTP_USER_AGENT'];
        } else {
            throw new APIException("No browser");
        }
        // referer
    //     if(isset($_SERVER['HTTP_REFERER'])) {
    //         $this->referrer = $_SERVER['HTTP_REFERER'];
    //     } else {
    //         throw new APIException("No referrer");
    //     }
    }

    public function getIP(){
        if($this->privilege === '1' || $this->privilege === '2' ){
            return $this->ip;
        }
        return null;
    }

    public function getBrowser(){
        if($this->privilege === '1' || $this->privilege === '2' ){
            return $this->browser;
        }
        return null;
    }

    public function domainLock() {
        if((strpos($this->referrer, 'localhost') !== false) ||
                (strpos($this->referrer, 'booking') !== false)) {
            return true;
        } else {
            // throw new APIException("invalid referrer");
            return false;
        }
    }

    public function rateLimit() {
        if (isset($_SESSION['LAST_CALL'])) {
          $last = strtotime($_SESSION['LAST_CALL']);
          $curr = strtotime(date("Y-m-d h:i:s"));
          $sec =  abs($last - $curr);//Compare the time of this request and the last request
          if ($sec < 1) { 
            // $data = 'Rate Limit Exceeded';
            //throw new APIException("Rate limit exceeded");
            return false;      
          }
        }
        $_SESSION['LAST_CALL'] = date("Y-m-d h:i:s");
        return true;
        // $data = "Data Returned from API";
    } 

    public function setStartTime($startTime){
        $this->_startTime = $startTime;
    }
    public function getStartTime(){
        return $this->_startTime;
    }
    public function setRequestCounters($requestCounter){
        $this->_requestCounter = $requestCounter;
    }
    public function getRequestCounter(){
        return $this->_requestCounters;
    }

    public function Rate24HourCheck() {
        if($this->_startTime == null){
            $this->_startTime = time();
        }

        $this->_requestCounter++;
        $seconds = (time() - $this->_startTime);
        $this->_startTime = time();
        if ($seconds < 86400 && $this->_requestCounter >1000){
            return false;
        } else if ($seconds >= 86400){
            $this->_requestCounter = 0;
        }
        return $this->_requestCounter;
    } 



    public function login($username, $password) {
        global $doctordb;
        $result = $doctordb->login_process($username, $password);
        if($result ==  0) {
            return 0;
        }
        if($result == 1) {
            $this->username = $username;
            $userinfo1 = $doctordb->userinfo($username);
            if(sizeof($userinfo1)> 0) {
                $this->userid = $userinfo1['userid'];
                $this->privilege = $userinfo1['privilege'];
                return $this->privilege;
               
                // $encrypted = base64_encode(mcrypt_encrypt(MCRYPT_RIJNDAEL_256,MCRYPT_MODE_CBC, md5(md5($userinfo1))));  
                // return $encrypted;  
            }
            return 1;
        }
    }

    public function getuserid() {
        if($this->privilege === '1' || $this->privilege === '2' ){
            return $this->userid;
        }
        return null;
    }

    public function logged_in(){
        if($this->privilege === '0') {
            return false;
        } elseif($this->privilege === '1' || $this->privilege === '2' ) {
            return true;
        }
    }

    public function logout_se(){ 
        unset($this->privilege);
        unset($this->userid);
        return true;
    }
}
?>

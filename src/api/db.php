<?php
    class doctorModel {
        private $conn;
        // database connection
        public function __construct() {
            try {
                $this->conn = new PDO("mysql:host=localhost;dbname=doctorbooking", "root", "");
                //set the PDO error mode to exception
                $this->conn->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
            }
            catch(PDOException $e) {
                echo json_encode(Array("error"=>"Database Connection Error")); // debug. INSTEAD: echo json_encode(Array('error'=>'true'));
                die();
            }
        }
        //logging
        public function logging($userid, $action, $ip, $browser) {
            $newlogging = "INSERT INTO logging(userID, action, ip, browser) VALUES (:userid, :action, :ip, :browser)";
            $stmt = $this->conn->prepare($newlogging);
            $stmt->bindParam(':userid', $userid, PDO::PARAM_INT);
            $stmt->bindParam(':action', $action);
            $stmt->bindParam(':ip', $ip);
            $stmt->bindParam(':browser', $browser);
            if ($stmt->execute()) { 
                return true;
            } else {
                return false;
            }
        } 

        // login process
        public function login_process($username, $password) {
            try {
                $userinfo = "SELECT * FROM user where username = :username";
                $stmt = $this->conn->prepare($userinfo);
                $stmt->bindParam(':username', $username, PDO::PARAM_STR);
                $stmt->execute();
                $rows = $stmt->fetch(PDO::FETCH_ASSOC);
                if($rows == false){
                    return 0;
                } else{
                    if (password_verify($password, $rows['passWord'])) {
                        return 1;
                    } else { 
                        return 0;
                    }
                }
            } catch(PDOException $e) {
                echo "allDoctorList error"; die();
            } 
        }
        
        public function userinfo($username) {
            $userinfo1 = "SELECT * FROM user where userName = :username";
            $stmt = $this->conn->prepare($userinfo1);
            $stmt->bindParam(':username', $username);
            $stmt->execute();
            $result = $stmt->fetch(PDO::FETCH_ASSOC);
            if(is_array($result) && (sizeof($result) > 0)) {
                return array (
                    'login'=>'true',
                    'userid'=> $result['userID'],
                    'privilege'=>$result['privilege']);
                }else {
                    return false;
                }
        }
            
        // register
        public function register_process($username, $password, $firstname, $lastname, $dateofbirth, $email, $contactnumber, $address, $suburb, $state, $postcode) {
            $hashedPassword = password_hash($password, PASSWORD_DEFAULT);
                $newuser = "INSERT INTO user(userName, passWord, firstName, lastName, dateOfBirth, email, contactNumber, address, suburb, state, postcode) VALUES (:username, :password, :firstname, :lastname, :dateofbirth, :email, :contactnumber, :address, :suburb, :state, :postcode)";
                $stmt = $this->conn->prepare($newuser);
                $stmt->bindParam(':username', $username);
                $stmt->bindParam(':password', $hashedPassword);
                $stmt->bindParam(':firstname', $firstname);
                $stmt->bindParam(':lastname', $lastname);
                $stmt->bindParam(':dateofbirth', $dateofbirth);
                $stmt->bindParam(':email', $email);
                $stmt->bindParam(':contactnumber', $contactnumber);
                $stmt->bindParam(':address', $address);
                $stmt->bindParam(':suburb', $suburb);
                $stmt->bindParam(':state', $state);
                $stmt->bindParam(':postcode', $postcode);
               
                if ($stmt->execute()) { 
                    return true;
                } else {
                    return false;  
                }
        } 
       
        //logout
        public function logout_process() {
            return true;
        }

        //check username if exist when register
        public function usernameCheck($username) {
            try {
                $usernamecheck = "SELECT * FROM user WHERE userName = :username";
                $stmt = $this->conn->prepare($usernamecheck);
                $stmt->bindParam(':username', $username);
                $stmt->execute();
                $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
                    if(count($result) <= 0) {
                        return 0; //not exist
                    } else { 
                        return 1; //user exist
                    }
            } catch (PDOException $e) {
                echo "username error"; die();
            }
        }

        //homepage: doctor searching 
        public function searchDoctorInfo($searchValue) {
            try {
                $x = $searchValue;
                $doctor_list = "SELECT (SELECT COUNT(planID) AS appttimes FROM plan where DATEDIFF(planDate,NOW())<30 AND DATEDIFF(planDate,NOW())>=0 AND doctorID= doctor.doctorID AND plan.planID NOT in (SELECT planID FROM booking))as appt,
                                doctor.doctorID, doctor.firstName, doctor.lastName,doctor.medicalCenter, doctor.areaOfSpec, doctor.Intro, doctor.picUrl,round(AVG(rating.scale),0) as avgscare, COUNT(rating.scale) AS scalecount, COUNT(booking.bookingID) as bookingcount
                                FROM doctor LEFT JOIN plan ON doctor.doctorID = plan.doctorID
                                LEFT JOIN booking
                                ON plan.planID = booking.planID
                                LEFT JOIN rating
                                on booking.bookingID = rating.bookingID
                                WHERE doctor.firstName LIKE '%$x%' or doctor.lastName LIKE '%$x%' or doctor.medicalCenter LIKE '%$x%'
                                      or doctor.areaOfSpec LIKE '%$x%'
                                GROUP BY doctor.doctorID";
    
                $stmt = $this->conn->prepare($doctor_list);
                $stmt->execute();
                $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
                if($result == false) {
                    return false;
                } else {
                    return $result;
                }
            } catch(PDOException $e) {
                echo "allDoctorList error"; die();
            }  
        }

        //homepage: show doctor information
        public function showDoctorinfo() {
            try {
                $doctor_list = "SELECT (SELECT COUNT(planID) AS appttimes FROM plan where DATEDIFF(planDate,NOW())<30 AND DATEDIFF(planDate,NOW())>=0 AND doctorID= doctor.doctorID AND plan.planID NOT in (SELECT planID FROM booking))as appt,
                                doctor.doctorID, doctor.firstName, doctor.lastName,doctor.medicalCenter, doctor.areaOfSpec, doctor.Intro, doctor.picUrl,round(AVG(rating.scale),0) as avgscare, COUNT(rating.scale) AS scalecount, COUNT(booking.bookingID) as bookingcount
                                FROM doctor LEFT JOIN plan ON doctor.doctorID = plan.doctorID
                                LEFT JOIN booking
                                ON plan.planID = booking.planID
                                LEFT JOIN rating
                                on booking.bookingID = rating.bookingID
                                GROUP BY doctor.doctorID";
    
                $stmt = $this->conn->prepare($doctor_list);
                $stmt->execute();
                $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
                if($result == false) {
                    return false;
                } else {
                    return $result;
                }
            } catch(PDOException $e) {
                echo "allDoctorList error"; die();
            }  
        }
    
        //homepage: show rating information
        public function showRatinginfo($doctorid) {
            try {
                $rating_list = "SELECT plan.doctorID, rating.ratingID, rating.ratingTime, rating.content, rating.scale, user.userName, doctor.firstName, doctor.lastName
                                FROM rating
                                INNER JOIN booking ON rating.bookingID = booking.bookingID
                                INNER JOIN user ON booking.userID = user.userID
                                INNER JOIN plan ON plan.planID = booking.planID
                                INNER JOIN doctor ON doctor.doctorID = plan.doctorID
                                WHERE plan.doctorID = :doctorid
                                ORDER BY rating.ratingTime DESC"; 
        
                $stmt = $this->conn->prepare($rating_list);
                $stmt->bindParam(':doctorid', $doctorid, PDO::PARAM_INT);
                $stmt->execute();
                $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
                if($result == false) {
                    return false;
                } else {
                    return $result;
                }
            } catch(PDOException $e) {
                echo "allRatingList error"; die();
            }  
        }
        //homepage: show available app information
        public function showAppinfo($doctorid) {
            try {
                // $app_list = "SELECT planID,DAYOFWEEK(planDate) as dayOfWeek ,planDate,planTimeStart FROM plan
                // where DATEDIFF(planDate,NOW())<30 AND DATEDIFF(planDate,NOW())>=0 AND doctorID = :doctorid AND plan.planID NOT in (SELECT planID FROM booking)
                // ORDER by planDate ASC";
                $app_list = "SELECT plan.planID, DAYOFWEEK(plan.planDate) as dayOfWeek, plan.planDate, plan.planTimeStart, doctor.firstName, doctor.lastName 
                            FROM plan
                            INNER JOIN doctor
                            ON plan.doctorID = doctor.doctorID
                            where DATEDIFF(planDate,NOW())<30 AND DATEDIFF(planDate,NOW())>=0 AND plan.doctorID = :doctorid AND plan.planID NOT in (SELECT planID FROM booking)
                            ORDER by planDate ASC";

                $stmt = $this->conn->prepare($app_list);
                $stmt->bindParam(':doctorid', $doctorid, PDO::PARAM_INT);
                $stmt->execute();
                $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
                if($result == false) {
                    return false;
                } else {
                    return $result;
                }
            } catch(PDOException $e) {
                echo "Available Appointments List error"; die();
            }  
        }

        //appointment page: show app history
        public function showAppHistory($userid) {
            try {
                $apphistory_list = "SELECT doctor.firstName, doctor.lastName, plan.planDate, plan.planTimeStart, booking.userID, booking.bookingID,  (SELECT COUNT(bookingID) FROM rating WHERE bookingID = booking.bookingID) AS rated, DATEDIFF(plan.planDate, CURRENT_DATE()) AS days
                                    FROM booking
                                    INNER JOIN plan ON booking.planID = plan.planID AND booking.userID = :userid
                                    INNER JOIN doctor ON doctor.doctorID = plan.doctorID
                                    LEFT JOIN rating ON booking.bookingID = rating.bookingID
                                    ORDER BY plan.planDate DESC, plan.planTimeStart ASC";

                $stmt = $this->conn->prepare($apphistory_list);
                $stmt->bindParam(':userid', $userid, PDO::PARAM_INT);
                $stmt->execute();
                $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
                if($result == false) {
                    return false;
                } else {
                    return $result;
                }
            } catch(PDOException $e) {
                echo "Available Appointments List error"; die();
            }  
        }

        //homepage: book appt
        public function booking_process($userid, $planid) { 
            $newbooking = "INSERT INTO booking(userID, planID) VALUES (:userid, :planid)";
            $stmt = $this->conn->prepare($newbooking);
            $stmt->bindParam(':userid', $userid);
            $stmt->bindParam(':planid', $planid);
            if ($stmt->execute()) { 
                return true;
            } else {
                return false; 
            }
        }

        // planid check before booking, check this planid if already booked
        public function planidCheck($planid) {
            try {
                $planidcheck = "SELECT * FROM booking WHERE planID = :planid";
                $stmt = $this->conn->prepare($planidcheck);
                $stmt->bindParam(':planid', $planid);
                $stmt->execute();
                $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
                    if(count($result) <= 0) {
                        return 1; //planid not exist
                    } else { 
                        return 0; //planid exist
                    }
            } catch (PDOException $e) {
                echo "rating error"; die();
            }
        }

        //appointment page: cancel appt
        public function cancelAppt_process($bookingid, $userid) {
            $cancelAppt = "DELETE FROM booking WHERE bookingID = :bookingid and userID = :userid";
            $stmt = $this->conn->prepare($cancelAppt);
            $stmt->bindParam(':bookingid', $bookingid, PDO::PARAM_INT);
            $stmt->bindParam(':userid', $userid);
            if ($stmt->execute()) { 
                return true;
            } else {
                return false; 
            }
        }

        //appointment page: read rating
        public function readRating_process($bookingid) {
            try {
                $rating = "SELECT * FROM rating WHERE bookingID = :bookingid";
                $stmt = $this->conn->prepare($rating);
                $stmt->bindParam(':bookingid', $bookingid, PDO::PARAM_INT);
                $stmt->execute();
                $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
                if($result == false) {
                    return false;
                } else {
                    return $result;
                }
            } catch(PDOException $e) {
                echo "allRatingList error"; die();
            }  
        }
        //appointment page: get bookingid
        public function getBookingid_process($bookingid) {
            try {
                $rating = "SELECT * FROM booking WHERE bookingID = :bookingid";
                $stmt = $this->conn->prepare($rating);
                $stmt->bindParam(':bookingid', $bookingid, PDO::PARAM_INT);
                $stmt->execute();
                $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
                if($result == false) {
                    return false;
                } else {
                    return $result;
                }
            } catch(PDOException $e) {
                echo "allRatingList error"; die();
            }  
        }

        //check bookingID if exist in the rating table when add rating (check if the appt already rated)
        public function bookingIDCheck($bookingid) {
            try {
                $bookingIDcheck = "SELECT * FROM rating WHERE bookingID = :bookingid";
                $stmt = $this->conn->prepare($bookingIDcheck);
                $stmt->bindParam(':bookingid', $bookingid);
                $stmt->execute();
                $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
                    if(count($result) <= 0) {
                        return 0; //not exist
                    } else { 
                        return 1; //bookingid exist, already rated
                    }
            } catch (PDOException $e) {
                echo "username error"; die();
            }
        }

        //appointment page: add rating
        public function addRating_process($bookingid, $scale, $content) {
            // global $conn;
                $newrating = "INSERT INTO rating(bookingid, scale, content) VALUES (:bookingid, :scale, :content)";
                $stmt = $this->conn->prepare($newrating);
                $stmt->bindParam(':bookingid', $bookingid);
                $stmt->bindParam(':scale', $scale);
                $stmt->bindParam(':content', $content);
                if ($stmt->execute()) { 
                    return true;
                } else {
                    return false; 
                }
        }

        //appointment page: update rating
        public function updateRating_process($ratingid, $scale, $content) {
            $editrating = "UPDATE rating SET scale = :scale, content = :content WHERE ratingID = :ratingid";
            $stmt = $this->conn->prepare($editrating);
            $stmt->bindParam(':ratingid', $ratingid);
            $stmt->bindParam(':scale', $scale);
            $stmt->bindParam(':content', $content);
            if ($stmt->execute()) { 
                return true;
            } else {
                return false; 
            }
        }

        //appointment page: del rating
        public function delRating_process($ratingid) {
            // global $conn;
            $delrating = "DELETE FROM rating WHERE ratingID = :ratingid"; 
            $stmt = $this->conn->prepare($delrating);
            $stmt->bindParam(':ratingid', $ratingid, PDO::PARAM_INT);
            if ($stmt->execute()) { 
                return true;
            } else {
                return false; 
            }
        }

        // ratingid check before delete rating
        public function ratingidCheck($ratingid) {
            try {
                $ratingidcheck = "SELECT * FROM rating WHERE ratingID = :ratingid";
                $stmt = $this->conn->prepare($ratingidcheck);
                $stmt->bindParam(':ratingid', $ratingid);
                $stmt->execute();
                $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
                    if(count($result) <= 0) {
                        return 1; //ratingid not exist
                    } else { 
                        return 0; //raingid exist
                    }
            } catch (PDOException $e) {
                echo "rating error"; die();
            }
        }

        // admin：doctor registration
        public function addDoctor($dfirstname, $dlastname, $ddateofbirth, $demail, $dcontactnumber, $dpicurl, $dintro, $dmedicalcenter, $dareaofspec) {
            $newdoctor = "INSERT INTO doctor(firstName, lastName, dateOfBirth, email, contactNumber, picUrl, intro, medicalCenter, areaOfSpec) VALUES (:dfirstname, :dlastname, :ddateofbirth, :demail, :dcontactnumber, :dpicurl, :dintro, :dmedicalcenter, :dareaofspec)";
            $stmt = $this->conn->prepare($newdoctor);
            $stmt->bindParam(':dfirstname', $dfirstname);
            $stmt->bindParam(':dlastname', $dlastname);
            $stmt->bindParam(':ddateofbirth', $ddateofbirth);
            $stmt->bindParam(':demail', $demail);
            $stmt->bindParam(':dcontactnumber', $dcontactnumber);
            $stmt->bindParam(':dpicurl', $dpicurl);
            $stmt->bindParam(':dintro', $dintro);
            $stmt->bindParam(':dmedicalcenter', $dmedicalcenter);
            $stmt->bindParam(':dareaofspec', $dareaofspec);
            
            if ($stmt->execute()) { 
                return true;
            } else {
                return false; 
            }
        }

        // admin：read doctor name
        public function readDoctorName() {
            try {
                $doctorName_list = "SELECT * FROM doctor";
    
                $stmt = $this->conn->prepare($doctorName_list);
                $stmt->execute();
                $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
                if($result == false) {
                    return false;
                } else {
                    return $result;
                }
            } catch(PDOException $e) {
                echo "allDoctorList error"; die();
            }  
        }

        //admin page: del doctor
        public function delDoctor_process($doctorid) {
            // global $conn;
            $deldoctor = "DELETE FROM doctor WHERE doctorID = :doctorid"; 
            $stmt = $this->conn->prepare($deldoctor);
            $stmt->bindParam(':doctorid', $doctorid, PDO::PARAM_INT);
            if ($stmt->execute()) { 
                return true;
            } else {
                return false; 
            }
        }

        // admin: plan appointment
        public function PlanAppt($doctorid, $plandate, $starttime, $endtime) {
            $newdoctor = "INSERT INTO plan(doctorID, planDate, planTimeStart, planTimeEnd) VALUES (:doctorid, :plandate, :starttime, :endtime)";
            $stmt = $this->conn->prepare($newdoctor);
            $stmt->bindParam(':doctorid', $doctorid);
            $stmt->bindParam(':plandate', $plandate);
            $stmt->bindParam(':starttime', $starttime);
            $stmt->bindParam(':endtime', $endtime);
           
            
            if ($stmt->execute()) { 
                return true;
            } else {
                return false;
            }
        }
    }
?>
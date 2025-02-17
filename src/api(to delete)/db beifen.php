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

            // // upload
            // $target_dir = "uploads/";
            // $target_file = $target_dir . basename($_FILES["fileToUpload"]["name"]);
            // $uploadOk = 1;
            // $imageFileType = strtolower(pathinfo($target_file,PATHINFO_EXTENSION));

            // // Check if image file is a actual image or fake image
            // if(isset($_POST["submit"])) {
            // $check = getimagesize($_FILES["fileToUpload"]["tmp_name"]);
            // if($check !== false) {
            //     echo "File is an image - " . $check["mime"] . ".";
            //     $uploadOk = 1;
            // } else {
            //     echo "File is not an image.";
            //     $uploadOk = 0;
            // }
            // }

            // // Check if file already exists
            // if (file_exists($target_file)) {
            // echo "Sorry, file already exists.";
            // $uploadOk = 0;
            // }

            // // Check file size
            // if ($_FILES["fileToUpload"]["size"] > 500000) {
            // echo "Sorry, your file is too large.";
            // $uploadOk = 0;
            // }

            // // Allow certain file formats
            // if($imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg"
            // && $imageFileType != "gif" ) {
            // echo "Sorry, only JPG, JPEG, PNG & GIF files are allowed.";
            // $uploadOk = 0;
            // }

            // // Check if $uploadOk is set to 0 by an error
            // if ($uploadOk == 0) {
            // echo "Sorry, your file was not uploaded.";
            // // if everything is ok, try to upload file
            // } else {
            // if (move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_file)) {
            //     echo "The file ". htmlspecialchars( basename( $_FILES["fileToUpload"]["name"])). " has been uploaded.";
            // } else {
            //     echo "Sorry, there was an error uploading your file.";
            // }
            // }
            
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

        // admin：availabel appt  list
        public function availableAppt_process() {
            try {
                $appt_list = "SELECT doctor.doctorID,doctor.firstName, doctor.lastName, doctor.medicalCenter,plan.planID,plan.planDate, plan.planTimeStart, plan.planTimeEnd FROM plan 
                INNER JOIN doctor
                on plan.doctorID = doctor.doctorID
                WHERE planID NOT IN (SELECT planID FROM booking)
                ORDER BY planID ASC";
    
                $stmt = $this->conn->prepare($appt_list);
                $stmt->execute();
                $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
                if($result == false) {
                    return false;
                } else {
                    return $result;
                }
            } catch(PDOException $e) {
                echo "apptList error"; die();
            }  
        }

        //admin page: del doctor
        public function delDoctor_process($doctorid) {
            // global $conn;
            $deldoctor = "DELETE FROM doctor WHERE doctorID = :doctorid"; 
            $stmt = $this->conn->prepare($deldoctor);
            $stmt->bindParam(':doctorid', $doctorid, PDO::PARAM_INT);
            $result = $stmt->execute();
            
            if ($result) { 
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

        //admin page: del appt plan
        public function delApptPlan_process($planid) {
            $delApptPlan = "DELETE FROM plan WHERE planID = :planid"; 
            $stmt = $this->conn->prepare($delApptPlan);
            $stmt->bindParam(':planid', $planid, PDO::PARAM_INT);
            $result = $stmt->execute();
            
            if ($result) { 
                return true;
            } else {
                return false; 
            }
        }

        //admin page: show all ratings
        public function allRatings_process() {
            try {
                $appt_list = "SELECT rating.ratingID, rating.scale, rating.content, rating.ratingTime, plan.planDate, plan.planTimeStart,doctor.firstName, doctor.lastName
                FROM plan
                INNER JOIN doctor
                ON plan.doctorID = doctor.doctorID
                INNER JOIN booking
                ON plan.planID = booking.planID
                INNER JOIN rating
                on rating.bookingID = booking.bookingID
                ORDER BY rating.ratingID";
    
                $stmt = $this->conn->prepare($appt_list);
                $stmt->execute();
                $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
                if($result == false) {
                    return false;
                } else {
                    return $result;
                }
            } catch(PDOException $e) {
                echo "apptList error"; die();
            }  
        }

        //admin page: del ratings
        public function adminDelRating_process($ratingid) {
            $adminDelRating = "DELETE FROM rating WHERE ratingID = :ratingid"; 
            $stmt = $this->conn->prepare($adminDelRating);
            $stmt->bindParam(':ratingid', $ratingid, PDO::PARAM_INT);
            $result = $stmt->execute();
            
            if ($result) { 
                return true;
            } else {
                return false; 
            }
        }


        //admin page: appt detail
        public function apptDetail_process($planid) {
            $apptDetail = "SELECT plan.planID, plan.planDate, plan.planID, plan.planTimeEnd, plan.planTimeStart, plan.doctorID, doctor.firstName, doctor.lastName
                        FROM plan INNER JOIN doctor
                        ON plan.doctorID = doctor.doctorID
                        WHERE plan.planID = :planid"; 
            $stmt = $this->conn->prepare($apptDetail);
            $stmt->bindParam(':planid', $planid, PDO::PARAM_INT);
            $result = $stmt->execute();
            $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
            if($result == false) {
                return false;
            } else {
                return $result;
            }
        }

        //admin page: appt edit
          public function apptEdit_process($planid, $doctorid, $plandate, $starttime, $endtime) {
            $apptEdit = "UPDATE plan SET doctorID = :doctorid, planDate = :plandate, planTimeStart = :starttime, planTimeEnd = :endtime WHERE planID = :planid";
            $stmt = $this->conn->prepare($apptEdit);
            $stmt->bindParam(':planid', $planid);
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
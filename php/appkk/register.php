<?php 
    $db = mysqli_connect('localhost', 'root', '' ,'app_bu');
    if (!$db) {
        echo '555555555555';
    } 

    $studentidStr = $_POST['student_id'];
    $passwordStr = $_POST['password'];


    $sql = "SELECT * FROM account WHERE student_id = '".$studentidStr."' AND password = '".$passwordStr."'";

    $result = mysqli_query($db,$sql);
    $count = mysqli_num_rows($result);

    if ($count == 1) {
        echo jason_encode("Error");
    } else {
        $insert = "INSERT INTO account( student_id,password) VALUES ('".$studentidStr."','".$passwordStr."')";
        $query = mysqli_query($db,$insert);
        if ($query) {
            echo json_encode("Success");
        }
    }
    

?>









?>
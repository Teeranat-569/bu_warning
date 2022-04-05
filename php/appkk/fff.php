<?php 

$db = mysqli_connect('localhost','root', '', 'app_bu');
if (!$db) {
    echo "database failre";
    # code...
}

$studentidSTR = $_POST['student_id'];
$passwordSTR = $_POST['password'];

$sql = "SELECT * FROM account WHERE student_id = '".$studentidSTR."'AND password = '".$passwordSTR."'";

    $result = mysqli_query($db,$sql);
	$count = mysqli_num_rows($result);
	
	if ($count >= 1) {
		echo json_encode("Success");
	}else {
		echo json_encode("Error");
	}
?>
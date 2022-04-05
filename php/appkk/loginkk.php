<?php 

$db = mysqli_connect('localhost','root', '', 'app_bu');

$studentidS = $_POST['student_id'];
$passwordS = $_POST['password'];

$sql = "SELECT * FROM account WHERE student_id = '".$studentidS."'AND password = '".$passwordS."'";

    $result = mysqli_query($db,$sql);
	$count = mysqli_num_rows($result);
	
	if ($count == 1) {
		echo json_encode("Success");
	}else {
		echo json_encode("Error");
	}
?>
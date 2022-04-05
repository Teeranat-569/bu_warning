<?php 

$db = mysqli_connect('localhost','root', '', 'nn');

$studentidStr = $_POST['student_id'];
$passwordStr = $_POST['password'];

$sql = "SELECT * FROM account WHERE student_id = '".$studentidStr."'AND password = '".$passwordStr."'";

    $result = mysqli_query($db,$sql);
	$count = mysqli_num_rows($result);
	
	if ($count == 1) {
		echo json_encode("Success");
	}else {
		echo json_encode("Error");
	}
?>
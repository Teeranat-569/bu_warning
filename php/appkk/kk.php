<?php
$link = mysqli_connect("localhost", "root", "", "app_bu")
or die("ผดิพลาด! ไมสามารถเชื่อมต่อไปยังฐานข้อมูลได"); 
 mysqli_query($link, "SET NAMES utf8"); 

$studentidSTR = $_POST['student_id'];
$passwordSTR = $_POST['password'];

 $sql = "SELECT * FROM account WHERE student_id = '".$studentidSTR."'AND password = '".$passwordSTR."'";

    $result = mysqli_query($link,$sql);
	$count = mysqli_num_rows($result);
	
	if ($count == 1) {
		echo json_encode("Success");
	}else {
		echo json_encode("Error");
	}
 ?>
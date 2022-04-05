<?php 

include './connection.php';

$student_id = $_POST['student_id'];
$password = $_POST['password'];

$conn = $connect->query( "SELECT * FROM user WHERE student_id = '".$student_id."'and password = '".$password."' ");

$result = array();
while ($ex = $conn->fetch_assoc()) {
$result = $ex;   # code...
}

echo json_encode($result);


?>
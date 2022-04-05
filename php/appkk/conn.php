<?php 
$connect = new mysqli ("localhost","root","","app_bu");

if ($connect) {
	
	echo "jjjjjj";
	# code...
} else {
	# code...
	echo "Connection Failed";
	exit();
}

 ?>
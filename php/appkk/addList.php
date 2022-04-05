<?php
header("content-type:text/javascript;charset=utf-8");
error_reporting(0);
error_reporting(E_ERROR | E_PARSE);
$link = mysqli_connect('localhost', 'root', '', "kk");

if (!$link) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    
    exit;
}

if (!$link->set_charset("utf8")) {
    printf("Error loading character set utf8: %s\n", $link->error);
    exit();
	}

if (isset($_GET)) {
	if ($_GET['isAdd'] == 'true') {

		$DateTime = $_GET['DateTime_warning'];	
		$time = $_GET['time'];	
		$idUser = $_GET['idUser'];
		$nameUser = $_GET['nameUser'];
		$nameForm = $_GET['nameForm'];		
		$buildForm = $_GET['buildForm'];
		$buildkk = $_GET['build_kk'];
		$floor = $_GET['floors_pp'];
		$room = $_GET['numRoom'];
		$moreForm = $_GET['moreForm'];
		$airForm = $_GET['airForm'];
		$phone = $_GET['phone'];
		$fileIMG = $_GET['fileIMG'];
		$fileIMG2 = $_GET['fileIMG2'];
		$status = $_GET['status'];	
		$dateEnd = $_GET['end_date'];	
		$timeEnd = $_GET['time_end'];	
		$token = $_GET['token'];
		$rate = $_GET['rate'];

		$sql = "INSERT INTO `warninglist`(`id`, `DateTime_warning`, `time`,`idUser`,`nameUser`, `nameForm`, `build_kk`, `floors_pp`,`numRoom`,`moreForm`, `airForm`,`phone`, `fileIMG`,`fileIMG2`, `status`, `token`, `end_date`, `time_end`, `rate`) 
		                          VALUES (NULL,'$DateTime','$time','$idUser','$nameUser','$nameForm','$buildkk','$floor','$room','$moreForm','$airForm','$phone','$fileIMG','$fileIMG2','$status','$token','$dateEnd','$timeEnd','$rate')";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Welcome Master UNG";
   
}
	mysqli_close($link);
?>
<?php
header("content-type:text/javascript;charset=utf-8");
error_reporting(0);
error_reporting(E_ERROR | E_PARSE);
$link = mysqli_connect('localhost', 'root', '', "kk");
									//username      //password   //ชื่อฐานข้อมูล
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
				
		
		
		$buildForm = $_GET['build_kk'];
		$floorsForm = $_GET['floors_pp'];
		$numRoomForm = $_GET['numRoom'];
		$placeName = $_GET['placeName'];
	
							
		$sql = "INSERT INTO `house`(`id`, `build_kk`, `floors_pp`, `numRoom`, `placeName`) VALUES (Null, `$buildForm`, `$floorsForm`, `p$numRoomForm`, `$placeName`)";

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
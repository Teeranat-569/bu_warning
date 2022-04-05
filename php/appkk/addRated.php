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
				
		$idWarning = $_GET['idWarning'];
		$rate = $_GET['rate'];
		$comment = $_GET['comment_rec'];
		$buildkk = $_GET['build_kk'];
		$floor = $_GET['floors_pp'];
		$room = $_GET['numRoom'];
		$moreForm = $_GET['moreForm'];
							
		$sql = "INSERT INTO `rate`(`id`, `idWarning`, `rate`, `comment_rec`,`build_kk`, `floors_pp`,`numRoom`,`moreForm`) VALUES (NULL,'$idWarning','$rate','$comment','$buildkk','$floor','$room','$moreForm')";

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
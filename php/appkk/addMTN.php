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
		$autoID =  $_GET['mtn_autoID'];	
		$name = $_GET['mtn_name'];		
		$lastname = $_GET['mtn_lastname'];
		$password = $_GET['password'];
		$phone = $_GET['mtn_phone'];
		$chooseRadio = $_GET['gender'];
		$token = $_GET['token_mtn'];
							
		$sql = "INSERT INTO `maintenance`(`id_mtn`, `mtn_autoID`, `mtn_name`, `mtn_lastname`, `password`, `mtn_phone`, `gender`, `token_mtn`) VALUES (Null,'$autoID','$name','$lastname','$password','$phone','$chooseRadio','$token')";

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
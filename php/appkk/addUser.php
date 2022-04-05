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

		$studentidStr = $_GET['student_id'];		
		$nameStr = $_GET['name'];
		$passwordStr = $_GET['password'];
		$level = $_GET['level'];
		$chooseRadio = $_GET['gender'];
		$position = $_GET['position'];
		$token = $_GET['token'];
							
		$sql = "INSERT INTO `user`(`id`, `student_id`, `name`, `password`, `level`, `gender`, `position`, `token`) VALUES (Null,'$studentidStr','$nameStr','$passwordStr','$level','$chooseRadio','$position','$token')";

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
<?php

include "./connection.php";

$sql1="SELECT rate FROM rate";

$result1=mysqli_db_query("kk",$sql1);

$row=mysqli_num_rows($result1);

$rown=mysqli_fetch_array($result1);

echo $row;

?>
<?php
include "./connection.php";

$building = $connect->query("SELECT * FROM building");
$list = array();

while ($rowdata = $building->fetch_assoc()) {
    $list[] = $rowdata;
    # code...
}

echo json_encode($list);



?>
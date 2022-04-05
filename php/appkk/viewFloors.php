<?php
include "./connection.php";

$building = $connect->query("SELECT * FROM floors");
$list = array();

while ($rowdata = $building->fetch_assoc()) {
    $list[] = $rowdata;
    # code...
}

echo json_encode($list);



?>
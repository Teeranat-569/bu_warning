<?php
include "./connection.php";

$id = $_GET['id'];

$building = $connect->query("SELECT * FROM warninglist where id = $id");
$list = array();

while ($rowdata = $building->fetch_assoc()) {
    $list[] = $rowdata;
    # code...
}

echo json_encode($list);



?>
<?php 
    include 'connection.php';

    $queryResult = $connect->query("SELECT * FROM user");

    $result = array();

    while ($fetchdata=$queryResult->fetch_assoc()) {
 $result[] = $fetchdata;        # code...
    }

    echo json_encode($result);
?>
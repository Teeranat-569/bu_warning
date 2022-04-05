<?php 
include './connection.php';

error_reporting(E_ERROR | E_PARSE);

// Response object structure
$response = new stdClass;
$response->status = null;
$response->message = null;


$destination_dir = "warninglist/";
$base_filename = basename($_FILES["file"]["name"]);
$base_filename2 = basename($_FILES["file2"]["name"]);
$target_file = $destination_dir . $base_filename;
$target_file2 = $destination_dir . $base_filename2;


if(!$_FILES["file"]["error"] && !$_FILES["file2"]["error"])
{
    if (move_uploaded_file($_FILES["file"]["tmp_name"], $target_file)&&move_uploaded_file($_FILES["file2"]["tmp_name"], $target_file2) ) {        
        $response->status = true;
        $response->message = "File uploaded successfully";

    } else {

        $response->status = false;
        $response->message = "File uploading failed";
    }    
} 
else
{
    $response->status = false;
    $response->message = "File uploading failed";
}

header('Content-Type: application/json');
echo json_encode($response);
?>

<?php
require_once "../../config/database.php";
require_once "../../helpers/response.php";
require_once "../../helpers/middleware.php";

$user = authMiddleware();

$data = json_decode(file_get_contents("php://input"));
if(!isset($data->id,$data->instructor_id)){
    sendResponse(false,"Invalid input");
}

$id = (int) $data->id;
$instructor_id = (int) $data->instructor_id;

$sql = "UPDATE courses 
    SET instructor_id = NULL,
        updated_at = NOW()
    WHERE id = $id";

$query = $conn->prepare($sql);
if($query->execute()){
    sendResponse(true,"Instructor Course deleted");
} else {
    sendResponse(false,"Failed to delete Instructor course");
}

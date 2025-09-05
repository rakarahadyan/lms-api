<?php
require_once "../../config/database.php";
require_once "../../helpers/response.php";
require_once "../../helpers/middleware.php";

$user = authMiddleware();

$data = json_decode(file_get_contents("php://input"));
if(!isset($data->title,$data->description)){
    sendResponse(false,"Invalid input");
}

$id = (int) $data->id;
$title         = $conn->quote($data->title);
$description   = $conn->quote($data->description);
$category      = $conn->quote($data->category);
$cover_image      = $conn->quote($data->cover_image);
$start_date    = $conn->quote($data->start_date);
$end_date      = $conn->quote($data->end_date);

$sql = "UPDATE courses 
    SET title = $title,
        description = $description,
        category = $category,
        cover_image = $cover_image,
        start_date = $start_date,
        end_date = $end_date,
        updated_at = NOW()
    WHERE id = $id";

$query = $conn->prepare($sql);
if($query->execute()){
    sendResponse(true,"Course updated");
} else {
    sendResponse(false,"Failed to update course");
}

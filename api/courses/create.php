<?php
require_once "../../config/database.php";
require_once "../../helpers/response.php";
require_once "../../helpers/middleware.php";

$user = authMiddleware();

$data = json_decode(file_get_contents("php://input"));
if (!isset($data->title, $data->description)) {
    sendResponse(false, "Invalid input");
}

$title         = $conn->quote($data->title);
$description   = $conn->quote($data->description);
$category      = $conn->quote($data->category);
$cover_image   = $conn->quote($data->cover_image);
$start_date    = $conn->quote($data->start_date);
$end_date      = $conn->quote($data->end_date);

$sql = "INSERT INTO courses (title, description, category, cover_image, start_date, end_date) 
        VALUES ($title, $description, $category, $cover_image, $start_date, $end_date)";

if ($conn->exec($sql)) {
    sendResponse(true, "Course created");
} else {
    sendResponse(false, "Failed to create course");
}

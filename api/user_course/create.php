<?php
require_once "../../config/database.php";
require_once "../../helpers/response.php";
require_once "../../helpers/middleware.php";

$user = authMiddleware();

$data = json_decode(file_get_contents("php://input"));
if (!isset($data->user_id, $data->course_id)) {
    sendResponse(false, "Invalid input");
}

$user_id = (int) $data->user_id;
$course_id = (int) $data->course_id;

$sql = "INSERT INTO user_courses (user_id, course_id) VALUES ($user_id, $course_id)";

if ($conn->exec($sql)) {
    sendResponse(true, "User enrolled successfully");
} else {
    sendResponse(false, "Failed to create User course");
}

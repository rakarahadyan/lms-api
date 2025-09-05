<?php
require_once "../../config/database.php";
require_once "../../helpers/response.php";
require_once "../../helpers/middleware.php";

$user = authMiddleware();

$data = json_decode(file_get_contents("php://input"));
if (!isset($data->id, $data->user_id, $data->course_id)) {
    sendResponse(false, "Invalid input");
}

$id = (int) $data->id;
$user_id = (int) $data->user_id;
$course_id = (int) $data->course_id;
$progress   = $conn->quote($data->progress);
$status   = $conn->quote($data->status);

$sql = "UPDATE user_courses 
    SET user_id = $user_id,
        course_id = $course_id,
        progress = $progress,
        status = $status
    WHERE id = $id";

if ($conn->exec($sql)) {
    sendResponse(true, "User course progress updated");
} else {
    sendResponse(false, "Failed to create User course");
}

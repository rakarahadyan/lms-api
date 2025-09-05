<?php
require_once "../../config/database.php";
require_once "../../helpers/response.php";
require_once "../../helpers/middleware.php";

$user = authMiddleware();

$data = json_decode(file_get_contents("php://input"));
if (!isset($data->id)) {
    sendResponse(false, "Invalid input");
}

$id = (int) $data->id;
$course_id = (int) $data->course_id;
$user_id = (int) $data->user_id;

$sql = "DELETE FROM user_courses WHERE id = $id and user_id = $user_id and course_id = $course_id";
$query = $conn->prepare($sql);

if ($query->execute()) {
    sendResponse(true, "User unenrolled successfully");
} else {
    sendResponse(false, "Failed to delete User course");
}

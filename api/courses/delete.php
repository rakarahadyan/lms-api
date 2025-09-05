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

$sql = "DELETE FROM courses WHERE id = $id";
$query = $conn->prepare($sql);

if ($query->execute()) {
    sendResponse(true, "Course deleted");
} else {
    sendResponse(false, "Failed to delete course");
}

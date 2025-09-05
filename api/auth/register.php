<?php
require_once "../../config/database.php";
require_once "../../helpers/response.php";

$data = json_decode(file_get_contents("php://input"));

if(!isset($data->name, $data->email, $data->password, $data->role)){
    sendResponse(false, "Invalid input");
}

$password = password_hash($data->password, PASSWORD_BCRYPT);

$query = $conn->prepare("INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, ?)");
if($query->execute([$data->name, $data->email, $password, $data->role])) {
    sendResponse(true, "User registered successfully");
} else {
    sendResponse(false, "Registration failed");
}

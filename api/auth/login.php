<?php
require_once "../../config/database.php";
require_once "../../helpers/response.php";
require_once "../../helpers/jwt.php";

global $secret_key;

$data = json_decode(file_get_contents("php://input"));
if(!isset($data->email, $data->password)){
    sendResponse(false, "Invalid input");
}

$query = $conn->prepare("SELECT * FROM users WHERE email = ? LIMIT 1");
$query->execute([$data->email]);
$user = $query->fetch(PDO::FETCH_ASSOC);

if($user && password_verify($data->password, $user['password'])) {
    $payload = [
        "id" => $user['id'],
        "email" => $user['email'],
        "role" => $user['role'],
        "exp" => time() + (60*60) // 1 jam
    ];
    $jwt = generateJWT($payload, $secret_key);
    sendResponse(true, "Login success", ["username" => $user['name'], "token" => $jwt]);
} else {
    sendResponse(false, "Invalid credentials");
}

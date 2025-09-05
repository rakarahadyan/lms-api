<?php
require_once "jwt.php";
require_once "response.php";

function authMiddleware() {
    global $secret_key;

    $headers = getallheaders();
    if(!isset($headers['Authorization'])) {
        sendResponse(false, "Authorization header missing");
    }

    $authHeader = $headers['Authorization'];
    if(strpos($authHeader, "Bearer ") !== 0) {
        sendResponse(false, "Invalid Authorization format");
    }

    $jwt = substr($authHeader, 7);
    $payload = validateJWT($jwt, $secret_key);

    if(!$payload || $payload['exp'] < time()) {
        sendResponse(false, "Invalid or expired token");
    }

    return $payload;
}

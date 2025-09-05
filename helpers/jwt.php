<?php
$secret_key = "ahas12365";

function generateJWT($payload, $secret_key) {
    $header = base64_encode(json_encode(["alg" => "HS256", "typ" => "JWT"]));
    $payload = base64_encode(json_encode($payload));
    $signature = hash_hmac("sha256", "$header.$payload", $secret_key, true);
    $signature = base64_encode($signature);

    return "$header.$payload.$signature";
}

function validateJWT($jwt, $secret_key) {
    $parts = explode(".", $jwt);
    if(count($parts) != 3) return false;

    list($header, $payload, $signature) = $parts;
    $valid_signature = base64_encode(hash_hmac("sha256", "$header.$payload", $secret_key, true));

    if($signature === $valid_signature) {
        return json_decode(base64_decode($payload), true);
    }
    return false;
}

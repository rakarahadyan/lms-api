<?php
require_once "../../config/database.php";
require_once "../../helpers/response.php";

$data = json_decode(file_get_contents("php://input"));
$search = isset($data->search) ? "%".$data->search."%" : "%";
$page   = isset($data->page) ? (int)$data->page : 1;
$limit  = isset($data->limit) ? (int)$data->limit : 10;
$offset = ($page-1)*$limit;

$query = $conn->prepare("
    SELECT id,name,email,role,created_at 
    FROM users
    WHERE name LIKE ? OR email LIKE ?
    LIMIT ? OFFSET ?
");
$query->execute([$search,$search,$limit,$offset]);
$rows = $query->fetchAll(PDO::FETCH_ASSOC);

sendResponse(true,"Users fetched",$rows);

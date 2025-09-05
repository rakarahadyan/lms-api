<?php
require_once "../../config/database.php";
require_once "../../helpers/response.php";
require_once "../../helpers/middleware.php";

$user = authMiddleware();

$data = json_decode(file_get_contents("php://input"));
$search = isset($data->search) ? "%".$data->search."%" : "%";
$page   = isset($data->page) ? (int)$data->page : 1;
$limit  = isset($data->limit) ? (int)$data->limit : 10;
$offset = ($page-1)*$limit;

$sql = "
    SELECT c.*, u.name as instructor_name 
    FROM courses c 
    LEFT JOIN users u ON c.instructor_id = u.id
    WHERE c.title LIKE :search
    LIMIT $limit OFFSET $offset
";
$query = $conn->prepare($sql);
$query->bindValue(':search', $search, PDO::PARAM_STR);
$query->execute();
$rows = $query->fetchAll(PDO::FETCH_ASSOC);

sendResponse(true,"Courses fetched",$rows);

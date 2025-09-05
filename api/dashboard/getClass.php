<?php
require_once "../../config/database.php";
require_once "../../helpers/response.php";
require_once "../../helpers/middleware.php";

$user = authMiddleware();

$data = json_decode(file_get_contents("php://input"));
$search = isset($data->search) ? "%".$data->search."%" : "%";

$sql = "
    SELECT c.*
    FROM courses c
    WHERE c.category LIKE '$search'
";
$query = $conn->prepare($sql);
// $query->bindValue(':search', $search, PDO::PARAM_STR);
$query->execute();
$rows = $query->fetchAll(PDO::FETCH_ASSOC);

sendResponse(true,"class fetched",$rows);

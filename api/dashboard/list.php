<?php
require_once "../../config/database.php";
require_once "../../helpers/response.php";
require_once "../../helpers/middleware.php";

$user = authMiddleware();

$data = json_decode(file_get_contents("php://input"));

$result = [];
$sql_one = "SELECT c.*, (select name from users where id=c.instructor_id ) as instructor_name FROM courses c WHERE c.instructor_id IS NOT NULL ORDER BY id DESC LIMIT 1";
$query_one = $conn->prepare($sql_one);
$query_one->execute();
$result["top"] = $query_one->fetchAll(PDO::FETCH_ASSOC);

$sql_two = "SELECT * 
    FROM courses 
    WHERE category IN ('PROGRAMMING', 'CREATIVE MARKETING', 'MANAGEMENT SDM') 
    ORDER BY id DESC";
$query_two = $conn->prepare($sql_two);
$query_two->execute();
$allCourses = $query_two->fetchAll(PDO::FETCH_ASSOC);

$result["modul"]["PROGRAMMING"] = [];
$result["modul"]["CREATIVE MARKETING"] = [];
$result["modul"]["MANAGEMENT SDM"] = [];

foreach ($allCourses as $course) {
    $cat = $course['category'];
    if (isset($result["modul"][$cat]) && count($result["modul"][$cat]) < 3) {
        $result["modul"][$cat][] = $course;
    }
}

$sql_three = "SELECT s.*, c.title as course_title, c.category, u.name as user_name
    FROM scores s 
    LEFT JOIN courses c ON s.course_id = c.id 
    LEFT JOIN users u ON s.user_id = u.id 
    ORDER BY id DESC 
    LIMIT 5";
$query_three = $conn->prepare($sql_three);
$query_three->execute();
$result["nilai"] = $query_three->fetchAll(PDO::FETCH_ASSOC);

$sql_four = "SELECT s.*, c.title as course_title, c.cover_image as course_image
    FROM schedules s 
    LEFT JOIN courses c ON s.course_id = c.id
    ORDER BY id DESC 
    LIMIT 3";
$query_four = $conn->prepare($sql_four);
$query_four->execute();
$result["jadwal"] = $query_four->fetchAll(PDO::FETCH_ASSOC);

sendResponse(true,"Courses fetched",$result);

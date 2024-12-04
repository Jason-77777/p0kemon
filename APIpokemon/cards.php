<?php
require_once __DIR__ . "/models/mcards.php";

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *"); // Allows all origins
header("Access-Control-Allow-Methods: POST, GET, OPTIONS, DELETE, PUT"); // Allow HTTP methods
header("Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With"); // Allow necessary headers

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

$data = new MCards();
$request_method = $_SERVER["REQUEST_METHOD"];

switch ($request_method) {
    case 'GET':
        if (!empty($_GET["id"])) {
            $id = intval($_GET["id"]);
            $data->get_card_by_id($id);
        } else {
            $data->get_cards();
        }
        break;

    case 'POST':
        $data->insert_card();
        break;

    case 'PUT':
        if (!empty($_GET["id"])) {
            $id = intval($_GET["id"]);
            $data->update_card($id);
        } else {
            echo json_encode(['status' => 400, 'message' => 'Missing ID']);
        }
        break;

    case 'DELETE':
        if (!empty($_GET["id"])) {
            $id = intval($_GET["id"]);
            $data->delete_card($id);
        } else {
            echo json_encode(['status' => 400, 'message' => 'Missing ID']);
        }
        break;

    default:
        header("HTTP/1.1 405 Method Not Allowed");
        break;
}
?>

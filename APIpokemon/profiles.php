<?php
require_once __DIR__ . "/models/mprofiles.php";

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *"); // Allows all origins, you can specify your Flutter app's URL here
header("Access-Control-Allow-Methods: POST, GET, OPTIONS, DELETE, PUT"); // Allow HTTP methods
header("Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With"); // Allow necessary headers


$data = new mprofiles();
$request_method = $_SERVER["REQUEST_METHOD"];

switch ($request_method) {
    case 'GET':
        if (!empty($_GET["id"])) {
            $id = intval($_GET["id"]);
            $data->get_profile_by_id($id);
        } else {
            $data->get_profiles();
        }
        break;

    case 'POST':
        $data->insert_profile();
        break;

    case 'PUT':
        if (!empty($_GET["id"])) {
            $id = intval($_GET["id"]);
            $data->update_profile($id);
        } else {
            echo json_encode(['status' => 400, 'message' => 'Missing ID']);
        }
        break;

    case 'DELETE':
        if (!empty($_GET["id"])) {
            $id = intval($_GET["id"]);
            $data->delete_profile($id);
        } else {
            echo json_encode(['status' => 400, 'message' => 'Missing ID']);
        }
        break;

    default:
        header("HTTP/1.1 405 Method Not Allowed");
        break;
}
?>

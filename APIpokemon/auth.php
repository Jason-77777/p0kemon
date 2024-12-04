<?php
require_once "koneksi.php"; // Include database connection

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *"); // Allows all origins, you can specify your Flutter app's URL here
header("Access-Control-Allow-Methods: POST, GET, OPTIONS, DELETE, PUT"); // Allow HTTP methods
header("Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With"); // Allow necessary headers


// Get HTTP method
$request_method = $_SERVER["REQUEST_METHOD"];

if ($request_method === "POST") {
    $data = json_decode(file_get_contents("php://input"), true);

    // Determine if this is a login or register request
    if (isset($data['action']) && $data['action'] === "login") {
        login($data);
    } elseif (isset($data['action']) && $data['action'] === "register") {
        register($data);
    } else {
        echo json_encode(['status' => 400, 'message' => 'Invalid action']);
    }
}

// Login function
function login($data)
{
    global $mysqli;

    if (isset($data['email'], $data['password'])) {
        $email = $data['email'];
        $password = $data['password'];

        $stmt = $mysqli->prepare("SELECT * FROM profiles WHERE email = ?");
        $stmt->bind_param("s", $email);
        $stmt->execute();

        $result = $stmt->get_result();
        $user = $result->fetch_assoc();

        if ($user && password_verify($password, $user['password'])) {
            echo json_encode(['status' => 200, 'message' => 'Login successful', 'data' => $user]);
        } else {
            echo json_encode(['status' => 401, 'message' => 'Invalid email or password']);
        }
    } else {
        echo json_encode(['status' => 400, 'message' => 'Email and password are required']);
    }
}

// Register function
// Register function
function register($data)
{
    global $mysqli;

    if (isset($data['name'], $data['email'], $data['password'])) {
        $name = $data['name'];
        $email = $data['email'];
        $password = password_hash($data['password'], PASSWORD_BCRYPT); // Hash the password

        // Cek apakah email sudah terdaftar
        $checkEmailStmt = $mysqli->prepare("SELECT id FROM profiles WHERE email = ?");
        $checkEmailStmt->bind_param("s", $email);
        $checkEmailStmt->execute();
        $checkEmailStmt->store_result();

        if ($checkEmailStmt->num_rows > 0) {
            echo json_encode(['status' => 409, 'message' => 'Email already exists']);
            return;
        }

        // Jika email belum terdaftar, masukkan data ke database
        $stmt = $mysqli->prepare("INSERT INTO profiles (name, email, password) VALUES (?, ?, ?)");
        $stmt->bind_param("sss", $name, $email, $password);

        if ($stmt->execute()) {
            // Mengembalikan detail pengguna setelah registrasi berhasil
            echo json_encode([
                'status' => 200,
                'message' => 'Registration successful',
                'data' => [
                    'id' => $mysqli->insert_id,
                    'name' => $name,
                    'email' => $email
                ]
            ]);
        } else {
            echo json_encode(['status' => 500, 'message' => 'Registration failed']);
        }
    } else {
        echo json_encode(['status' => 400, 'message' => 'Name, email, and password are required']);
    }
}

?>

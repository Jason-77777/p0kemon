<?php
require_once __DIR__ . "/../koneksi.php";

class Mprofiles {
    public function get_profiles() {
        global $mysqli;
        $query = "SELECT * FROM profiles";
        $result = $mysqli->query($query);
        $data = [];
        while ($row = $result->fetch_assoc()) {
            $data[] = $row;
        }
        echo json_encode(['status' => 200, 'data' => $data]);
    }

    public function get_profile_by_id($id) {
        global $mysqli;
        $query = "SELECT * FROM profiles WHERE id = $id";
        $result = $mysqli->query($query);
        $data = $result->fetch_assoc();
        echo json_encode(['status' => 200, 'data' => $data]);
    }

    public function insert_profile() {
        global $mysqli;
    
        // Mengambil data menggunakan $_POST
        if (isset($_POST['name']) && isset($_POST['email']) && isset($_POST['password'])) {
            $name = $_POST['name'];
            $email = $_POST['email'];
            $password = password_hash($_POST['password'], PASSWORD_BCRYPT);
            
            $stmt = $mysqli->prepare("INSERT INTO profiles (name, email, password) VALUES (?, ?, ?)");
            $stmt->bind_param("sss", $name, $email, $password);
            $stmt->execute();
            
            echo json_encode(['status' => 200, 'message' => 'Profile created']);
        } else {
            echo json_encode(['status' => 400, 'message' => 'Invalid input']);
        }
    }
    

    public function update_profile($id) {
        global $mysqli;
        $data = json_decode(file_get_contents("php://input"), true);

        if (isset($data['name']) && isset($data['email']) && isset($data['password'])) {
            $stmt = $mysqli->prepare("UPDATE profiles SET name = ?, email = ?, password = ? WHERE id = ?");
            $stmt->bind_param("sssi", $data['name'], $data['email'], $data['password'], $id);
            $stmt->execute();
            echo json_encode(['status' => 200, 'message' => 'Profile updated']);
        } else {
            echo json_encode(['status' => 400, 'message' => 'Invalid input']);
        }
    }

    public function delete_profile($id) {
        global $mysqli;
        $stmt = $mysqli->prepare("DELETE FROM profiles WHERE id = ?");
        $stmt->bind_param("i", $id);
        $stmt->execute();
        echo json_encode(['status' => 200, 'message' => 'Profile deleted']);
    }
}

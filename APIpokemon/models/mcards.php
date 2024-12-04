<?php
require_once __DIR__ . "/../koneksi.php";

class MCards {
    public function get_cards() {
        global $mysqli;
        $query = "SELECT * FROM cards";
        $result = $mysqli->query($query);
        $data = [];
        while ($row = $result->fetch_assoc()) {
            $data[] = $row;
        }
        echo json_encode(['status' => 200, 'data' => $data]);
    }

    public function get_card_by_id($id) {
        global $mysqli;
        $query = "SELECT * FROM cards WHERE id = $id";
        $result = $mysqli->query($query);
        if ($result->num_rows > 0) {
            $data = $result->fetch_assoc();
            echo json_encode(['status' => 200, 'data' => $data]);
        } else {
            echo json_encode(['status' => 404, 'message' => 'Card not found']);
        }
    }

    public function insert_card() {
        global $mysqli;
        $data = json_decode(file_get_contents("php://input"), true); // Read JSON data from the body of the request
    
        // Validate input
        $name = isset($data['name']) ? $data['name'] : null;
        $type = isset($data['type']) ? $data['type'] : null;
        $rarity = isset($data['rarity']) ? $data['rarity'] : null;
        $description = isset($data['description']) ? $data['description'] : null;
        $price = isset($data['price']) ? $data['price'] : null;
    
        // Check if any field is empty
        if (!$name || !$type || !$rarity || !$description || !$price) {
            echo json_encode(['status' => 400, 'message' => 'All fields must be filled']);
            return;
        }
    
        // Insert data into the database
        $stmt = $mysqli->prepare("INSERT INTO cards (name, type, rarity, description, price) VALUES (?, ?, ?, ?, ?)");
        $stmt->bind_param("ssssd", $name, $type, $rarity, $description, $price);
        $stmt->execute();
        echo json_encode(['status' => 200, 'message' => 'Card added successfully']);
    }
    
    

    public function update_card($id) {
        global $mysqli;
    
        $data = json_decode(file_get_contents("php://input"), true);
    
        // Validasi input
        if (empty($data['name']) || empty($data['type']) || empty($data['rarity']) || empty($data['description']) || empty($data['price'])) {
            echo json_encode(['status' => 400, 'message' => 'All fields must be filled']);
            return;
        }
    
        $name = $data['name'];
        $type = $data['type'];
        $rarity = $data['rarity'];
        $description = $data['description'];
        $price = $data['price'];
    
        // Update card
        $query = "UPDATE cards SET name = ?, type = ?, rarity = ?, description = ?, price = ? WHERE id = ?";
        $stmt = $mysqli->prepare($query);
        $stmt->bind_param("sssssi", $name, $type, $rarity, $description, $price, $id);
        $stmt->execute();
    
        if ($stmt->affected_rows > 0) {
            echo json_encode(['status' => 200, 'message' => 'Card updated successfully']);
        } else {
            echo json_encode(['status' => 404, 'message' => 'Card not found or no changes made']);
        }
    }
    

    public function delete_card($id) {
        global $mysqli;
        $stmt = $mysqli->prepare("DELETE FROM cards WHERE id = ?");
        $stmt->bind_param("i", $id);
        $stmt->execute();
    
        if ($stmt->affected_rows > 0) {
            echo json_encode(['status' => 200, 'message' => 'Card deleted successfully']);
        } else {
            echo json_encode(['status' => 404, 'message' => 'Card not found']);
        }
    }
    
}
?>

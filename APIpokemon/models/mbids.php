<?php
require_once __DIR__ . "/../koneksi.php";

class MBids {
    public function get_bids() {
        global $mysqli;
        $query = "SELECT * FROM bids";
        $result = $mysqli->query($query);
        $data = [];
        while ($row = $result->fetch_assoc()) {
            $data[] = $row;
        }
        echo json_encode(['status' => 200, 'data' => $data]);
    }

    public function get_bid_by_id($id) {
        global $mysqli;
        $query = "SELECT * FROM bids WHERE id = $id";
        $result = $mysqli->query($query);
        $data = $result->fetch_assoc();
        echo json_encode(['status' => 200, 'data' => $data]);
    }

    public function insert_bid() {
        global $mysqli;
        $data = json_decode(file_get_contents("php://input"), true); // Membaca data JSON dari body request

        // Validasi input
        $card_name = isset($data['card_name']) ? $data['card_name'] : null;
        $bid_price = isset($data['bid_price']) ? $data['bid_price'] : null;
        $status = isset($data['status']) ? $data['status'] : 'open';

        if (!$card_name || !$bid_price) {
            echo json_encode(['status' => 400, 'message' => 'Invalid input: card_name and bid_price are required']);
            return;
        }

        // Insert data ke database
        $stmt = $mysqli->prepare("INSERT INTO bids (card_name, bid_price, status) VALUES (?, ?, ?)");
        $stmt->bind_param("sds", $card_name, $bid_price, $status);
        $stmt->execute();

        if ($stmt->affected_rows > 0) {
            echo json_encode(['status' => 200, 'message' => 'Bid added successfully']);
        } else {
            echo json_encode(['status' => 500, 'message' => 'Failed to add bid']);
        }
    }

    public function update_bid($id) {
        global $mysqli;
        $data = json_decode(file_get_contents("php://input"), true);

        if (isset($data['bid_price']) || isset($data['status'])) {
            $bid_price = $data['bid_price'] ?? null;
            $status = $data['status'] ?? null;

            $query = "UPDATE bids SET ";
            $params = [];
            $types = "";

            if ($bid_price !== null) {
                $query .= "bid_price = ?, ";
                $params[] = $bid_price;
                $types .= "d";
            }
            if ($status !== null) {
                $query .= "status = ?, ";
                $params[] = $status;
                $types .= "s";
            }
            $query = rtrim($query, ", ");
            $query .= " WHERE id = ?";
            $params[] = $id;
            $types .= "i";

            $stmt = $mysqli->prepare($query);
            $stmt->bind_param($types, ...$params);
            $stmt->execute();
            echo json_encode(['status' => 200, 'message' => 'Bid updated']);
        } else {
            echo json_encode(['status' => 400, 'message' => 'Invalid input']);
        }
    }

    public function delete_bid($id) {
        global $mysqli;
        
        // Prepare the delete statement
        $stmt = $mysqli->prepare("DELETE FROM bids WHERE id = ?");
        $stmt->bind_param("i", $id);
        
        if ($stmt->execute()) {
            echo json_encode(['status' => 200, 'message' => 'Bid deleted']);
        } else {
            echo json_encode(['status' => 500, 'message' => 'Failed to delete bid']);
        }
    }
    
}
?>

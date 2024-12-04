<?php
// Database connection settings
$host = "localhost";
$user = "root";
$pass = "";
$db   = "pokemon";

// Create a connection object
$mysqli = new mysqli($host, $user, $pass, $db);

// Check if the connection is successful
if ($mysqli->connect_error) {
    die("Connection failed: " . $mysqli->connect_error);
}
?>

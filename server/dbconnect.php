<?php
$servername = "localhost";
$username   = "crimsonw_271304_myshopadmin";
$password   = "W43Sqq&D^rf$";
$dbname     = "crimsonw_271304_myshopdb";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error){
    die("Connection failed: " . $conn->connect_error);
}
?>
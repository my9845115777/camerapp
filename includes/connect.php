<?php
session_start();
$servername = "localhost";
$server_user = "root";
$server_pass = "7777";
$dbname = "food_order_db";
$name = $_SESSION['name'];
$role = $_SESSION['role'];
$con = new mysqli($servername, $server_user, $server_pass, $dbname);
?>


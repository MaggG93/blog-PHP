<?php
// Datos de conexión a la base de datos
$host = 'localhost';
$dbname = 'blog_app';
$username = 'root';
$password = '';

try {
    // Conexión PDO
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);  // Establecer el manejo de errores
} catch (PDOException $e) {
    die("Error de conexión: " . $e->getMessage());
}

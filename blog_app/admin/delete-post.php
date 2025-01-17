<?php
session_start();
include 'db.php'; // Incluir la conexión a la base de datos

// Verificar si el usuario está autenticado
if (!isset($_SESSION['username'])) {
    header("Location: login.php");
    exit;
}

// Verificar si se recibe un ID por la URL
if (isset($_GET['id']) && is_numeric($_GET['id'])) {
    $postId = $_GET['id'];

    try {
        // Preparar la consulta para eliminar el post
        $query = "DELETE FROM posts WHERE id = :id";
        $stmt = $pdo->prepare($query);
        $stmt->bindParam(':id', $postId, PDO::PARAM_INT);

        // Ejecutar la consulta
        if ($stmt->execute()) {
            // Redirigir al panel con un mensaje de éxito
            header("Location: dashboard.php?message=Post eliminado con éxito");
            exit;
        } else {
            echo "Error al eliminar el post.";
        }
    } catch (PDOException $e) {
        die("Error en la eliminación: " . $e->getMessage());
    }
} else {
    echo "ID de post no válido.";
    exit;
}

<?php
session_start();
include 'db.php'; // Incluir el archivo de conexión

// Verificar si el usuario está autenticado
if (!isset($_SESSION['username'])) {
    header("Location: login.php");
    exit;
}

// Obtener el ID del post que se quiere editar
if (!isset($_GET['id']) || empty($_GET['id'])) {
    die("Error: ID de post no válido.");
}

$post_id = $_GET['id'];

// Obtener el post desde la base de datos
$query = "SELECT * FROM posts WHERE id = :id LIMIT 1";
try {
    $stmt = $pdo->prepare($query);
    $stmt->execute(['id' => $post_id]);
    $post = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$post) {
        die("Error: El post no existe.");
    }
} catch (PDOException $e) {
    die("Error al obtener el post: " . $e->getMessage());
}

// Verificar si el formulario ha sido enviado para actualizar el post
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $title = trim($_POST['title']);
    $content = trim($_POST['content']);
    $image_url = trim($_POST['image_url']);

    // Validar los datos
    if (empty($title) || empty($content)) {
        $error_message = "Todos los campos son obligatorios.";
    } else {
        // Actualizar el post en la base de datos
        $update_query = "UPDATE posts SET title = :title, content = :content, image_url = :image_url WHERE id = :id";
        try {
            $stmt = $pdo->prepare($update_query);
            $stmt->execute([
                'title' => $title,
                'content' => $content,
                'image_url' => $image_url,
                'id' => $post_id
            ]);
            $success_message = "Post actualizado con éxito.";
            // Redirigir a la lista de posts después de la actualización
            header("Location: dashboard.php");
            exit;
        } catch (PDOException $e) {
            $error_message = "Error al actualizar el post: " . $e->getMessage();
        }
    }
}
?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Post - El Pulpo y el Tintero</title>
    <link rel="stylesheet" href="./css/dashboard.css">
</head>

<body>
    <!-- Header -->
    <header>
        <div class="container">
            <a href="index.php" class="logo">
                <img src="./img/flat,750x,075,f-pad,750x1000,f8f8f8.jpg" alt="Mi Blog" class="logo-img">
            </a>
            <div class="header-title">
                <h1>Editar Post</h1>
            </div>
            <nav>
                <a href="index.php">Ver el blog</a>
                <a href="logout.php">Cerrar Sesión</a>
            </nav>
        </div>
    </header>

    <!-- Contenido -->
    <main class="admin-container">
        <section class="admin-content">
            <h2>Editar el Post</h2>

            <?php if (isset($error_message)): ?>
                <p class="error-message"><?php echo htmlspecialchars($error_message); ?></p>
            <?php elseif (isset($success_message)): ?>
                <p class="success-message"><?php echo htmlspecialchars($success_message); ?></p>
            <?php endif; ?>

            <form action="edit-post.php?id=<?php echo $post['id']; ?>" method="POST">
                <label for="title">Título:</label>
                <input type="text" name="title" id="title" value="<?php echo htmlspecialchars($post['title']); ?>" required>

                <label for="content">Contenido:</label>
                <textarea name="content" id="content" required><?php echo htmlspecialchars($post['content']); ?></textarea>

                <label for="image_url">URL de la Imagen:</label>
                <input type="text" name="image_url" id="image_url" value="<?php echo htmlspecialchars($post['image_url']); ?>" required>

                <button type="submit">Actualizar Post</button>
            </form>
        </section>
    </main>

    <!-- Footer -->
    <?php include("Footer.php"); ?>

</body>

</html>
<?php
session_start();
include 'db.php'; // Incluir archivo de conexión

// Verificar si el usuario está autenticado
if (!isset($_SESSION['username'])) {
    header("Location: login.php");
    exit;
}

// Procesar el formulario si se envía
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $title = $_POST['title'];
    $content = $_POST['content'];
    $image_url = $_POST['image_url'];
    $excerpt = $_POST['excerpt'];

    try {
        // Insertar el nuevo post en la base de datos
        $query = "INSERT INTO posts (title, content, image_url, excerpt, created_date) 
                  VALUES (:title, :content, :image_url, :excerpt, NOW())";
        $stmt = $pdo->prepare($query);
        $stmt->bindParam(':title', $title);
        $stmt->bindParam(':content', $content);
        $stmt->bindParam(':image_url', $image_url);
        $stmt->bindParam(':excerpt', $excerpt);
        $stmt->execute();

        // Redirigir al dashboard después de crear el post
        header("Location: dashboard.php?message=post_created");
        exit;
    } catch (PDOException $e) {
        $error = "Error al crear el post: " . $e->getMessage();
    }
}
?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Crear Post</title>
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
                <h1>Crear Post</h1>
            </div>
            <nav>
                <a href="index.php">Ver el blog</a>
                <a href="logout.php">Cerrar Sesión</a>
            </nav>
        </div>
    </header>

    <main class="admin-container">
        <div class="admin-content">
            <h2>Nuevo Post</h2>
            <?php if (isset($error)): ?>
                <p class="error-message"><?php echo htmlspecialchars($error); ?></p>
            <?php endif; ?>
            <form action="create-post.php" method="POST">
                <label for="title">Título</label>
                <input type="text" name="title" id="title" placeholder="Título..." required>

                <label for="content">Contenido</label>
                <textarea name="content" id="content" placeholder="Contenido..." required></textarea>

                <label for="image_url">URL de la Imagen</label>
                <input type="text" name="image_url" id="image_url" placeholder="http://..." required>

                <label for="excerpt">Extracto</label>
                <textarea name="excerpt" id="excerpt" placeholder="Escribe un resumen del post..." required></textarea>

                <button type="submit">Guardar Post</button>
            </form>
        </div>
    </main>

    <footer>
        <?php include("Footer.php"); ?>
    </footer>
</body>

</html>
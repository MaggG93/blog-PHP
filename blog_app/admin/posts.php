<?php
session_start();
include 'db.php';

// Verificamos si el usuario está logueado y si tiene la sesión activa.
$usuario_logueado = isset($_SESSION['username']);

// Verificamos si estamos llegando desde el panel de administración
$desde_dashboard = isset($_GET['desde_dashboard']) && $_GET['desde_dashboard'] == 'true';


// Verificamos si se ha recibido un parámetro 'id' en la URL
if (isset($_GET['id']) && is_numeric($_GET['id'])) {
    $post_id = $_GET['id']; // Recuperamos el ID del artículo desde la URL

    // Consultamos el post correspondiente a ese ID
    $query = "SELECT p.id, p.category_id, p.title, p.content, p.created_date, p.update_date, p.image_url, p.excerpt, c.name_cat AS category_name
              FROM posts p
              LEFT JOIN categories c ON p.category_id = c.id
              WHERE p.id = :post_id";
    $stmt = $pdo->prepare($query);
    $stmt->bindParam(':post_id', $post_id, PDO::PARAM_INT);
    $stmt->execute();

    // Verificamos si el artículo existe
    if ($stmt->rowCount() > 0) {
        // Si existe, obtenemos los datos del post
        $post = $stmt->fetch(PDO::FETCH_ASSOC);
    } else {
        // Si no existe, mostramos un mensaje de error
        echo "<p>Artículo no encontrado.</p>";
        exit;
    }
} else {
    // Si no se pasa un parámetro válido, mostramos un mensaje
    echo "<p>No se ha especificado un artículo.</p>";
    exit;
}
?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Publicaciones - El Pulpo y el Tintero</title>
    <link rel="stylesheet" href="./css/main.css">
</head>

<body>
    <!-- AQUÍ EMPIEZA EL HEADER -->
    <?php
    include("Header.php");
    ?>
    <!-- AQUÍ TERMINA EL HEADER -->

    <!-- Sección de fondo del header -->
    <section id="header-background" class="header-background"></section>

    <main class="container">
        <!-- AQUÍ EMPIEZA EL SECTION DE CONTENT -->
        <section class="content">
            <!-- Título del artículo -->
            <h2><?php echo htmlspecialchars($post['title']); ?></h2>
            <!-- Imagen del artículo (si existe) -->
            <?php if (!empty($post['image_url'])): ?>
                <img src="<?php echo htmlspecialchars($post['image_url']); ?>" alt="Imagen de <?php echo htmlspecialchars($post['title']); ?>"
                    class="post-image"
                    style="max-width: 100%; height: auto; display: block; margin: 0 auto;">
            <?php endif; ?>
            <!-- Contenido completo del artículo -->
            <div class="post-content">
                <p><?php echo nl2br(htmlspecialchars($post['content'])); ?></p>
            </div>
            </div>
        </section>
        <!-- AQUÍ TERMINA EL SECTION DE CONTENT -->

        <!-- AQUÍ EMPIEZA EL ASIDE DE SIDEBAR -->
        <?php
        include("Sidebar.php");
        ?>
        <!-- AQUÍ TERMINA EL ASIDE SIDEBAR -->
    </main>

    <!-- AQUÍ EMPIEZA EL FOOTER -->
    <?php
    include("Footer.php");
    ?>
    <!-- AQUÍ TERMINA EL FOOTER -->

</body>

</html>
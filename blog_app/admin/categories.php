<?php
session_start();
include 'db.php';

// Verificamos si el usuario está logueado y si tiene la sesión activa.
$usuario_logueado = isset($_SESSION['username']);

// Verificamos si estamos llegando desde el panel de administración
$desde_dashboard = isset($_GET['desde_dashboard']) && $_GET['desde_dashboard'] == 'true';

// Verifica si se ha pasado una categoría en la URL
if (isset($_GET['id']) && !empty($_GET['id'])) {
    $category_id = $_GET['id'];

    // Consulta para obtener los datos de la categoría seleccionada
    $stmt_cat = $pdo->prepare("SELECT name_cat, description FROM categories WHERE id = :id");
    $stmt_cat->execute(['id' => $category_id]);
    $category = $stmt_cat->fetch(PDO::FETCH_ASSOC);

    // Si no se encuentra la categoría, redirigir a la página principal
    if (!$category) {
        header("Location: index.php");
        exit;
    }

    // Consulta para obtener los posts de la categoría seleccionada
    $stmt_posts = $pdo->prepare("SELECT 
        posts.id, 
        posts.title, 
        posts.excerpt, 
        posts.image_url, 
        posts.created_date, 
        categories.name_cat AS category_name 
    FROM posts 
    LEFT JOIN categories ON posts.category_id = categories.id 
    WHERE category_id = :category_id 
    ORDER BY created_date DESC");
    $stmt_posts->execute(['category_id' => $category_id]);
    $posts = $stmt_posts->fetchAll(PDO::FETCH_ASSOC);
} else {
    // Si no se pasa categoría, redirigir o mostrar un mensaje
    header("Location: index.php");
    exit;
}
?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Categorías - El Pulpo y el Tintero <?php echo htmlspecialchars($category['name_cat']); ?></title>
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
            <h2><?php echo htmlspecialchars($category['name_cat']); ?></h2>
            <?php if (!empty($posts)): ?>
                <?php foreach ($posts as $post): ?>
                    <article>
                        <h3><?php echo htmlspecialchars($post['title']); ?></h3>
                        <p>
                            <?php echo htmlspecialchars($post['excerpt']); ?>
                            <a href="posts.php?id=<?php echo $post['id']; ?>">Leer más</a>
                        </p>
                        <?php if (!empty($post['image_url'])): ?>
                            <img src="<?php echo htmlspecialchars($post['image_url']); ?>" alt="<?php echo htmlspecialchars($post['title']); ?>" class="post-image">
                        <?php endif; ?>
                        <small>
                            Posted on <?php echo date('d/m/Y', strtotime($post['created_date'])); ?>
                            <?php if (!empty($post['category_name'])): ?>
                                | in <?php echo htmlspecialchars($post['category_name']); ?>
                            <?php endif; ?>
                        </small>
                    </article>
                <?php endforeach; ?>
            <?php else: ?>
                <p>No hay artículos en esta categoría.</p>
            <?php endif; ?>
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
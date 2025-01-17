<?php
session_start();
include 'db.php';

// Verificamos si el usuario está logueado y si tiene la sesión activa.
$usuario_logueado = isset($_SESSION['username']);

// Número de artículos por página
$articulos_por_pagina = 3;

// Página actual (por defecto es la primera)
$pagina_actual = isset($_GET['pagina']) ? (int) $_GET['pagina'] : 1;
if ($pagina_actual < 1) $pagina_actual = 1;

// Calcular el offset
$offset = ($pagina_actual - 1) * $articulos_por_pagina;

// Consulta para contar el número total de artículos
$total_stmt = $pdo->query("SELECT COUNT(*) FROM posts");
$total_articulos = $total_stmt->fetchColumn();

// Calcular el número total de páginas
$total_paginas = ceil($total_articulos / $articulos_por_pagina);

// Consulta para obtener los artículos con paginación
$stmt = $pdo->prepare("
    SELECT 
        posts.id, 
        posts.title, 
        posts.excerpt, 
        posts.image_url, 
        posts.created_date, 
        categories.name_cat AS category_name
    FROM posts
    LEFT JOIN categories ON posts.category_id = categories.id
    ORDER BY posts.created_date DESC
    LIMIT :limit OFFSET :offset
");
$stmt->bindValue(':limit', $articulos_por_pagina, PDO::PARAM_INT);
$stmt->bindValue(':offset', $offset, PDO::PARAM_INT);
$stmt->execute();
$recent_posts = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio - El Pulpo y el Tintero</title>
    <link rel="stylesheet" href="./css/main.css">
</head>

<body>
    <!-- AQUÍ EMPIEZA EL HEADER -->
    <?php include("Header.php"); ?>
    <!-- AQUÍ TERMINA EL HEADER -->

    <!-- Sección de fondo del header -->
    <section id="header-background" class="header-background"></section>

    <main class="container">
        <!-- AQUÍ EMPIEZA EL SECTION DE CONTENT -->
        <section class="content">
            <h2>Artículos Recientes</h2>
            <?php if (!empty($recent_posts)): ?>
                <?php foreach ($recent_posts as $post): ?>
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
                <p>No hay artículos recientes disponibles.</p>
            <?php endif; ?>

            <!-- PAGINADOR -->
            <section class="pagination">
                <?php if ($pagina_actual > 1): ?>
                    <a href="?pagina=<?php echo $pagina_actual - 1; ?>" class="prev">Anterior</a>
                <?php endif; ?>

                <?php for ($i = 1; $i <= $total_paginas; $i++): ?>
                    <a href="?pagina=<?php echo $i; ?>" class="<?php echo $i === $pagina_actual ? 'active' : ''; ?>">
                        <?php echo $i; ?>
                    </a>
                <?php endfor; ?>

                <?php if ($pagina_actual < $total_paginas): ?>
                    <a href="?pagina=<?php echo $pagina_actual + 1; ?>" class="next">Siguiente</a>
                <?php endif; ?>
            </section>
        </section>
        <!-- AQUÍ TERMINA EL SECTION DE CONTENT -->

        <!-- AQUÍ EMPIEZA EL ASIDE DE SIDEBAR -->
        <?php include("Sidebar.php"); ?>
        <!-- AQUÍ TERMINA EL ASIDE SIDEBAR -->
    </main>

    <!-- AQUÍ EMPIEZA EL FOOTER -->
    <?php include("Footer.php"); ?>
    <!-- AQUÍ TERMINA EL FOOTER -->
</body>

</html>
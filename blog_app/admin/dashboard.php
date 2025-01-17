<?php
session_start();
include 'db.php'; // Incluir el archivo de conexión

// Verificar si el usuario está autenticado
if (!isset($_SESSION['username'])) {
    header("Location: login.php");
    exit;
}

$username = $_SESSION['username']; // Recuperar el nombre de usuario desde la sesión

// Parámetros de paginación
$postsPorPagina = 5; // Número de posts por página
$paginaActual = isset($_GET['pagina']) ? (int)$_GET['pagina'] : 1; // Página actual, por defecto es la 1
$offset = ($paginaActual - 1) * $postsPorPagina; // Calcular el offset

// Contar el total de posts
$queryTotal = "SELECT COUNT(*) FROM posts";
$totalPosts = $pdo->query($queryTotal)->fetchColumn();
$totalPaginas = ceil($totalPosts / $postsPorPagina); // Calcular el número total de páginas

// Obtener los posts para la página actual
$query = "SELECT * FROM posts ORDER BY posts.title LIMIT $postsPorPagina OFFSET $offset";
try {
    // Preparar y ejecutar la consulta
    $stmt = $pdo->prepare($query);
    $stmt->execute();
    $posts = $stmt->fetchAll(PDO::FETCH_ASSOC); // Obtener todos los posts
} catch (PDOException $e) {
    die("Error al obtener los posts: " . $e->getMessage());
}
?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel de Administración - El Pulpo y el Tintero</title>
    <link rel="stylesheet" href="./css/dashboard.css">
</head>

<body>
    <!-- AQUÍ EMPIEZA EL HEADER -->
    <header>
        <div class="container">
            <a href="index.php" class="logo">
                <img src="./img/flat,750x,075,f-pad,750x1000,f8f8f8.jpg" alt="Mi Blog" class="logo-img">
            </a>
            <div class="header-title">
                <h1>Panel de Administrador</h1>
            </div>
            <nav>
                <a href="index.php">Ver el blog</a>
                <a href="logout.php">Cerrar Sesión</a>
            </nav>
        </div>
    </header>
    <!-- AQUÍ TERMINA EL HEADER -->

    <main class="admin-container">
        <!-- AQUÍ EMPIEZA EL SECTION DE CONTENT -->
        <section class="admin-content">
            <h2>Bienvenido al Panel</h2>
            <p>Desde aquí puedes gestionar todos los posts del blog.</p>
            <div class="admin-dashboard">
                <div class="dashboard-item">
                    <div class="dashboard-actions">
                        <a href="create-post.php" class="btn-create">Crear Post</a>
                    </div>
                    <?php if (count($posts) > 0): ?>
                        <table>
                            <tr>
                                <th>Título</th>
                                <th>Acciones</th>
                            </tr>
                            <?php foreach ($posts as $post): ?>
                                <tr>
                                    <td><?php echo htmlspecialchars($post['title']); ?></td>
                                    <td>
                                        <a href="edit-post.php?id=<?php echo $post['id']; ?>" class="btn-edit">Editar</a>
                                        <a href="delete-post.php?id=<?php echo $post['id']; ?>" class="btn-delete">Eliminar</a>
                                    </td>
                                </tr>
                            <?php endforeach; ?>
                        </table>
                    <?php else: ?>
                        <p>No hay posts disponibles.</p>
                    <?php endif; ?>
                    
                    <!-- Paginación -->
                    <div class="pagination">
                        <?php if ($paginaActual > 1): ?>
                            <a href="?pagina=<?php echo $paginaActual - 1; ?>" class="btn-paginacion">Anterior</a>
                        <?php endif; ?>

                        <?php for ($i = 1; $i <= $totalPaginas; $i++): ?>
                            <a href="?pagina=<?php echo $i; ?>" class="btn-paginacion <?php echo $i == $paginaActual ? 'active' : ''; ?>">
                                <?php echo $i; ?>
                            </a>
                        <?php endfor; ?>

                        <?php if ($paginaActual < $totalPaginas): ?>
                            <a href="?pagina=<?php echo $paginaActual + 1; ?>" class="btn-paginacion">Siguiente</a>
                        <?php endif; ?>
                    </div>
                </div>
            </div>
        </section>
        <!-- AQUÍ TERMINA EL SECTION DE ADMIN-CONTENT -->
    </main>

    <!-- AQUÍ EMPIEZA EL FOOTER -->
    <?php include("Footer.php"); ?>
    <!-- AQUÍ TERMINA EL FOOTER -->
</body>

</html>

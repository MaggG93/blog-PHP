<?php
session_start();
include 'db.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Recoger los datos del formulario
    $username = $_POST['username'];
    $password = $_POST['password'];

    // Validar si los campos no están vacíos
    if (empty($username) || empty($password)) {
        echo "Por favor, complete todos los campos.";
    } else {
        // Preparar consulta para buscar al usuario en la base de datos
        $query = "SELECT * FROM admin WHERE username = :username";
        $stmt = $pdo->prepare($query); // Cambié $conn por $pdo
        $stmt->bindParam(':username', $username, PDO::PARAM_STR);
        $stmt->execute();

        // Si el usuario existe, verificar la contraseña
        if ($stmt->rowCount() > 0) {
            $user = $stmt->fetch(PDO::FETCH_ASSOC);

            // Compara la contraseña
            if ($password === $user['password']) {
                // Regenerar ID de la sesión
                session_regenerate_id(true);

                // Crear sesión para el usuario
                $_SESSION['user_id'] = $user['id'];
                $_SESSION['username'] = $user['username'];
                header("Location: dashboard.php"); // Redirigir al dashboard
                exit;
            } else {
                echo "<script>alert('Contraseña incorrecta.');</script>";
            }
        } else {
            echo "<script>alert('Usuario no encontrado.');</script>";
        }
    }
}
?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar Sesión - El Pulpo y el Tintero</title>
    <link rel="stylesheet" href="./css/login.css">
</head>

<body class="login-page">
    <!-- AQUÍ EMPIEZA EL HEADER -->
    <header>
        <div class="container">
            <a href="index.php" class="logo">
                <img src="./img/flat,750x,075,f-pad,750x1000,f8f8f8.jpg" alt="Mi Blog" class="logo-img">
            </a>
            <div class="header-title">
                <h1>El Pulpo y el Tintero</h1>
            </div>
            <nav>
                <a href="index.php">Inicio</a>
            </nav>
        </div>
    </header>
    <!-- AQUÍ TERMINA EL HEADER -->

    <div class="login-container">
        <h1>Iniciar Sesión</h1>
        <form method="POST" action="">
            <label for="username">Usuario:</label>
            <input type="text" id="username" name="username" required>
            <label for="password">Contraseña:</label>
            <input type="password" id="password" name="password" required>
            <button type="submit" class="btn">Entrar</button>
        </form>
    </div>

</body>

</html>
<header>
    <div class="container">
        <a href="index.php" class="logo">
            <img src="./img/flat,750x,075,f-pad,750x1000,f8f8f8.jpg" alt="Mi Blog" class="logo-img">
        </a>
        <div class="header-title">
            <h1>El Pulpo y el Tintero</h1>
        </div>
        <nav>
            <?php if ($usuario_logueado): ?>
                <!-- Si el usuario está logueado, mostrar opción de regresar al panel -->
                <a href="dashboard.php">Ir al Panel de Administración</a>
            <?php else: ?>
                <!-- Si no está logueado, mostrar opción de iniciar sesión -->
                <a href="login.php">Iniciar Sesión</a>
            <?php endif; ?>
        </nav>
    </div>
</header>
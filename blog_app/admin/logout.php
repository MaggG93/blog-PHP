<?php
session_start();
session_unset();
session_destroy();

header("Location: index.php"); // Redirige al login después de cerrar sesión
exit;

<aside class="sidebar">
    <h3>Categorías</h3>
    <ul class="categorias">
        <?php
        $stmt = $pdo->query("SELECT id, name_cat FROM categories order by name_cat DESC");
        $categories = $stmt->fetchAll(PDO::FETCH_ASSOC);
        foreach ($categories as $cat):
        ?>
            <li><a href="categories.php?id=<?php echo $cat['id']; ?>"><?php echo htmlspecialchars($cat['name_cat']); ?></a></li>
        <?php endforeach; ?>
    </ul>
</aside>
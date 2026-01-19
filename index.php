<?php
$index = isset($_SERVER['INDEX']) ? (int)$_SERVER['INDEX'] : 1;
?>
<!DOCTYPE html>
<html>
<head>
    <title>Home</title>
</head>
<body>
    <h1>Welcome</h1>
    <ul>
        <li><a href="/">Index Page</a><?php if ($index == 0) { echo ' (disabled)'; } ?></li>
        <li><?php if ($index == 1) { ?><a href="/phpmyadmin">PhpMyAdmin</a><?php } else { echo 'PhpMyAdmin'; } ?></li>
        <li><?php if ($index == 1) { ?><a href="/wordpress">WordPress</a><?php } else { echo 'WordPress'; } ?></li>
    </ul>
</body>
</html>
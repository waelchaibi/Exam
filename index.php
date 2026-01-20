<?php
$index = isset($_SERVER['INDEX']) ? (int)$_SERVER['INDEX'] : 1;
// Extract hostname without port for HTTPS link
$hostname = explode(':', $_SERVER['HTTP_HOST'])[0];
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
        <li><?php if ($index == 1) { ?><a href="/phpmyadmin">PhpMyAdmin</a><?php } else { ?><a href="#">PhpMyAdmin</a><?php } ?></li>
        <li><?php if ($index == 1) { ?><a href="/wordpress">WordPress</a><?php } else { ?><a href="#">WordPress</a><?php } ?></li>
        <li><?php if ($index == 1) { ?><a href="https://<?php echo $hostname; ?>">Nginx (HTTPS)</a><?php } else { ?><a href="#">Nginx (HTTPS)</a><?php } ?></li>
    </ul>
</body>
</html>
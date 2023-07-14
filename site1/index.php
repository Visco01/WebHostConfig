<!DOCTYPE html>
<html>
<head>
    <title>Site 1</title>
</head>
<body>
    <h1>Site 1 HTTPS</h1>
    <h2>Login</h2>
    <form method="POST" action="login.php">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required><br><br>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br><br>
        <input type="submit" value="Login">
    </form>

    <?php
    if ($_SERVER["REQUEST_METHOD"] === "POST") {
        $username = $_POST["username"];
        $password = $_POST["password"];

        // Perform validation and authentication logic here
        if ($username === "your_username" && $password === "your_password") {
            // Successful login
            echo "Login successful!";
        } else {
            // Invalid credentials
            echo "Invalid username or password.";
        }
    }
    ?>
</body>
</html>

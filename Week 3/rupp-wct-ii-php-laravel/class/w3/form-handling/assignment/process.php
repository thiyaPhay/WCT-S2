<?php
// Initialize variables to store form data and errors
$name = $email = $password = "";
$nameErr = $emailErr = $passwordErr = "";
$successMessage = "";

// Check if form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Validate Name
    if (empty($_POST["name"])) {
        $nameErr = "Name is required";
    } else {
        $name = cleanInput($_POST["name"]);
    }
    
    // Validate Email
    if (empty($_POST["email"])) {
        $emailErr = "Email is required";
    } elseif (!filter_var($_POST["email"], FILTER_VALIDATE_EMAIL)) {
        $emailErr = "Invalid email format";
    } else {
        $email = cleanInput($_POST["email"]);
    }
    
    // Validate Password
    if (empty($_POST["password"])) {
        $passwordErr = "Password is required";
    } else {
        $password = cleanInput($_POST["password"]);
    }
    
    // Check if there are no errors
    if (empty($nameErr) && empty($emailErr) && empty($passwordErr)) {
        $successMessage = "Form submitted successfully!<br>
                         Name: $name<br>
                         Email: $email<br>
                         Password: [hidden for security]";
    }
}

// Function to clean input data
function cleanInput($data) {
    $data = trim($data);
    $data = stripslashes($data);
    $data = htmlspecialchars($data);
    return $data;
}
?>
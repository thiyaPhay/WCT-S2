<?php
include '../includes/header.php';

$id = $_GET['id'] ?? '';
if (empty($id)) {
    echo "<div class='container mx-auto p-4'><p class='text-red-500'>Invalid student ID.</p></div>";
    include '../includes/footer.php';
    exit;
}

// Load students data from students.json
$studentsFile = '../students.json';
$studentsData = [];
if (file_exists($studentsFile)) {
    $json = file_get_contents($studentsFile);
    $studentsData = json_decode($json, true) ?? [];
}

// Find the student by ID
$student = null;
foreach ($studentsData as $s) {
    if ($s['id'] === $id) {
        $student = $s;
        break;
    }
}

if (!$student) {
    echo "<div class='container mx-auto p-4'><p class='text-red-500'>Student not found.</p></div>";
    include '../includes/footer.php';
    exit;
}
?>

<div class="container mx-auto p-4">
    <h2 class="text-3xl font-extrabold text-gray-900 mb-6">Edit Student</h2>
    
    <form action="../actions/edit_student.php" method="POST" class="bg-white p-6 rounded-lg shadow-md mb-8">
        <input type="hidden" name="id" value="<?php echo htmlspecialchars($student['id']); ?>">
        <div class="mb-4">
            <label for="name" class="block text-lg font-medium text-gray-700">Name</label>
            <input type="text" name="name" id="name" value="<?php echo htmlspecialchars($student['name']); ?>" required class="mt-2 block w-full border border-gray-300 rounded-md shadow-sm focus:ring focus:ring-blue-500">
        </div>
        <div class="mb-4">
            <label for="age" class="block text-lg font-medium text-gray-700">Age</label>
            <input type="number" name="age" id="age" value="<?php echo htmlspecialchars($student['age']); ?>" required class="mt-2 block w-full border border-gray-300 rounded-md shadow-sm focus:ring focus:ring-blue-500">
        </div>
        <div class="mb-4">
            <label for="grade" class="block text-lg font-medium text-gray-700">Grade</label>
            <input type="text" name="grade" id="grade" value="<?php echo htmlspecialchars($student['grade']); ?>" required class="mt-2 block w-full border border-gray-300 rounded-md shadow-sm focus:ring focus:ring-blue-500">
        </div>
        <button type="submit" class="w-full bg-blue-600 text-white text-lg py-2 rounded-lg hover:bg-blue-700">Update Student</button>
    </form>
    
    <a href="http://localhost:8000/" class="inline-block bg-gray-500 text-white px-4 py-2 rounded hover:bg-gray-600">Back</a>
</div>

<?php include '../includes/footer.php'; ?>
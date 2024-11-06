<?php 
include('../includes/config.php'); 

// Enable error reporting for debugging
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Start the session only if it hasn't been started
if (session_status() == PHP_SESSION_NONE) {             
    session_start();
}

// Ensure the user is logged in as a student
if (!isset($_SESSION['student_id'])) {
    echo "<div class='alert alert-danger'>You must be logged in to view this page.</div>";
    exit();
}

// Get student information
$student_id = $_SESSION['student_id'];

// Fetch student class
$student_query = mysqli_query($db_conn, "SELECT class_id FROM accounts WHERE id = '$student_id' AND type = 'student'");
if (!$student_query) {
    echo "<div class='alert alert-danger'>Error fetching student information: " . mysqli_error($db_conn) . "</div>";
    exit();
}

$student_info = mysqli_fetch_assoc($student_query);
$class_id = $student_info['class_id'];

// Fetch available courses for the student's class
$courses_query = mysqli_query($db_conn, "SELECT id, name FROM courses WHERE class_id = '$class_id'");
if (!$courses_query) {
    echo "<div class='alert alert-danger'>Error fetching courses: " . mysqli_error($db_conn) . "</div>";
    exit();
}

// Handle course selection from the URL parameter
$selected_course_id = isset($_GET['course_id']) ? (int)$_GET['course_id'] : null;

// Fetch posts for the selected course and class, including file attachments
$posts_sql = "
    SELECT p.*, m.meta_value AS file_attachment 
    FROM posts p
    LEFT JOIN metadata m ON p.id = m.item_id AND m.meta_key = 'file_attachment'
    WHERE p.class_id = '$class_id' " . 
    ($selected_course_id ? " AND p.course_id = '$selected_course_id'" : "") . "
    AND p.type = 'study-material'
    ORDER BY p.publish_date DESC
";
$posts_query = mysqli_query($db_conn, $posts_sql);
if (!$posts_query) {
    echo "<div class='alert alert-danger'>Error fetching posts: " . mysqli_error($db_conn) . "</div>";
    exit();
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Study Materials</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1 class="mb-4">Study Materials</h1>

        <!-- Navigation Bar for Course Selection -->
        <nav class="nav nav-pills mb-4">
            <a class="nav-link <?php echo is_null($selected_course_id) ? 'active' : ''; ?>" href="?">All</a>
            <?php while ($course = mysqli_fetch_assoc($courses_query)): ?>
                <a class="nav-link <?php echo ($selected_course_id == $course['id']) ? 'active' : ''; ?>" 
                   href="?course_id=<?php echo $course['id']; ?>">
                    <?php echo htmlspecialchars($course['name']); ?>
                </a>
            <?php endwhile; ?>
        </nav>

        <?php if (mysqli_num_rows($posts_query) > 0): ?>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Title</th>
                        <th>Posted On</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <?php while ($post = mysqli_fetch_assoc($posts_query)): ?>
                        <tr>
                            <td><?php echo htmlspecialchars($post['title']); ?></td>
                            <td><?php echo $post['publish_date']; ?></td>
                            <td>
                                <?php if (!empty($post['file_attachment'])): ?>
                                    <a href="../dist/uploads/<?php echo htmlspecialchars($post['file_attachment']); ?>" class="btn btn-success btn-sm" download>Download File</a>
                                <?php endif; ?>
                            </td>
                        </tr>
                    <?php endwhile; ?>
                </tbody>
            </table>
        <?php else: ?>
            <div class="alert alert-warning">No study materials available for the selected course.</div>
        <?php endif; ?>
    </div>
</body>
</html>

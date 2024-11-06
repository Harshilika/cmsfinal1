<?php
include('../includes/config.php'); 
include('header.php'); 
include('sidebar.php'); 

// Start session if not started yet
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

// Ensure the user is logged in as a teacher
if (!isset($_SESSION['user_id'])) {
    die("You must be logged in as a teacher to access this page.");
}

$teacher_id = $_SESSION['user_id'];

// Fetch available classes for the teacher
$class_query = "
    SELECT DISTINCT cl.id, cl.title 
    FROM Classes cl 
    INNER JOIN Teacher_Classes tc ON cl.id = tc.class_id 
    WHERE tc.teacher_id = '$teacher_id'";
$class_result = mysqli_query($db_conn, $class_query);

// Get selected class and course IDs from GET parameters
$class_id = $_GET['class_id'] ?? null;
$course_id = $_GET['course_id'] ?? null;
$students = [];

// Fetch available courses linked to the selected class
$course_options = [];
if ($class_id) {
    $course_query = "
        SELECT c.id, c.name 
        FROM courses c 
        WHERE c.class_id = '$class_id' AND c.teacher_id = '$teacher_id'";
    $course_result = mysqli_query($db_conn, $course_query);

    while ($course_row = mysqli_fetch_assoc($course_result)) {
        $course_options[] = $course_row;
    }
}

// If both class and course are selected, fetch students in that class
if ($class_id && $course_id) {
    $query = "
        SELECT s.*, p.parent_name, p.parent_email, p.parent_phone 
        FROM accounts s 
        LEFT JOIN parents p ON s.id = p.child_id 
        WHERE s.class_id = '$class_id' AND s.type = 'student'";
    $result = mysqli_query($db_conn, $query);
    
    while ($row = mysqli_fetch_assoc($result)) {
        $students[] = $row;
    }
}

// Handle form submission for messaging parents
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $student_id = $_POST['student_id'] ?? null;
    $message = $_POST['message'] ?? null;
    $course_id = $_POST['course_id'] ?? null;

    if ($student_id && $message && $course_id) {
        $parent_query = "SELECT id FROM parents WHERE child_id = '$student_id'";
        $parent_result = mysqli_query($db_conn, $parent_query);
        $parent_row = mysqli_fetch_assoc($parent_result);
        $parent_id = $parent_row['id'] ?? null;

        if ($parent_id) {
            $insert_query = "
                INSERT INTO Communication (teacher_id, student_id, parent_id, course_id, message) 
                VALUES ('$teacher_id', '$student_id', '$parent_id', '$course_id', '$message')
            ";
            if (mysqli_query($db_conn, $insert_query)) {
                echo "<div class='alert alert-success'>Message sent successfully.</div>";
            } else {
                echo "<div class='alert alert-danger'>Error: " . mysqli_error($db_conn) . "</div>";
            }
        } else {
            echo "<div class='alert alert-warning'>Parent not found for the selected student.</div>";
        }
    } else {
        echo "<div class='alert alert-warning'>Please fill in all fields.</div>";
    }
}
?>

<style>
    /* Custom styling */
    /* (Add custom styles here as needed) */
</style>

<div class="content-header">
    <h1 class="m-0 text-dark">Communicate with Parents</h1>
</div>

<section class="content">
    <div class="container-fluid">
        <div class="card">
            <div class="card-header">
                <h3 class="card-title">Select Class and Course</h3>
            </div>
            <div class="card-body">
                <!-- Class and Course Selection Form -->
                <form method="GET" action="communications.php">
                    <div class="form-group">
                        <label for="class_id">Select Class:</label>
                        <select name="class_id" class="form-control" onchange="this.form.submit()" required>
                            <option value="">-- Select Class --</option>
                            <?php while ($class = mysqli_fetch_assoc($class_result)): ?>
                                <option value="<?= $class['id'] ?>" <?= ($class['id'] == $class_id) ? 'selected' : '' ?>>
                                    <?= htmlspecialchars($class['title']) ?>
                                </option>
                            <?php endwhile; ?>
                        </select>
                    </div>

                    <?php if ($class_id): ?>
                    <div class="form-group">
                        <label for="course_id">Select Course:</label>
                        <select name="course_id" class="form-control" onchange="this.form.submit()" required>
                            <option value="">-- Select Course --</option>
                            <?php foreach ($course_options as $course): ?>
                                <option value="<?= $course['id'] ?>" <?= ($course['id'] == $course_id) ? 'selected' : '' ?>>
                                    <?= htmlspecialchars($course['name']) ?>
                                </option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <?php endif; ?>
                </form>

                <!-- Display students in the selected class and course -->
                <?php if ($class_id && $course_id): ?>
                    <h2>Students in Class</h2>
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>Student ID</th>
                                <th>Name</th>
                                <th>Parent Name</th>
                                <th>Parent Email</th>
                                <th>Parent Phone</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($students as $student): ?>
                                <tr>
                                    <td><?= htmlspecialchars($student['id']) ?></td>
                                    <td><?= htmlspecialchars($student['name']) ?></td>
                                    <td><?= htmlspecialchars($student['parent_name']) ?></td>
                                    <td><?= htmlspecialchars($student['parent_email']) ?></td>
                                    <td><?= htmlspecialchars($student['parent_phone']) ?></td>
                                    <td>
                                        <button class="btn btn-primary" data-toggle="modal" data-target="#messageModal" data-student-id="<?= $student['id'] ?>" data-student-name="<?= htmlspecialchars($student['name']) ?>">Send Message</button>
                                    </td>
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                <?php endif; ?>
            </div>
        </div>
    </div>
</section>

<!-- Modal for Sending Message -->
<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="messageModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="messageModalLabel">Send Message</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form method="POST" action="communications.php">
                    <input type="hidden" name="student_id" id="student_id" value=""/>
                    <input type="hidden" name="course_id" value="<?= $course_id ?>"/>
                    <div class="form-group">
                        <label for="message">Message:</label>
                        <textarea name="message" class="form-control" required></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary">Send Message</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    // Populate modal with student data when the Send Message button is clicked
    $('#messageModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var studentId = button.data('student-id');
        var studentName = button.data('student-name');
        
        var modal = $(this);
        modal.find('.modal-title').text('Send Message to ' + studentName);
        modal.find('#student_id').val(studentId);
    });
</script>

<?php include('footer.php'); ?>

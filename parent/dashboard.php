<?php
// Include database connection
include('../includes/config.php');

// Assume $student_id is the student's ID (Replace this with the actual student ID dynamically)
$student_id = 1; // Replace with dynamic value if necessary

// Fetch exam results data
$sql_exam_results = "
    SELECT r.course_id, r.exam_type, r.score
    FROM results r
    WHERE r.student_id = $student_id
";
$exam_results = mysqli_query($db_conn, $sql_exam_results);

// Arrays to store course names and scores
$courses = [];
$scores = [];

while ($row = mysqli_fetch_assoc($exam_results)) {
    // Check if we have data to add
    $courses[] = $row['exam_type'] . ' (' . $row['course_id'] . ')'; // Combining course and exam type
    $scores[] = (float)$row['score']; // Store score as float
}

// Fetch assignment submission data
$sql_assignments = "
    SELECT sa.assignment_id, sa.answer
    FROM studentanswers sa
    WHERE sa.student_id = $student_id
";
$assignment_results = mysqli_query($conn, $sql_assignments);

// Arrays to store assignment names and submission status
$assignments = [];
$submitted_count = 0;
$total_assignments = mysqli_num_rows($assignment_results);

while ($row = mysqli_fetch_assoc($assignment_results)) {
    $assignments[] = 'Assignment #' . $row['assignment_id'];
    if (!empty($row['answer'])) {
        $submitted_count++; // Count submitted assignments
    }
}

$submission_percentage = ($total_assignments > 0) ? ($submitted_count / $total_assignments) * 100 : 0;
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Performance Dashboard</title>
    <!-- Include Chart.js library -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <h2>Student Performance Overview</h2>

    <!-- Bar chart for exam scores -->
    <canvas id="examScoresChart" width="400" height="200"></canvas>
    <h3>Exam Scores</h3>

    <!-- Pie chart for assignment submission status -->
    <canvas id="assignmentSubmissionChart" width="400" height="200"></canvas>
    <h3>Assignment Submission Status</h3>

    <script>
        // Ensure that the data arrays are populated before rendering the charts
        var courses = <?php echo json_encode($courses); ?>;
        var scores = <?php echo json_encode($scores); ?>;
        var submittedCount = <?php echo $submitted_count; ?>;
        var totalAssignments = <?php echo $total_assignments; ?>;

        // Only render the Exam Scores chart if there are scores to display
        if (courses.length > 0 && scores.length > 0) {
            var ctx1 = document.getElementById('examScoresChart').getContext('2d');
            var examScoresChart = new Chart(ctx1, {
                type: 'bar', // Bar chart
                data: {
                    labels: courses, // X-axis: Exam types and course names
                    datasets: [{
                        label: 'Exam Scores',
                        data: scores, // Y-axis: Exam scores
                        backgroundColor: 'rgba(75, 192, 192, 0.2)', // Bar color
                        borderColor: 'rgba(75, 192, 192, 1)', // Border color
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        } else {
            document.querySelector('h3').insertAdjacentHTML('afterend', '<p>No exam results available.</p>');
        }

        // Only render the Assignment Submission Status chart if there is assignment data
        if (totalAssignments > 0) {
            var ctx2 = document.getElementById('assignmentSubmissionChart').getContext('2d');
            var assignmentSubmissionChart = new Chart(ctx2, {
                type: 'pie', // Pie chart
                data: {
                    labels: ['Submitted', 'Pending'],
                    datasets: [{
                        label: 'Assignment Submission Status',
                        data: [submittedCount, totalAssignments - submittedCount], // Submitted and Pending assignments
                        backgroundColor: ['#28a745', '#dc3545'], // Green for submitted, red for pending
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true
                }
            });
        } else {
            document.querySelector('h3').insertAdjacentHTML('afterend', '<p>No assignments found for this student.</p>');
        }
    </script>
</body>
</html>

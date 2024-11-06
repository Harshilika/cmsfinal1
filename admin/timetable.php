<?php
include('../includes/config.php');
include('header.php');
include('sidebar.php');

// Content Header (Page header)
?>
<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1 class="m-0 text-dark">Manage Time Table</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="#">Admin</a></li>
                    <li class="breadcrumb-item active">Time Table</li>
                </ol>
            </div>
        </div>
    </div>
</div>

<!-- Main content -->
<section class="content">
    <div class="container-fluid">
        <?php
        // Fetch classes for the dropdown
        $class_query = mysqli_query($db_conn, "SELECT * FROM classes");

        // Define the time slots and days
        $time_slots = [
            '09:00 AM - 09:45 AM',
            '09:45 AM - 10:30 AM',
            '10:30 AM - 11:15 AM',
            '11:15 AM - 12:00 PM',
            '12:00 PM - 12:45 PM',
            '01:00 PM - 01:45 PM',
            '01:45 PM - 02:30 PM',
            '02:30 PM - 03:15 PM',
            '03:15 PM - 04:00 PM'
        ];
        $days = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday'];

        // Handle form submission for updating timetable
        if (isset($_POST['update_timetable'])) {
            $class_id = $_POST['class_id'];

            // Debug: Check the selected class
            echo "Class ID: " . $class_id . "<br>";

            // Loop through time slots and days to update the timetable
            foreach ($time_slots as $time_slot) {
                foreach ($days as $day) {
                    // Get the course name entered in the form
                    $course_name = $_POST["course_id_{$day}_{$time_slot}"] ?? '';

                    // Debug: Check the course name
                    echo "Course for {$day} at {$time_slot}: " . $course_name . "<br>";

                    if (!empty($course_name)) {
                        // Fetch the course_id based on the course name
                        $course_query = mysqli_query($db_conn, "SELECT id FROM courses WHERE name = '$course_name' LIMIT 1");

                        // Check if the course exists
                        if (mysqli_num_rows($course_query) > 0) {
                            $course_row = mysqli_fetch_assoc($course_query);
                            $course_id = $course_row['id'];
                        } else {
                            // Handle if course doesn't exist
                            $course_id = '';
                            echo "Course not found for: " . $course_name . "<br>";
                        }
                    } else {
                        $course_id = ''; // If no course entered, set to empty
                    }

                    // Check if the timetable entry exists for the current day and time slot
                    $check_query = mysqli_query($db_conn, "
                        SELECT id FROM timetable 
                        WHERE class_id = '$class_id' 
                        AND day = '$day' 
                        AND time_slot = '$time_slot'
                    ");

                    if (mysqli_num_rows($check_query) > 0) {
                        // Update existing entry
                        if ($course_id) {
                            $update_query = "
                                UPDATE timetable 
                                SET course_id = '$course_id' 
                                WHERE class_id = '$class_id' 
                                AND day = '$day' 
                                AND time_slot = '$time_slot'
                            ";

                            if (mysqli_query($db_conn, $update_query)) {
                                // Debug: Success
                                echo "Timetable entry for {$day} at {$time_slot} updated.<br>";
                            } else {
                                // Debug: Error
                                echo "Error updating timetable for {$day} at {$time_slot}: " . mysqli_error($db_conn) . "<br>";
                            }
                        }
                    } else {
                        // Insert a new timetable entry
                        if ($course_id) {
                            $insert_query = "
                                INSERT INTO timetable (class_id, day, time_slot, course_id) 
                                VALUES ('$class_id', '$day', '$time_slot', '$course_id')
                            ";

                            if (mysqli_query($db_conn, $insert_query)) {
                                // Debug: Success
                                echo "Timetable entry for {$day} at {$time_slot} inserted.<br>";
                            } else {
                                // Debug: Error
                                echo "Error inserting timetable for {$day} at {$time_slot}: " . mysqli_error($db_conn) . "<br>";
                            }
                        }
                    }
                }
            }

            echo '<div class="alert alert-success">Timetable updated successfully!</div>';
        }
        ?>

        <!-- Class Selection -->
        <div class="card">
            <div class="card-body">
                <h3>Select Class to View Timetable</h3>
                <form method="post">
                    <div class="form-group">
                        <label for="class_id">Select Class</label>
                        <select name="class_id" id="class_id" class="form-control" required>
                            <option value="">-Select Class-</option>
                            <?php while ($class = mysqli_fetch_assoc($class_query)): ?>
                                <option value="<?= $class['id'] ?>"><?= htmlspecialchars($class['title']) ?></option>
                            <?php endwhile; ?>
                        </select>
                    </div>
                    <input type="submit" value="View Timetable" name="view_timetable" class="btn btn-primary">
                </form>
            </div>
        </div>

        <!-- Display Timetable for Selected Class -->
        <?php if (isset($_POST['view_timetable'])): ?>
            <?php
            // Fetch class title based on selected class_id
            $class_id = $_POST['class_id'];
            $class_query = mysqli_query($db_conn, "SELECT title FROM classes WHERE id = '$class_id'");
            $class_title = mysqli_fetch_assoc($class_query)['title'];
            ?>
            
            <div class="card">
                <div class="card-body">
                    <h3>Timetable for Class: <?= htmlspecialchars($class_title) ?></h3>

                    <form method="post">
                        <input type="hidden" name="class_id" value="<?= htmlspecialchars($class_id) ?>">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Timing</th>
                                    <th>Monday</th>
                                    <th>Tuesday</th>
                                    <th>Wednesday</th>
                                    <th>Thursday</th>
                                    <th>Friday</th>
                                    <th>Saturday</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php
                                // Loop through time slots
                                foreach ($time_slots as $time_slot):
                                    ?>
                                    <tr>
                                        <td><?= $time_slot ?></td>
                                        <?php
                                        // Loop through days of the week
                                        foreach ($days as $day):
                                            // Fetch the existing timetable data for the current day and time slot
                                            $query = mysqli_query($db_conn, "
    SELECT timetable.id, courses.name 
    FROM timetable 
    JOIN courses ON timetable.course_id = courses.id 
    WHERE timetable.class_id = '$class_id' AND timetable.day = '$day' AND timetable.time_slot = '$time_slot'
");

                                            
                                            if (mysqli_num_rows($query) > 0) {
                                                $row = mysqli_fetch_assoc($query);
                                                ?>
                                                <td>
                                                    <input type="text" name="course_id_<?= $day ?>_<?= $time_slot ?>" value="<?= $row['name'] ?>" class="form-control">
                                                </td>
                                                <?php
                                            } else {
                                                ?>
                                                <td>
                                                    <input type="text" name="course_id_<?= $day ?>_<?= $time_slot ?>" class="form-control">
                                                </td>
                                                <?php
                                            }
                                        endforeach;
                                        ?>
                                    </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                        <input type="submit" value="Update Timetable" name="update_timetable" class="btn btn-primary">
                    </form>
                </div>
            </div>
        <?php endif; ?>
    </div>
</section>

<?php include('footer.php'); ?>

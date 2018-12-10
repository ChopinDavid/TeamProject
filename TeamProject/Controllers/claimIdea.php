<?php

// Create connection
$con=mysqli_connect("localhost","david","uGNm42DgkNY7vN3O","teamproject");

// Check connection
if (mysqli_connect_errno())
{
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

$id = strval($_GET['id']);

$sql = "UPDATE `Ideas` SET `claimed`=1
    WHERE `id`='$id'";

if ($con->query($sql) === TRUE) {
    echo "Idea claimed";
} else {
    echo "Error: " . $sql . "<br>" . $con->error;
}

// Close connections
mysqli_close($con);
?>

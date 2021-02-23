
<!DOCTYPE html>

<html>

	<head>	
        <title> Delete Customer </title>
    	</head>

<br><br>

<?php

$servername = "10.95.6.115";
$username = "yonael";
$password = "passyonael";
$dbname = "retail";


$conn = mysqli_connect($servername, $username, $password, $dbname);

if (!$conn) {
  die("Connection failed: " . mysqli_connect_error());
}
echo "Connected successfully";


 $id = $_POST["Account_ID"];
 echo "Record with ID",$id;
	$sqlQry = "delete from Customer where Account_ID='$id' ";
	$res = $conn->query($sqlQry);
	if($res)
	{
		echo "<p>Record with ID =", $id, "is deleted successfully.</p>";
	}
	else 
	{
		echo "<p>Error in deleting the record exiting</p>";
		exit();
		
		  $result1=mysqli_query($res,$sqlQry);
	echo "<br>MySQL error number ", mysqli_errno($result1);
	echo "<br>MySQL SQLSTATE ", mysqli_sqlstate($result1);
	echo "<br>MySQL error ", mysqli_error($result1); 
	}
	

?>

Welcome to the DELETE CUSTOMERS page for the Bank LSQL Database.
<br><br>

<form method="post" action="<?php echo $_SERVER['PHP_SELF']; ?>">


<br><br>

Account ID: <input type="text" name="Account_ID" value="<?php echo $id; ?>">


<br><br>

<input type="submit" name="button"  id="id_input" value="Submit Request" onclick = "formValidation()"><br>


</form>

<script>

function formValidation() {
  let inputBox = document.querySelector("#id_input")
  let input = inputBox.value
 
  if (!input || isNaN(input)) {
 alert("Input must be a valid number")
  } else {
      alert("Valid ID")  
}
     
}
    
</script>
</html> 
























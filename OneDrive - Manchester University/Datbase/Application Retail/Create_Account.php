<!DOCTYPE html>
<html>
 
<head>
<title>Create Account</title>
<h1> Create Account </h1>
</head>
 
<p> Please enter Account ID or Email to create </p><br>


<?php
 
if(!isset($_POST["button"]))
{
$fname="";	
$phone ="";
$Email="";
$street="";
$city="";
$zip= "";
$city="";
$Email="";
$lname="";
}

if(isset($_POST["button"])){
                if ($_SERVER["REQUEST_METHOD"] == "POST") {
                                $fname = $_POST["name_first"];
                                $lname = $_POST["name_last"];
                                $phone = $_POST["phone"];
                                $street= $_POST["street"];
                                $city = $_POST["city"];
                                $state = $_POST["state"];
                                $zip = $_POST["zip_code"];
                                $city = $_POST["city"];
                                $Email = $_POST["Email"];
                                }
                else {
                     die();
                     }
 
$servername = "10.95.6.115";
$username = "yonael";
$password = "passyonael";
$dbname = "retail";
 
 
$con = mysqli_connect($servername, $username, $password, $dbname);
 
if (!$con) {
  die("Connection failed: " . mysqli_connect_error());
}
echo "Connected successfully";
 
$sql  ="INSERT INTO Customer 
VALUES(Null, '1', '$fname', '$lname ','$Email ','$phone ','$street','$city','$state','$zip')";


                $result1=mysqli_query($con,$sql);
	echo "<br>MySQL error number ", mysqli_errno($con);
	echo "<br>MySQL SQLSTATE ", mysqli_sqlstate($con);
	echo "<br>MySQL error ", mysqli_error($con); 

				
}
 
?>
 
 
<form action="Create_Account.php" method="post">
Account_ID:
<input type="number" name="account_id" value="<?php echo $account_id; ?>" > 
 
Employee_ID:
<input type="number" name="Emloyee_ID" value="<?php echo $lname; ?>" > 
 
First Name:
<input type="text" name="name_first" value="<?php echo $fname; ?>" > 
 
Last Name:
<input type="text" name="name_last" value="<?php echo $lname; ?>" > 
 
 
Email:
<input type="email" name="Email" value="<?php echo $Email; ?>" > 
<br><br>
 
Phone: <input type="tel" name="Phone"  pattern="[+]{1}[0-9]{11,14}" required value="<?php echo $phone; ?>" > 
<br><br>
 
Street: <input type="text" name="street" value="<?php echo $street; ?>" > 
 
City: <input type="text" name="city" value="<?php echo $city; ?>" > 
 
State: <input type="text" name="state" value="<?php echo $state; ?>" > 
 
ZIP: <input type="text" name="zip_code" value="<?php echo $zip; ?>" > 
<br><br>
 
<br>
<input type="submit" name="button" value="Submit Request"/>
</form>
 
 
</html>
 
 


<!DOCTYPE html>
<html>

	<head>	
        <title> Update Customer </title>
		<h1> Update Customer </h1>
    	</head>
<br>
<?php
 
if(!isset($_POST["button"]))
{
$account_id="";
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
								$account_id= $_POST["Account_ID"];
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
 
$sql  ="Update Customer
		Set First_name='$fname', Last_name='$lname', Phone='$phone', Email = '$Email' , Street='$street', City='$city', State='$state', zip_code='$zip'
			Where Account_ID= '$account_id'";



                $result1=mysqli_query($con,$sql);
	echo "<br>MySQL error number ", mysqli_errno($con);
	echo "<br>MySQL SQLSTATE ", mysqli_sqlstate($con);
	echo "<br>MySQL error ", mysqli_error($con); 

				
}
 
?>
 

Welcome to the UPDATE CUSTOMERS page for the Bank LSQL Database.
<br><br>
<p>Enter the account Id that you wish to change</p>

<form method="post" action="<?php echo $_SERVER['PHP_SELF']; ?>"> 

Account_ID:
<input type="number" name="account_id" value="<?php echo $account_id; ?>" ><br><br> 
 
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


</form>

</html> 
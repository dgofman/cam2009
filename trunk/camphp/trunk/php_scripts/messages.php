<?php
	function getMsg($id, $params=array()){
		switch($id){
			case "invalid_account":
				return array("Account not found", 1000);
			case "invalid":
				return array("Unexpected arguments", 1001);
			case "sys_err":
				return array("System error", 1002);
			case "email_err":
				return array("Sorry, but we cannot process your registration at this time.", 1003);
			case "email_reg_header":
				return array("Thank you for registering at ".COMPANY_NAME, 1004);
			case "email_reg":
				return array("Here is the link: <A href='".COMPANY_URL."/system/register.php?key=".$params[0]."'>".COMPANY_URL."/system/register.php?key=".$params[0]."</A><br><br>Click on the link to complete your request to register.<br><br>Important: You must respond to this email by clicking the link within 72 hours for your registration to be successful.", 1005);
			case "activate":
				return array("Thank you! Your account has been validated, you can now login to our system.", 1006);
			case "is_active":
				return array("This account has been already activated", 1007);
			case "is_disable":
				return array("You account was temporarily locked. Please contact our system administrator.", 1008);
			case "not_found":
				return array("Your account was removed or you submited invalid key", 1009);
			case "invalide_info":
				return array("The information you provided does not match that in our system. Please contact our System Administrator", 1010);
			case "password_sent":
				return array("Your new password has been sent to: ".$params[0], 1011);
			case "email_pwd_header":
				return array("Password has been reset", 1012);
			case "email_pwd":
				return array("Here is the link: <A href='".COMPANY_URL."/system/password.php?key=".$params[0]."'>".COMPANY_URL."/system/password.php?key=".$params[0]."</A><br><br>Click on the link to enter your password.<br><br>Important: You must respond to this email by clicking the link within 72 hours for your registration to be successful.", 1013);
		}
	}
?>
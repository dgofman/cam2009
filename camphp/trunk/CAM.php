<?php

$PHP_DIR = realpath("../../php_scripts");

require_once($PHP_DIR."/global.php");

class CAM {

	function CAM(){
		$this->LOGIN="SELECT A.first, A.language, B.userId, B.typeOf, B.status+0 AS STATUS FROM PERSON A, USER B WHERE A.personId=B.personId AND username='%s' AND PASSWORD=PASSWORD('%s')";
		$this->CREATE_USER="INSERT INTO users (first, last, language, address1, address2, city, stateProvince, postalCode, country, dateOfBirth, dayPhone, eveningPhone, cellPhone, email) values ('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s')";
		$this->CREATE_ACCOUNT="INSERT INTO account (userId, username, password) values (%u, '%s', PASSWORD('%s'))";
		$this->SELECT_ACCOUNT="SELECT CONCAT(userId,0+created_time) FROM account WHERE userId='%s'";
	}

	public function login($username, $password){
		$mysql = MYSQL::getInstance();
		$sql = escape($this->LOGIN, $username, $password);
		$rs = $mysql->query($sql);
		if(!$rs || !$mysql->rowCount()){
			error("invalid_account");
		}else{
			$result = $mysql->result($rs);
			return (count($result) == 0 ? NULL : $result[0]);
		}
	}
}
?>
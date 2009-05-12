<?php

$PHP_DIR = realpath("php_scripts");

require_once($PHP_DIR."/global.php");

class CAM {

	function CAM(){
		$this->LOGIN="SELECT A.first, A.localeName, B.userId, B.typeOf, B.status+0 AS status FROM person A, user B WHERE A.personId=B.personId AND username='%s' AND password=PASSWORD('%s')";
		$this->PERSON="SELECT A.accountId, A.personId, A.first, A.last, A.namesoundex, A.sex+0 AS sex, A.dateOfBirth, A.localeName, A.notes, B.username, B.privileges+0 AS privileges, B.status+0 AS status, B.typeOf+0 as typeOf, B.userId FROM person A, user B WHERE A.personId=B.personId AND B.userId='%s'";
		$this->USERS="SELECT A.personId, A.last, A.first, B.userId FROM person A, user B WHERE A.personId=B.personId AND B.status %s ORDER BY A.last";
		$this->LOCALE="SELECT localeName, language FROM locale";
	}
	
	public function getSessionId(){
		return $_COOKIE["PHPSESSID"];
	} 

	public function login($username, $password){
		$mysql = MYSQL::getInstance();
		$sql = escape($this->LOGIN, $username, $password);
		$rs = $mysql->query($sql);
		if(!$rs || !$mysql->rowCount()){
			$errNo = $mysql->getErrorNo();
			if($errNo == 0){
				error("invalid_account");
			}else{
				error($errNo, $mysql->getError());
			}
		}else{
			$result = $mysql->result($rs);
			if(count($result) == 0){
				error("invalid_result");
			}else{
				$_SESSION["USER_ID"] = $result[0]["userId"];
				return $result[0];
			}
		}
	}
	
	public function person($userId){
		$mysql = MYSQL::getInstance();
		$sql = escape($this->PERSON, $userId);
		$rs = $mysql->query($sql);
		$result = $mysql->result($rs);
		return (count($result) == 0 ? NULL : $result[0]);
	}
	
	public function users($status){
		$mysql = MYSQL::getInstance();
		if($status == NULL){
			$sql = escape($this->USERS, "IS NOT NULL");
		}else{
			$sql = escape($this->USERS, "=$status");
		}
		$rs = $mysql->query($sql);
		return $mysql->result($rs);
	}
	
	public function locale(){
		$mysql = MYSQL::getInstance();
		$rs = $mysql->query($this->LOCALE);
		$result = $mysql->result($rs);
		return $result;
	}
}
?>
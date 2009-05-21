<?php

$PHP_DIR = realpath("php_scripts");

require_once($PHP_DIR."/global.php");

class CAM {
	
	var $LOGIN_TIMEOUT = 5;
	
	function CAM(){
		$this->VALIDATE="SELECT loginDate FROM login WHERE username='%s' AND MINUTE(TIMEDIFF(loginDate, NOW())) < %d AND success=0 LIMIT 0, 3";
		$this->ACCESS="INSERT INTO login (username, success) VALUE ('%s', %d)";
		$this->CLEAN="DELETE FROM login WHERE username='%s'";
		$this->LOGIN="SELECT A.first, A.localeName, A.personId, A.typeOf, B.userId, B.status, B.privileges FROM person A, user B WHERE A.userId=B.userId AND username='%s' AND password=PASSWORD('%s')";
		$this->PERSON="SELECT A.accountId, A.personId, A.first, A.last, A.namesoundex, A.sex, A.dateOfBirth, A.localeName, B.username, B.privileges, B.status, B.typeOf, B.notes, B.userId FROM person A, user B WHERE A.personId=B.personId AND B.userId='%s'";
		$this->USERS="SELECT personId, userId, last, first FROM person WHERE typeOf s% ORDER BY last";
		$this->LOCALE="SELECT localeName, language FROM locale ORDER BY language";
		
		$this->UPDATE_PERSON="UPDATE person SET accountId='%s', first='%s', last='%s', namesoundex='%s', localeName='%s', sex='%s', dateOfBirth='%s' WHERE personId='%s'";
		$this->UPDATE_USER="UPDATE user SET	typeOf='%s', privileges='%s', status='%s', notes='%s', username='%s' %s WHERE userId='%s'";
		$this->CREATE_PERSON="INSERT INTO person (accountId, first, last, namesoundex, localeName, sex, dateOfBirth) VALUES ('%s', '%s', '%s', '%s', '%s', '%s', '%s')";		
		$this->CREATE_USER="INSERT INTO user (personId, typeOf, username, password, privileges, status, notes) VALUES ('%s', '%s', '%s', PASSWORD('%s'), '%s', '%s', '%s')";
	}
	
	public function getSessionId($destory=false){
		if($destory){
			$_SESSION = array();
			unset($_COOKIE[session_name()]);
			@session_destroy();
		}
		session_cache_expire(30);
	    @session_start();
		return session_id();
	}

	public function login($username, $password){
		$mysql = MYSQL::getInstance();
		$sql1 = escape($this->VALIDATE, $username, $this->LOGIN_TIMEOUT);
		$rs = $mysql->query($sql1);
		if($rs && $mysql->rowCount() >= 3){
			error("account_locked", NULL, array($this->LOGIN_TIMEOUT));
		}
		$sql2 = escape($this->LOGIN, $username, $password);
		$rs = $mysql->query($sql2, FALSE);
		if(!$rs || !$mysql->rowCount()){
			$errNo = $mysql->getErrorNo();
			$error = $mysql->getError();
			
			$sql3 = escape($this->ACCESS, $username, FALSE);
			$mysql->query($sql3);
			$mysql->commit();
		
			if($errNo == 0){
				error("invalid_account");
			}else{
				error($errNo, $error);
			}
		}else{
			$sql3 = escape($this->CLEAN, $username);
			$mysql->query($sql3);
			$sql4 = escape($this->ACCESS, $username, TRUE);
			$mysql->query($sql4);
			$mysql->commit();
				
			$result = $mysql->result($rs);
			if(count($result) == 0){
				error("invalid_result");
			}else{
				$_SESSION["USER_ID"] = $result[0]["userId"];
				return $result[0];
			}
		}
	}
	
	public function updateUser($userId, $personId, $accountId, $username, $password, $first, $last,
								$namesoundex, $dateOfBirth, $notes, $localeName, $sex, $typeOf, $privileges, $status){
								$mysql = MYSQL::getInstance();
		if(isset($userId) && isset($personId)){
			if(isset($password)){
				$sql1 = escape($this->UPDATE_USER, $typeOf, $privileges, $status, $notes, $username, ", password=PASSWORD('$password')", $userId);
			}else{
				$sql1 = escape($this->UPDATE_USER, $typeOf, $privileges, $status, $notes, $username, "", $userId);
			}
			$rs = $mysql->query($sql1, FALSE);
			if(!rs){
				error("cannot_update_user");
				return;
			}
			$sql2 = escape($this->UPDATE_PERSON, $accountId, $first, $last, $namesoundex, $localeName, $sex, $dateOfBirth, $personId);
			$rs = $mysql->query($sql2, FALSE);
			if(!rs){
				$mysql->rollback();
				error("cannot_update_person");
				return;
			}
		}else{
			$sql1 = escape($this->CREATE_PERSON, $accountId, $first, $last, $namesoundex, $localeName, $sex, $dateOfBirth);
			$rs = $mysql->query($sql1, FALSE);
			if(!$rs){
				error("cannot_create_user");
				return;
			}
			$personId = $mysql->insert();
			$sql2 = escape($this->CREATE_USER, $personId, $typeOf, $username, $password, $privileges, $status, $notes);
			$rs = $mysql->query($sql2, FALSE);
			if(!$rs){
				error("cannot_create_person");
				return;
			}
			$userId = $mysql->insert();
		}
		$sql = escape($this->PERSON, $userId);
		$rs = $mysql->query($sql);
		$result = $mysql->result($rs);
		return (count($result) == 0 ? NULL : $result[0]);
	}
	
	public function users($status){
		$mysql = MYSQL::getInstance();
		if(!isset($status) || $status == NULL){
			$sql = escape($this->USERS, "IS NOT NULL");
		}else{
			$sql = escape($this->USERS, "='$status'");
		}
		$rs = $mysql->query($sql);
		return $mysql->result($rs);
	}
	
	public function person($userId){
		$mysql = MYSQL::getInstance();
		$sql = escape($this->PERSON, $userId);
		$rs = $mysql->query($sql);
		$result = $mysql->result($rs);
		return (count($result) == 0 ? NULL : $result[0]);
	}

	public function locale(){
		$mysql = MYSQL::getInstance();
		$rs = $mysql->query($this->LOCALE);
		$result = $mysql->result($rs);
		return $result;
	}
}
?>
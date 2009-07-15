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
		$this->PERSONS="SELECT personId, userId, last, first FROM person WHERE typeOf %s ORDER BY last";
		$this->PERSON="SELECT personId, userId, accountId, first, last, sex, dateOfBirth, localeName, typeOf, notes FROM person WHERE personId='%s'";
		$this->USER="SELECT username, privileges, status, notes FROM user WHERE userId='%s'";
		$this->LOCALE="SELECT localeName, language FROM locale ORDER BY language";
		
		$this->CREATE_USER="INSERT INTO user (personId, username, password, privileges, status, notes) VALUES ('%s', '%s', PASSWORD('%s'), '%s', '%s', '%s')";
		$this->UPDATE_USER="UPDATE user SET	username='%s', privileges='%s', status='%s', notes='%s' WHERE userId='%s'";
		$this->CREATE_PERSON="INSERT INTO person (userId, first, last, sex, dateOfBirth, localeName, typeOf, notes) VALUES (%s, '%s', '%s', '%s', '%s', '%s', '%s', '%s')";
		$this->UPDATE_PERSON="UPDATE person SET userId=%s, first='%s', last='%s', sex='%s', dateOfBirth='%s', localeName='%s', typeOf='%s', notes='%s' WHERE personId='%s'";
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
				$_SESSION["USERNAME"] = $username;
				$_SESSION["PASSWORD"] = $password;
				$_SESSION["USER_ID"]  = $result[0]["userId"];
				return $result[0];
			}
		}
	}
	
	public function access(){
		$mysql = MYSQL::getInstance();
		$sql = escape($this->LOGIN, $_SESSION["USERNAME"], $_SESSION["PASSWORD"]);
		$rs = $mysql->query($sql);
		$result = $mysql->result($rs);
		return (count($result) == 0 ? NULL : $result[0]);
	}
	
	public function persons($typeOf){
		$mysql = MYSQL::getInstance();
		if(!isset($typeOf) || $typeOf == NULL){
			$sql = escape($this->PERSONS, "IS NOT NULL");
		}else{
			$sql = escape($this->PERSONS, "='$typeOf'");
		}
		$rs = $mysql->query($sql);
		return $mysql->result($rs);
	}
	
	public function person($personId){
		$mysql = MYSQL::getInstance();
		$sql = escape($this->PERSON, $personId);
		$rs = $mysql->query($sql);
		$result = $mysql->result($rs);
		return (count($result) == 0 ? NULL : $result[0]);
	}
	
	public function user($userId){
		$mysql = MYSQL::getInstance();
		$sql = escape($this->USER, $userId);
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
	
	public function updateRecord($userId, $personId, $first, $last, $dateOfBirth, $localeName,
								 $sex, $typeOf, $pnotes, $username, $password, $privileges, 
								 $status, $unotes, $updatePwd){
									
		$mysql = MYSQL::getInstance();
		
		if(isset($userId)){
			$sql = escape($this->UPDATE_USER, $username, $updatePwd == TRUE ? "password=PASSWORD('$password')," : "", $privileges, $status, $unotes, $userId);
			$rs = $mysql->query($sql, FALSE);
			if(!rs){
				error("cannot_update_user");
				return;
			}
		}else if(isset($username) && !empty($username)){
			$sql = escape($this->CREATE_USER, $personId, $username, $password, $privileges, $status, $unotes);
			$rs = $mysql->query($sql, FALSE);
			if(!$rs){
				error("cannot_create_user");
				return;
			}
			$userId = $mysql->insert();
		}
		
		if(!isset($userId) || $userId == NULL)
			$userId = "NULL";
		
		if(isset($personId)){
			$sql = escape($this->UPDATE_PERSON, $userId, $first, $last, $sex, $dateOfBirth, $localeName, $typeOf, $pnotes, $personId);
			$rs = $mysql->query($sql, FALSE);
			if(!rs){
				$mysql->rollback();
				error("cannot_update_person");
				return;
			}
		}else{
			$sql = escape($this->CREATE_PERSON, $userId, $first, $last, $sex, $dateOfBirth, $localeName, $typeOf, $pnotes);
			$rs = $mysql->query($sql, FALSE);
			if(!$rs){
				$mysql->rollback();
				error("cannot_create_person");
				return;
			}
			$personId = $mysql->insert();
		}
		$sql = escape($this->PERSON, $personId);
		$rs = $mysql->query($sql);
		$result = $mysql->result($rs);
		return (count($result) == 0 ? NULL : $result[0]);
	}
}
?>
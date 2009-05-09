<?php

@session_start();

$PHP_DIR = realpath("php_scripts");

require_once($PHP_DIR."/global.php");

class CAM {

	function CAM(){
		$this->LOGIN="SELECT A.first, A.language, B.userId, B.typeOf, B.status+0 AS status FROM person A, user B WHERE A.personId=B.personId AND username='%s' AND password=PASSWORD('%s')";
		$this->NOTICE="SELECT messageId, userId, priority+0 AS priority, status+0 AS status, subject, createdTime FROM messages WHERE type='notice' AND status <> 'delete' ORDER BY createdTime";
		$this->NOTICE_DETAILS="SELECT body FROM messages WHERE messageId='%s'";
		$this->NOTICE_UPDATE="UPDATE messages SET status='read', updatedTime=NOW(), updatedBy='%s' WHERE messageId='%s'";
		$this->NOTICE_DELETE="UPDATE messages SET status='delete', updatedTime=NOW(), updatedBy='%s' WHERE messageId='%s'";
		$this->PERSON="SELECT A.accountId, A.first, A.last, A.namesoundex, A.language, A.sex, A.dateOfBirth, A.notes, B.userId FROM person A, user B WHERE A.personId=B.personId AND B.userId='%s'";
		
		//$this->CREATE_USER="INSERT INTO users (first, last, language, address1, address2, city, stateProvince, postalCode, country, dateOfBirth, dayPhone, eveningPhone, cellPhone, email) values ('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s')";
		//$this->CREATE_ACCOUNT="INSERT INTO account (userId, username, password) values (%u, '%s', PASSWORD('%s'))";
		//$this->SELECT_ACCOUNT="SELECT CONCAT(userId,0+created_time) FROM account WHERE userId='%s'";
	}
	
	public function getSessionId(){
		return $_COOKIE["PHPSESSID"];
	} 

	public function login($username, $password){
		$mysql = MYSQL::getInstance();
		$sql = escape($this->LOGIN, $username, $password);
		$rs = $mysql->query($sql);
		if(!$rs || !$mysql->rowCount()){
			error("invalid_account");
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
	
	public function reporter($userId){
		$mysql = MYSQL::getInstance();
		$sql = escape($this->PERSON, $userId);
		$rs = $mysql->query($sql);
		$result = $mysql->result($rs);
		return (count($result) == 0 ? NULL : $result[0]);
	}

	public function notice(){
		$mysql = MYSQL::getInstance();
		$rs = $mysql->query($this->NOTICE);
		$result = $mysql->result($rs);
		return $result;
	}
	
	public function noticeDetails($messageId){
		$mysql = MYSQL::getInstance();
		$sql1 = escape($this->NOTICE_UPDATE, $_SESSION["USER_ID"], $messageId);
		$mysql->query($sql1);
		$sql2 = escape($this->NOTICE_DETAILS, $messageId);
		$rs = $mysql->query($sql2);
		$result = $mysql->result($rs);
		return (count($result) == 0 ? NULL : $result[0]);
	}
	
	public function deleteNotices(){
		$ids  = func_get_args();
		$deletedIds = array();
		$mysql = MYSQL::getInstance();
		foreach($ids as $messageId) {
		    $sql = escape($this->NOTICE_DELETE, $_SESSION["USER_ID"], $messageId);
			$rs = $mysql->query($sql);
			if($rs == true)
				array_push($deletedIds, $messageId);
		}
		$mysql->close();
		return $deletedIds;
	}
}
?>
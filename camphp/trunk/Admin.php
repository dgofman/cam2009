<?php

$PHP_DIR = realpath("php_scripts");

require_once($PHP_DIR."/global.php");

class Admin {

	function Admin(){
		$this->MESSAGE_DETAILS="SELECT body FROM messages WHERE messageId='%s'";
		$this->MESSAGE_CREATE="INSERT INTO messages (userId, type, priority, subject, body) VALUES ('%s', '%s', '%s', '%s', '%s')";
		$this->MESSAGE_UPDATE="UPDATE messages SET status='read', updatedTime=NOW(), updatedBy='%s' WHERE messageId='%s'";
		$this->MESSAGE_DELETE="UPDATE messages SET status='delete', updatedTime=NOW(), updatedBy='%s' WHERE messageId='%s'";
		$this->MESSAGE_RESTORE="UPDATE messages SET status='unread', updatedTime=NOW(), updatedBy='%s' WHERE messageId='%s'";
		$this->MESSAGE="SELECT messageId, userId, priority+0 AS priority, status+0 AS status, subject, createdTime FROM messages WHERE messageId='%s'";
		$this->NOTICE="SELECT messageId, userId, priority+0 AS priority, status+0 AS status, subject, createdTime FROM messages WHERE type='notice' AND status <> 'delete' ORDER BY createdTime DESC";
		$this->NEWS="SELECT messageId, priority+0 AS priority, status+0 AS status, subject, createdTime FROM messages WHERE type='news' AND status <> 'delete' ORDER BY createdTime DESC";
		$this->TODO="SELECT messageId, priority+0 AS priority, status+0 AS status, subject, createdTime FROM messages WHERE type='todo' AND status <> 'delete' ORDER BY createdTime DESC";
		$this->RESTORE="SELECT messageId, priority, type, subject, createdTime, updatedTime FROM messages WHERE status='delete' ORDER BY createdTime DESC";
	}
	
	public function messageBody($messageId){
		$mysql = MYSQL::getInstance();
		$sql1 = escape($this->MESSAGE_UPDATE, $_SESSION["USER_ID"], $messageId);
		$mysql->query($sql1);
		$sql2 = escape($this->MESSAGE_DETAILS, $messageId);
		$rs = $mysql->query($sql2);
		$result = $mysql->result($rs);
		if(count($result) == 0)
			return NULL;
		else
			return $result[0]["body"];
	}
	
	public function createMessage($type, $priority, $subject, $body){
		$mysql = MYSQL::getInstance();
		$sql1 = escape($this->MESSAGE_CREATE, $_SESSION["USER_ID"], $type, $priority, $subject, $body);
		$rs = $mysql->query($sql1);
		if($rs == true){
			$messageId = $mysql->insert();
			$sql2 = escape($this->MESSAGE, $messageId);
			$rs = $mysql->query($sql2);
			$result = $mysql->result($rs);
			return (count($result) == 0 ? NULL : $result[0]);
		}else{
			return NULL;
		}
	}
	
	public function deleteMessage(){
		$ids  = func_get_args();
		$deletedIds = array();
		$mysql = MYSQL::getInstance();
		foreach($ids as $messageId) {
		    $sql = escape($this->MESSAGE_DELETE, $_SESSION["USER_ID"], $messageId);
			$rs = $mysql->query($sql);
			if($rs == true)
				array_push($deletedIds, $messageId);
		}
		$mysql->close();
		return $deletedIds;
	}
	
	public function restoreMessage(){
		$ids  = func_get_args();
		$restoreIds = array();
		$mysql = MYSQL::getInstance();
		foreach($ids as $messageId) {
		    $sql = escape($this->MESSAGE_RESTORE, $_SESSION["USER_ID"], $messageId);
			$rs = $mysql->query($sql);
			if($rs == true)
				array_push($restoreIds, $messageId);
		}
		$mysql->close();
		return $restoreIds;
	}
	
	public function notice(){
		$mysql = MYSQL::getInstance();
		$rs = $mysql->query($this->NOTICE);
		$result = $mysql->result($rs);
		return $result;
	}
	
	public function news(){
		$mysql = MYSQL::getInstance();
		$rs = $mysql->query($this->NEWS);
		$result = $mysql->result($rs);
		return $result;
	}
	
	public function todo(){
		$mysql = MYSQL::getInstance();
		$rs = $mysql->query($this->TODO);
		$result = $mysql->result($rs);
		return $result;
	}

	public function restore(){
		$mysql = MYSQL::getInstance();
		$rs = $mysql->query($this->RESTORE);
		$result = $mysql->result($rs);
		return $result;
	}
}
?>
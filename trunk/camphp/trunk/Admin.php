<?php

class Admin {

	function Admin(){
		$this->MESSAGE_DETAILS="SELECT userId, messageId, body, subject, priority, createdTime, status FROM messages WHERE messageId='%s'";
		$this->MESSAGE_CREATE="INSERT INTO messages (userId, type, priority, subject, body, status) VALUES ('%s', '%s', '%s', '%s', '%s', 'read')";
		$this->MESSAGE_UPDATE="UPDATE messages SET status='unread', updatedTime=NOW(), updatedBy='%s', priority='%s', subject='%s', body='%s' WHERE messageId='%s'";
		$this->MESSAGE_STATUS="UPDATE messages SET status='%s', updatedTime=NOW(), updatedBy='%s' WHERE messageId='%s'";
		
		$this->NOTICE="SELECT userId, messageId, body, subject, priority, createdTime, status FROM messages WHERE type='notice' AND status <> 'delete' ORDER BY createdTime DESC";
		$this->NEWS="SELECT messageId, body, subject, priority, createdTime, status FROM messages WHERE type='news' AND status <> 'delete' ORDER BY createdTime DESC";
		$this->TODO="SELECT messageId, body, subject, priority, createdTime, status FROM messages WHERE type='todo' AND status <> 'delete' AND userId='%s' ORDER BY createdTime DESC";
		$this->RESTORE="SELECT messageId, priority, type, subject, createdTime, updatedTime FROM messages WHERE status='delete' ORDER BY createdTime DESC";
	}
	
	public function createMessage($type, $priority, $subject, $body, $messageId){
		$mysql = MYSQL::getInstance();
		if(isset($messageId)){
			$sql1 = escape($this->MESSAGE_UPDATE, $_SESSION["USER_ID"], $priority, $subject, $body, $messageId);
			$rs = $mysql->query($sql1);
		}else{
			$sql1 = escape($this->MESSAGE_CREATE, $_SESSION["USER_ID"], $type, $priority, $subject, $body);
			$rs = $mysql->query($sql1);
			if(!$rs){
				error("cannot_create_message");
				return;
			}
			$messageId = $mysql->insert();
		}
		if(isset($messageId)){
			$sql2 = escape($this->MESSAGE_DETAILS, $messageId);
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
		    $sql = escape($this->MESSAGE_STATUS, "delete", $_SESSION["USER_ID"], $messageId);
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
		    $sql = escape($this->MESSAGE_STATUS, "unread", $_SESSION["USER_ID"], $messageId);
			$rs = $mysql->query($sql);
			if($rs == true)
				array_push($restoreIds, $messageId);
		}
		$mysql->close();
		return $restoreIds;
	}
	
	public function read($messageId){
		$mysql = MYSQL::getInstance();
		$sql = escape($this->MESSAGE_STATUS, "read", $_SESSION["USER_ID"], $messageId);
		$rs = $mysql->query($sql);
		$mysql->close();
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
		$sql = escape($this->TODO, $_SESSION["USER_ID"]);
		$rs = $mysql->query($sql);
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
<?php

class Employee {

	function Employee(){
		$this->SEARCH="SELECT A.employeeId, B.userId, C.personId, C.first, C.last FROM employee A, user B RIGHT JOIN person C ON (B.personId=C.personId) WHERE A.personId=C.personId AND (C.first LIKE '%s' OR C.last LIKE '%s') ORDER BY C.last";
		$this->EMPLOYEES="SELECT A.employeeId, B.userId, C.personId, C.first, C.last FROM employee A, user B RIGHT JOIN person C ON (B.personId=C.personId) WHERE A.personId=C.personId ORDER BY C.last";
	}
	
	public function searchEmployees($keyword){
		$mysql = MYSQL::getInstance();
		$sql = escape($this->SEARCH, "%$keyword%", "%$keyword%");
		$rs = $mysql->query($sql);
		return $mysql->result($rs);
	}
	
	public function employees(){
		$mysql = MYSQL::getInstance();
		$rs = $mysql->query($this->EMPLOYEES);
		return $mysql->result($rs);
	}
}
?>
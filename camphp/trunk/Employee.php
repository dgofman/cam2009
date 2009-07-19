<?php

class Employee {

	function Employee(){
		$this->EMPLOYEES="SELECT A.employeeId, B.userId, C.personId, C.first, C.last FROM employee A, user B RIGHT JOIN person C ON (B.personId=C.personId) WHERE A.personId=C.personId ORDER BY C.last";
	}

	public function employees(){
		$mysql = MYSQL::getInstance();
		$rs = $mysql->query($this->EMPLOYEES);
		$result = $mysql->result($rs);
		return $result;
	}
}
?>
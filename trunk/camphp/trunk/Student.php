<?php

class Student {

	function Student(){
		$this->STUDENTS="SELECT A.studentId, B.userId, C.personId, C.first, C.last FROM student A, user B RIGHT JOIN person C ON (B.personId=C.personId) WHERE A.personId=C.personId ORDER BY C.last";
	}

	public function students(){
		$mysql = MYSQL::getInstance();
		$rs = $mysql->query($this->STUDENTS);
		$result = $mysql->result($rs);
		return $result;
	}
}
?>
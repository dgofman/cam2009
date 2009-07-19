<?php

class Student {

	function Student(){
		$this->SEARCH="SELECT A.studentId, B.userId, C.personId, C.first, C.last FROM student A, user B RIGHT JOIN person C ON (B.personId=C.personId) WHERE A.personId=C.personId AND (C.first LIKE '%s' OR C.last LIKE '%s') ORDER BY C.last";
		$this->STUDENTS="SELECT A.studentId, B.userId, C.personId, C.first, C.last FROM student A, user B RIGHT JOIN person C ON (B.personId=C.personId) WHERE A.personId=C.personId ORDER BY C.last";
	}
	
	public function searchStudents($keyword){
		$mysql = MYSQL::getInstance();
		$sql = escape($this->SEARCH, "%$keyword%", "%$keyword%");
		$rs = $mysql->query($sql);
		return $mysql->result($rs);
	}
	
	public function students(){
		$mysql = MYSQL::getInstance();
		$rs = $mysql->query($this->STUDENTS);
		return $mysql->result($rs);
	}
}
?>
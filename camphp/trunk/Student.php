<?php

$PHP_DIR = realpath("php_scripts");

require_once($PHP_DIR."/global.php");

class Student {

	function Student(){
		$this->STUDENTS="SELECT studentId, accountId, personId, enrollDate, status+0 AS status, studentType+0 AS studentType, medication, allergies FROM student";
	}

	public function students(){
		$mysql = MYSQL::getInstance();
		$rs = $mysql->query($this->STUDENTS);
		$result = $mysql->result($rs);
		return $result;
	}
}
?>
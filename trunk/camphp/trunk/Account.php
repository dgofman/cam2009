<?php

class Account {

	function Account(){
		$this->LINKS="SELECT A.first, A.last, B.personId, B.accountId, B.relation, B.primary FROM person A RIGHT JOIN accountlinks B ON A.personId=B.personId RIGHT JOIN accountlinks C ON B.accountId=C.accountId WHERE C.personId=%s ORDER BY B.relation";
		$this->ACCOUNT="SELECT A.selectedBillingAddressId, A.selectedBillingEmailContactId, A.currentBalance, A.lastPaymentDate, B.address1, B.city, B.stateProvince, B.postalCode, C.entry FROM account A LEFT JOIN address B ON A.selectedBillingAddressId=B.addressId LEFT JOIN contact C ON A.selectedBillingEmailContactId=C.contactId WHERE A.accountId=%s";
		$this->CONTACT="SELECT A.contactId, A.type, CONCAT(A.entry, ' (', A.category, ')') AS entry FROM contact A, addresscontact B WHERE A.contactId=B.contactId AND B.personId=%s";
		$this->ADDRESS="SELECT A.addressId, A.address1, A.city, A.stateProvince, A.postalCode, A.priority FROM address A, addresscontact B WHERE A.addressId=B.addressId AND B.personId=%s";
		$this->LESSONS="SELECT C.lessonTypeId, C.lesson FROM lessoncontrol A, student B, lessontype C WHERE A.studentId=B.studentId AND B.personId=%s AND A.lessonTypeId=C.lessonTypeId GROUP BY C.lessonTypeId";
		$this->DETAILS="SELECT A.startDate, A.endDate, A.startTime, A.disposition, B.lessonControlId, D.type, E.duration, E.rate, G.first, G.last FROM lessonschedule A, lessoncontrol B, student C, lessontype D, tuitiontype E, employee F, person G WHERE A.lessoncontrolId=B.lessonControlId AND B.studentId=C.studentId AND B.lessonTypeId=%s AND C.personId=%s AND B.lessonTypeId=D.lessonTypeId AND B.tuitionTypeId=E.tuitionTypeId AND B.employeeId=F.employeeId AND F.personId=G.personId ORDER BY A.startDate, A.startTime";
		$this->SCHEDULE="SELECT scheduleId, refScheduleId, startDate, endDate, smtwtfs, TIME_FORMAT(startTime, '%s') AS startTime, disposition, notes, canReschedule FROM lessonschedule A, lessoncontrol B, lessontype C WHERE A.lessoncontrolId=%s AND A.lessoncontrolId=B.lessonControlId AND B.lessonTypeId=C.lessonTypeId ORDER BY startDate, refScheduleId, startTime";
		$this->VALIDATE="SELECT accountId FROM accountlinks WHERE personId=%s";
		$this->RESCHEDULE="UPDATE lessonschedule SET startTime='%s', startDate='%s', endDate='%s', smtwtfs='%s', disposition='%s', notes=%s WHERE scheduleId=%s";
	}
	
	public function valid($personId){
		$mysql = MYSQL::getInstance();
		$sql = escape($this->VALIDATE, $personId);
		$rs = $mysql->query($sql);
		return $mysql->result($rs);
	}
	
	public function links($personId){
		$mysql = MYSQL::getInstance();
		$sql = escape($this->LINKS, $personId);
		$rs = $mysql->query($sql);
		return $mysql->result($rs);
	}
	
	public function selectedAccount($accountId){
		$mysql = MYSQL::getInstance();
		$sql = escape($this->ACCOUNT, $accountId);
		$rs = $mysql->query($sql);
		$result = $mysql->result($rs);
		return (count($result) == 0 ? NULL : $result[0]);
	}
	
	public function contact($personId){
		$mysql = MYSQL::getInstance();
		$sql = escape($this->CONTACT, $personId);
		$rs = $mysql->query($sql);
		return $mysql->result($rs);
	}
	
	public function address($personId){
		$mysql = MYSQL::getInstance();
		$sql = escape($this->ADDRESS, $personId);
		$rs = $mysql->query($sql);
		return $mysql->result($rs);
	}
	
	public function lessons($personId){
		$mysql = MYSQL::getInstance();
		$sql = escape($this->LESSONS, $personId);
		$rs = $mysql->query($sql);
		return $mysql->result($rs);
	}
	
	public function details($personId, $lessonTypeId){
		$mysql = MYSQL::getInstance();
		$sql = escape($this->DETAILS, $lessonTypeId, $personId);
		$rs = $mysql->query($sql);
		return $mysql->result($rs);
	}
	
	public function schedule($lessoncontrolId){
		$mysql = MYSQL::getInstance();
		$sql = escape($this->SCHEDULE, "%H:%i", $lessoncontrolId);
		$rs = $mysql->query($sql);
		return $mysql->result($rs);
	}
	
	public function current($type, $scheduleId, $refScheduleId, $startTime, $startDate, $endDate, $smtwtfs, $disposition="lesson taken", $notes=NULL){
		$mysql = MYSQL::getInstance();
		if($type == 1 || $type == 2){ //moved rescheduled recurring or new lesson
			$sql = escape($this->RESCHEDULE, $startTime, $startDate, $endDate, $smtwtfs, $disposition, ($notes == NULL ? "NULL" : "'".$notes."'"), $scheduleId);
			$rs = $mysql->query($sql);
			$mysql->commit();
		}else{ //reschedule recurring lesson
			
		}
		$mysql->close();
	}
	
	public function future($scheduleId){
		$mysql = MYSQL::getInstance();
		//$sql = escape($this->SCHEDULE, "%H:%i", $lessoncontrolId);
		//$rs = $mysql->query($sql);
		//return $mysql->result($rs);
		$mysql->close();
	}
}
?>
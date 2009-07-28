<?php

class Account {

	function Account(){
		$this->LINKS="SELECT A.first, A.last, B.studentId, C.personId, C.accountId, C.relation, C.primary FROM person A LEFT JOIN student B ON A.personId=B.personId RIGHT JOIN accountlinks C ON A.personId=C.personId RIGHT JOIN accountlinks D ON C.accountId=D.accountId WHERE D.personId=%s ORDER BY C.relation";
		$this->ACCOUNT="SELECT A.selectedBillingAddressId, A.selectedBillingEmailContactId, A.currentBalance, A.lastPaymentDate, B.address1, B.city, B.stateProvince, B.postalCode, C.entry FROM account A LEFT JOIN address B ON A.selectedBillingAddressId=B.addressId LEFT JOIN contact C ON A.selectedBillingEmailContactId=C.contactId WHERE A.accountId=%s";
		$this->CONTACT="SELECT A.contactId, A.type, CONCAT(A.entry, ' (', A.category, ')') AS entry FROM contact A, addresscontact B WHERE A.contactId=B.contactId AND B.personId=%s";
		$this->ADDRESS="SELECT A.addressId, A.address1, A.city, A.stateProvince, A.postalCode, A.priority FROM address A, addresscontact B WHERE A.addressId=B.addressId AND B.personId=%s";
		$this->LESSONS="SELECT A.lessonControlId, C.description, C.type, D.description, D.rate, F.first, F.last FROM lessoncontrol A, student B, lessontype C, tuitiontype D, employee E, person F WHERE A.studentId=B.studentId AND B.studentId=%s AND A.lessonTypeId=C.lessonTypeId AND A.tuitionTypeId=D.tuitionTypeId AND A.employeeId=E.employeeId AND E.personId=F.personId";
		
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
	
	public function lessons($studentId){
		$mysql = MYSQL::getInstance();
		$sql = escape($this->LESSONS, $studentId);
		$rs = $mysql->query($sql);
		return $mysql->result($rs);
	}
}
?>
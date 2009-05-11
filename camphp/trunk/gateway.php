<?php
@session_start();

require_once('Zend/Amf/Server.php');
$server = new Zend_Amf_Server();

$server->setProduction(false);

require_once('CAM.php');
$server->setClass('CAM');

require_once('Admin.php');
$server->setClass('Admin');

require_once('Student.php');
$server->setClass('Student');

echo($server->handle());
?>
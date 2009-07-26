<?php
@session_start();

$PHP_DIR = realpath("php_scripts");

require_once($PHP_DIR."/global.php");

require_once('Zend/Amf/Server.php');
$server = new Zend_Amf_Server();

$server->setProduction(false);

require_once('CAM.php');
$server->setClass('CAM');

require_once('Admin.php');
$server->setClass('Admin');

require_once('Student.php');
$server->setClass('Student');

require_once('Employee.php');
$server->setClass('Employee');

require_once('Account.php');
$server->setClass('Account');

echo($server->handle());
?>
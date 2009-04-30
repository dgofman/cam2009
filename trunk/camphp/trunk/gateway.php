<?php
require_once('Zend/Amf/Server.php');
$server = new Zend_Amf_Server();

require_once('CAM.php');
$server->setClass('CAM');

echo($server->handle());
?>
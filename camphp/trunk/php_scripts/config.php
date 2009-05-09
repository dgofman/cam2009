<?php
	# database connect information
	define("SERVER_DATABASE", isset($_ENV["MYSQL_DB"]) ? $_ENV["MYSQL_DB"] : "calderon_schooladmin");
	define("SERVER_DBHOST",   isset($_ENV["MYSQL_DBHOST"]) ? $_ENV["SERVER_DBHOST"] : "localhost");
	define("SERVER_DBUSER",   isset($_ENV["MYSQL_DBUSER"]) ? $_ENV["SERVER_DBUSER"] : "root");
	define("SERVER_DBPASS",   isset($_ENV["MYSQL_DBPASS"]) ? $_ENV["SERVER_DBPASS"] : "");
	
	//Hard code in class.smtp.php line 100
	//define("SMTP_HOST", "ssl://smtp.gmail.com");
	//define("SMTP_PORT", "465");
	define("USE_SENDMAIL", "true");
	define("SMTP_HOST", "calderacademy.com");
	define("SMTP_PORT", "26");
	define("SMTP_USERNAME", "learn@calderacademy.com");
	define("SMTP_PASSWORD", "");

	define("WEB_MASTER_NAME", "Calder Academy");
	define("WEB_MASTER_EMAIL", "learn@calderacademy.com");
	define("WEB_REPLY_EMAIL", "learn@calderacademy.com");

	define("COMPANY_NAME", "Calder Academy");
	define("COMPANY_URL", "http://www.calderacademy.com");
//	define("COMPANY_URL", "http://localhost/camweb/");
?>

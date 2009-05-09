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
	define("SMTP_HOST",     isset($_ENV["SMTP_HOST"]) ? $_ENV["SMTP_HOST"] : "calderacademy.com");
	define("SMTP_PORT",     isset($_ENV["SMTP_PORT"]) ? $_ENV["SMTP_PORT"] : "26");
	define("SMTP_USERNAME", isset($_ENV["SMTP_UID"])  ? $_ENV["SMTP_UID"]  : "learn@calderacademy.com");
	define("SMTP_PASSWORD", isset($_ENV["SMTP_PWD"])  ? $_ENV["SMTP_PWD"]  : "");

	define("WEB_MASTER_NAME",  isset($_ENV["WEB_MASTER_NAME"])  ? $_ENV["WEB_MASTER_NAME"]  : "Calder Academy");
	define("WEB_MASTER_EMAIL", isset($_ENV["WEB_MASTER_EMAIL"]) ? $_ENV["WEB_MASTER_EMAIL"] :  "learn@calderacademy.com");
	define("WEB_REPLY_EMAIL",  isset($_ENV["WEB_REPLY_EMAIL"])  ? $_ENV["WEB_REPLY_EMAIL"]  : "learn@calderacademy.com");

	define("COMPANY_NAME", isset($_ENV["COMPANY_NAME"]) ? $_ENV["COMPANY_NAME"] : "Calder Academy");
	define("COMPANY_URL",  isset($_ENV["COMPANY_URL"])  ? $_ENV["COMPANY_URL"]  : "http://www.calderacademy.com");
?>

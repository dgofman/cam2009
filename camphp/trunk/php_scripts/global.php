<?php
	ini_set("display_errors","On"); 
	error_reporting (E_ERROR | E_WARNING | E_PARSE | !E_NOTICE);
	
	require_once($PHP_DIR."/class.phpmailer.php");
	require_once($PHP_DIR."/config.php");
	require_once($PHP_DIR."/messages.php");

	$USER_IP = GetHostByName($_SERVER['REMOTE_ADDR']);
	$PATH = ($USER_IP == '127.0.0.1') ? '.' : '';
	
	function getVar($var, $default = '')
	{
		@$getParams = $_GET["$var"];
		@$postParams = $_POST["$var"];

		if(sizeof($getParams) > 0)
			return $getParams;
		else if(sizeof($postParams) > 0)
			return $postParams;
		else
			return $default;
	}
	
	function isEmpty($var){
		return strlen(trim($var)) == 0;
	}
	
	function replace($str){
		$str = str_replace('&', '&#38;', $str);
		return str_replace('\\"', '"', $str);
	}

	function escape($query) {
		$args  = func_get_args();
		$query = array_shift($args);
		//$args  = array_map('mysql_real_escape_string', $args);
		array_unshift($args,$query);
		return call_user_func_array('sprintf',$args);
	}

/*start striphtml---------------------------------------------------------------------------------------------------------*/
/**
 * Copyright (c) 2008, David R. Nadeau, NadeauSoftware.com.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 *	* Redistributions of source code must retain the above copyright
 *	  notice, this list of conditions and the following disclaimer.
 *
 *	* Redistributions in binary form must reproduce the above
 *	  copyright notice, this list of conditions and the following
 *	  disclaimer in the documentation and/or other materials provided
 *	  with the distribution.
 *
 *	* Neither the names of David R. Nadeau or NadeauSoftware.com, nor
 *	  the names of its contributors may be used to endorse or promote
 *	  products derived from this software without specific prior
 *	  written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 * COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
 * WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY
 * OF SUCH DAMAGE.
 */
/*
 * This is a BSD License approved by the Open Source Initiative (OSI).
 * See:  http://www.opensource.org/licenses/bsd-license.php
 */
/**
 * Strip out (X)HTML tags and invisible content.  This function
 * is useful as a prelude to tokenizing the visible text of a page
 * for use in a search engine or spam detector/remover.
 *
 * Unlike PHP's built-in strip_tags() function, this function will
 * remove invisible parts of a web page that normally should not be
 * indexed or passed through a spam filter.  This includes style
 * blocks, scripts, applets, embedded objects, and everything in the
 * page header.
 *
 * In anticipation of tokenizing the visible text, this function
 * detects (X)HTML block tags (such as divs, paragraphs, and table
 * cells) and inserts a carriage return before each one.  This
 * insures that after tags are removed, words before and after the
 * tag are not erroneously joined into a single word.
 *
 * Parameters:
 * 	text		the (X)HTML text to strip
 *
 * Return values:
 * 	the stripped text
 *
 * See:
 * 	http://nadeausoftware.com/articles/2007/09/php_tip_how_strip_html_tags_web_page
 */
function strip_html_tags( $text )
{
	// PHP's strip_tags() function will remove tags, but it
	// doesn't remove scripts, styles, and other unwanted
	// invisible text between tags.  Also, as a prelude to
	// tokenizing the text, we need to insure that when
	// block-level tags (such as <p> or <div>) are removed,
	// neighboring words aren't joined.
	$text = preg_replace(
		array(
			// Remove invisible content
			'@<head[^>]*?>.*?</head>@siu',
			'@<style[^>]*?>.*?</style>@siu',
			'@<script[^>]*?.*?</script>@siu',
			'@<object[^>]*?.*?</object>@siu',
			'@<embed[^>]*?.*?</embed>@siu',
			'@<applet[^>]*?.*?</applet>@siu',
			'@<noframes[^>]*?.*?</noframes>@siu',
			'@<noscript[^>]*?.*?</noscript>@siu',
			'@<noembed[^>]*?.*?</noembed>@siu',

			// Add line breaks before & after blocks
			'@<((br)|(hr))@iu',
			'@</?((address)|(blockquote)|(center)|(del))@iu',
			'@</?((div)|(h[1-9])|(ins)|(isindex)|(p)|(pre))@iu',
			'@</?((dir)|(dl)|(dt)|(dd)|(li)|(menu)|(ol)|(ul))@iu',
			'@</?((table)|(th)|(td)|(caption))@iu',
			'@</?((form)|(button)|(fieldset)|(legend)|(input))@iu',
			'@</?((label)|(select)|(optgroup)|(option)|(textarea))@iu',
			'@</?((frameset)|(frame)|(iframe))@iu',
		),
		array(
			' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ',
			"\n\$0", "\n\$0", "\n\$0", "\n\$0", "\n\$0", "\n\$0",
			"\n\$0", "\n\$0",
		),
		$text );

	// Remove all remaining tags and comments and return.
	return strip_tags( $text );
}
/*end   striphtml---------------------------------------------------------------------------------------------------------*/
	function send_mail($to_email, $to_name, $subject, $htmlBody, $textBody='', $from_email, $from_name) {
		global $PHP_DIR;
		if(empty($textBody)){
			/*$textBody = str_replace('<br>', '\\n', $htmlBody);*/
			$textBody = strip_html_tags($htmlBody);
		}
		$mail = new PHPMailer();
		$mail->PluginDir=$PHP_DIR."/";
		$mail->IsSMTP();                 // send via SMTP
		$mail->SMTPAuth = true;          // turn on SMTP authentication
		$mail->Username = SMTP_USERNAME; // SMTP username
		$mail->Password = SMTP_PASSWORD; // SMTP password
		$mail->From = $from_email;
		$mail->FromName = $from_name;
		$mail->AddAddress($to_email, $to_name);
		$mail->AddReplyTo($from_email, $from_name);
		//$mail->AddAttachment("/tmp/image.jpg", "new.jpg"); // attachment
		$mail->WordWrap = 50;       // set word wrap
		$mail->IsHTML(true);        // send as HTML
		$mail->Subject = $subject;  //Subject
		$mail->Body = $htmlBody;    //HTML Body
		$mail->AltBody = $textBody; //Text Body
		if($mail->Send()){
			return true;
		}else{
			return false;
		}
	}

	function send_mail_attach($to_email, $to_name, $subject, $htmlBody, $textBody='', $from_email, $from_name, $attachfile1='', $af1name='', $attachfile2='', $af2name='',
	  $attachfile3='', $af3name='', $attachEmbedGif1='', $attachEmbedGif2='', $attachEmbedGif3='', $attachEmbedJpg1='', $attachEmbedJpg2='', $attachEmbedJpg3='') {
		global $PHP_DIR;
		if(empty($textBody)){
			$textBody = strip_html_tags($htmlBody);
			$textBody = mb_convert_encoding($textBody, "utf-8", "HTML-ENTITIES" );
			$textBody = preg_replace("/\s\s+/", "\n", $textBody);
			$textBody = preg_replace("/\n\n+/s","\n",$textBody); 
		}
		$mail = new PHPMailer();
		$mail->PluginDir=$PHP_DIR."/";
		$mail->IsSMTP();                 // send via SMTP
		$mail->SMTPAuth = true;          // turn on SMTP authentication
		$mail->Username = SMTP_USERNAME; // SMTP username
		$mail->Password = SMTP_PASSWORD; // SMTP password
		$mail->From = $from_email;
		$mail->FromName = $from_name;
		$mail->AddAddress($to_email, $to_name);
		$mail->AddReplyTo($from_email, $from_name);
		if(!empty($attachfile1))
			$mail->AddAttachment($attachfile1, $af1name); // attachment
		if(!empty($attachfile2))
			$mail->AddAttachment($attachfile2, $af2name); // attachment
		if(!empty($attachfile3))
			$mail->AddAttachment($attachfile3, $af3name); // attachment
		$mail->WordWrap = 50;       // set word wrap
		$mail->IsHTML(true);        // send as HTML
		$mail->Subject = $subject;  //Subject
		$mail->Body = $htmlBody;    //HTML Body
		$mail->AltBody = $textBody; //Text Body
		if($mail->Send()){
			return true;
		}else{
			return false;
		}
	}
	
	function error($messageId=0, $message=NULL, $params=array()){
		$keys;
		if($message == NULL)
			$keys = getMsg($messageId, $params);
		else
			$keys = array($message, $messageId);
		MYSQL::getInstance()->close(false);
		throw new Exception($keys[0], $keys[1]);
	}
	
	//database API
	class MYSQL
	{
		var $handle;
		
		// Store the single instance of Database
		private static $m_pInstance;
	
		// Private constructor to limit object instantiation to within the class
		private function __construct() {}
	
		// Getter method for creating/returning the single instance of this class
		public static function getInstance(){
			if (!self::$m_pInstance){
				self::$m_pInstance = new MYSQL();
				self::$m_pInstance->connect();
			}
			return self::$m_pInstance;
		}

		function connect() {
			$this->handle = mysql_connect(SERVER_DBHOST, SERVER_DBUSER, SERVER_DBPASS);
			mysql_select_db(SERVER_DATABASE);
			return mysql_query("BEGIN", $this->handle);
		}

		function &query($sql, $sendError=TRUE){
			$this->result = mysql_query($sql, $this->handle);
			$errorNo = $this->getErrorNo();
			$errorMsg = $this->getError();
			if(!$this->result){
				error_log($errorMsg, $errorNo);
				if($sendError)
					error($errorNo, $errorMsg);
			}
			return $this->result;
		}

		function &fetchRow($result){
			return mysql_fetch_row($result);
		}
		
		function &enum($table, $field){
			$rs = $this->query("SHOW COLUMNS FROM $table WHERE FIELD='$field'");
			$result = array();
			if($rs){
				while($row = mysql_fetch_row($rs)){
					$options = explode("','",preg_replace("/(enum|set)\('(.+?)'\)/","\\2", $row[1]));
					array_push($result, array($row[0] => $options));
				}
			}else if($this->getErrorNo() != 0){
				error($this->getErrorNo(), $this->getError());
			}
			$this->close();
			return $result;
		}
		
		function &result($rs, $close=TRUE){
			$result = array();
			if($rs){
				while($row = mysql_fetch_assoc($rs))
					array_push($result, $row);
			}else if($this->getErrorNo() != 0){
				error($this->getErrorNo(), $this->getError());
			}
			if($close)
				$this->close();
			return $result;
		}

		function fieldName($row, $index = 0){
			return mysql_field_name($row, $index);
		}
		
		function numFields($row){
			return mysql_num_fields($row);
		}

		function rowCount(){
			return mysql_affected_rows($this->handle);
		}

		function insert() {
			return mysql_insert_id($this->handle);
		}

		function rollback() {
			if($this->handle)
				mysql_query("ROLLBACK", $this->handle);
		}
		
		function commit() {
			if($this->handle)
				mysql_query("COMMIT", $this->handle);
		}

		function close($commit=true){
			if($this->handle){
				if($commit)
					$this->commit();
				mysql_close($this->handle);
				$this->handle = NULL;
			}
		}

		function getError() {
			if($this->handle){
				return mysql_error($this->handle);
			}
		}

		function getErrorNo(){
			if($this->handle){
				return mysql_errno($this->handle);
			}
		}

		function getErrorInfo($index=0){
			return createError($this->getErrorNo(), $this->getError(), $index);
		}

		function resetAutoIncrement($table, $index=1){
			return $this->query("ALTER TABLE $table AUTO_INCREMENT=$index");
		}

		function setInsertId($index){
			return $this->query("SET insert_id=$index");
		}
	}
	
?>
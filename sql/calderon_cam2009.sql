/*
SQLyog Enterprise - MySQL GUI v8.05 
MySQL - 5.1.33-community : Database - calderon_schooladmin
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`calderon_schooladmin` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `calderon_schooladmin`;

/*Table structure for table `account` */

DROP TABLE IF EXISTS `account`;

CREATE TABLE `account` (
  `accountId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `selectedBillingAddressId` int(10) unsigned DEFAULT NULL,
  `selectedBillingEmailContactId` int(10) unsigned DEFAULT NULL,
  `currentBalance` decimal(8,2) DEFAULT '0.00',
  `lastPaymentDate` datetime DEFAULT NULL,
  `notes` text,
  `updateTime` timestamp NULL DEFAULT NULL,
  `updateBy` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`accountId`),
  KEY `FK_account_addressId` (`selectedBillingAddressId`),
  KEY `FK_account_contactId` (`selectedBillingEmailContactId`),
  KEY `FK_account_personId` (`updateBy`),
  CONSTRAINT `FK_account_addressId` FOREIGN KEY (`selectedBillingAddressId`) REFERENCES `address` (`addressId`) ON DELETE CASCADE,
  CONSTRAINT `FK_account_contactId` FOREIGN KEY (`selectedBillingEmailContactId`) REFERENCES `contact` (`contactId`) ON DELETE CASCADE,
  CONSTRAINT `FK_account_personId` FOREIGN KEY (`updateBy`) REFERENCES `person` (`personId`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `account` */

insert  into `account`(`accountId`,`selectedBillingAddressId`,`selectedBillingEmailContactId`,`currentBalance`,`lastPaymentDate`,`notes`,`updateTime`,`updateBy`) values (1,1,3,'45.00','2009-07-26 01:10:31',NULL,'2009-07-26 01:10:46',1);

/*Table structure for table `accountlinks` */

DROP TABLE IF EXISTS `accountlinks`;

CREATE TABLE `accountlinks` (
  `accountId` int(10) unsigned NOT NULL,
  `personId` int(10) unsigned NOT NULL,
  `relation` enum('self','father','mother','guardian','emergency') DEFAULT 'self',
  `primary` tinyint(1) NOT NULL DEFAULT '1',
  UNIQUE KEY `accountId_personId` (`accountId`,`personId`),
  KEY `FK_accountlinks_personId` (`personId`),
  CONSTRAINT `FK_accountlinks_accountId` FOREIGN KEY (`accountId`) REFERENCES `account` (`accountId`) ON DELETE CASCADE,
  CONSTRAINT `FK_accountlinks_personId` FOREIGN KEY (`personId`) REFERENCES `person` (`personId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `accountlinks` */

insert  into `accountlinks`(`accountId`,`personId`,`relation`,`primary`) values (1,1,'father',1),(1,10,'self',0);

/*Table structure for table `address` */

DROP TABLE IF EXISTS `address`;

CREATE TABLE `address` (
  `addressId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `priority` enum('residence','office','secondary','inactive') DEFAULT 'residence',
  `address1` varchar(50) DEFAULT NULL,
  `address2` varchar(50) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  `stateProvince` varchar(20) DEFAULT 'CA',
  `postalCode` varchar(15) DEFAULT NULL,
  `country` varchar(30) DEFAULT 'USA',
  `inactiveAsOfDate` date NOT NULL DEFAULT '0000-00-00',
  `notes` text,
  `createdTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedTime` timestamp NULL DEFAULT NULL,
  `updatedBy` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`addressId`),
  KEY `linkToTable` (`priority`),
  KEY `FK_address_personId` (`updatedBy`),
  CONSTRAINT `FK_address_personId` FOREIGN KEY (`updatedBy`) REFERENCES `person` (`personId`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `address` */

insert  into `address`(`addressId`,`priority`,`address1`,`address2`,`city`,`stateProvince`,`postalCode`,`country`,`inactiveAsOfDate`,`notes`,`createdTime`,`updatedTime`,`updatedBy`) values (1,'residence','333 N. Rengstorff Ave. #20',NULL,'Mountain View','CA','94043','USA','0000-00-00',NULL,'2009-07-17 02:08:48',NULL,NULL),(2,'office','1054 S De Anza Blvd 108',NULL,'San Jose','CA','95129','USA','0000-00-00',NULL,'2009-07-27 01:34:52',NULL,NULL),(3,'residence','7690 Santa Barbara Drive',NULL,'Gilroy','CA','95020','USA','0000-00-00',NULL,'2009-07-27 01:40:11',NULL,NULL);

/*Table structure for table `addresscontact` */

DROP TABLE IF EXISTS `addresscontact`;

CREATE TABLE `addresscontact` (
  `personId` int(10) unsigned NOT NULL,
  `addressId` int(10) unsigned DEFAULT NULL,
  `contactId` int(10) unsigned DEFAULT NULL,
  KEY `FK_addresscontact_contactId` (`contactId`),
  KEY `FK_addresscontact_addressId` (`addressId`),
  CONSTRAINT `FK_addresscontact_addressId` FOREIGN KEY (`addressId`) REFERENCES `address` (`addressId`) ON DELETE NO ACTION,
  CONSTRAINT `FK_addresscontact_contactId` FOREIGN KEY (`contactId`) REFERENCES `contact` (`contactId`) ON DELETE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `addresscontact` */

insert  into `addresscontact`(`personId`,`addressId`,`contactId`) values (10,1,1),(1,1,1),(1,NULL,2),(1,NULL,3),(1,NULL,4),(1,NULL,5),(2,2,NULL),(2,NULL,6),(2,NULL,8),(2,NULL,9),(2,NULL,10),(2,NULL,11),(2,3,NULL),(2,NULL,12);

/*Table structure for table `attendance` */

DROP TABLE IF EXISTS `attendance`;

CREATE TABLE `attendance` (
  `attendanceId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studentId` int(10) unsigned NOT NULL,
  `loginTime` timestamp NULL DEFAULT NULL,
  `logoutTime` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`attendanceId`),
  UNIQUE KEY `loginTime` (`studentId`,`loginTime`),
  CONSTRAINT `FK_studentId_attendance` FOREIGN KEY (`studentId`) REFERENCES `student` (`studentId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `attendance` */

/*Table structure for table `availablelessons` */

DROP TABLE IF EXISTS `availablelessons`;

CREATE TABLE `availablelessons` (
  `employeeId` int(10) unsigned NOT NULL,
  `lessonTypeId` int(10) unsigned NOT NULL,
  `tuitionTypeId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`employeeId`,`lessonTypeId`,`tuitionTypeId`),
  CONSTRAINT `FK_employeeId_availablelessons` FOREIGN KEY (`employeeId`) REFERENCES `employee` (`employeeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `availablelessons` */

insert  into `availablelessons`(`employeeId`,`lessonTypeId`,`tuitionTypeId`) values (1,1,1),(1,1,2),(1,1,3),(2,2,8),(2,2,9),(2,2,10),(3,4,4),(3,4,5),(3,4,6),(3,4,7);

/*Table structure for table `contact` */

DROP TABLE IF EXISTS `contact`;

CREATE TABLE `contact` (
  `contactId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('email','cell','phone','pager','fax') NOT NULL DEFAULT 'phone',
  `category` enum('business','home','personal','other') NOT NULL DEFAULT 'home',
  `entry` varchar(80) DEFAULT NULL,
  `available` enum('always','daytime','evenings','messageOnly') NOT NULL DEFAULT 'always',
  `inactiveAsOfDate` date NOT NULL DEFAULT '0000-00-00',
  `notes` text,
  `createdTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedTime` timestamp NULL DEFAULT NULL,
  `updatedBy` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`contactId`),
  KEY `linkToTable` (`type`),
  KEY `FK_contact_personId` (`updatedBy`),
  CONSTRAINT `FK_contact_personId` FOREIGN KEY (`updatedBy`) REFERENCES `person` (`personId`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

/*Data for the table `contact` */

insert  into `contact`(`contactId`,`type`,`category`,`entry`,`available`,`inactiveAsOfDate`,`notes`,`createdTime`,`updatedTime`,`updatedBy`) values (1,'phone','home','650-254-0510','always','0000-00-00',NULL,'2009-07-17 02:17:35',NULL,NULL),(2,'cell','personal','408-750-7666','always','0000-00-00',NULL,'2009-07-17 02:18:07',NULL,NULL),(3,'email','personal','dgofman@gmail.com','always','0000-00-00',NULL,'2009-07-26 02:41:36',NULL,NULL),(4,'fax','business','650-254-0510','always','0000-00-00',NULL,'2009-07-26 14:17:01',NULL,NULL),(5,'pager','other','11111','always','0000-00-00',NULL,'2009-07-26 14:17:06',NULL,NULL),(6,'cell','personal','408-394-3355','always','0000-00-00',NULL,'2009-07-27 01:35:41',NULL,NULL),(7,'cell','personal','408-394-7755','always','0000-00-00',NULL,'2009-07-27 01:35:58',NULL,NULL),(8,'phone','business','408-777-8779','always','0000-00-00',NULL,'2009-07-27 01:36:08',NULL,NULL),(9,'email','business','ludwig@calderacademy.com','always','0000-00-00',NULL,'2009-07-27 01:38:07',NULL,NULL),(10,'email','business','ludwig@calderoneworld.org','always','0000-00-00',NULL,'2009-07-27 01:38:19',NULL,NULL),(11,'email','personal','lcalder@yahoo.com','always','0000-00-00',NULL,'2009-07-27 01:38:32',NULL,NULL),(12,'email','other','orders@calderacademy.com','always','0000-00-00',NULL,'2009-07-27 01:42:18',NULL,NULL);

/*Table structure for table `employee` */

DROP TABLE IF EXISTS `employee`;

CREATE TABLE `employee` (
  `employeeId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `personId` int(10) unsigned DEFAULT NULL,
  `startDate` date DEFAULT NULL,
  `endDate` date DEFAULT NULL,
  `taxId` varchar(14) NOT NULL,
  PRIMARY KEY (`employeeId`),
  KEY `FK_employee_personId` (`personId`),
  CONSTRAINT `FK_employee_personId` FOREIGN KEY (`personId`) REFERENCES `person` (`personId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `employee` */

insert  into `employee`(`employeeId`,`personId`,`startDate`,`endDate`,`taxId`) values (1,2,'2009-01-01',NULL,'967-57-7938'),(2,11,'2009-01-01',NULL,'888-77-7777'),(3,12,'2009-01-01',NULL,'none');

/*Table structure for table `employeepay` */

DROP TABLE IF EXISTS `employeepay`;

CREATE TABLE `employeepay` (
  `employeePayId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `employeeId` int(10) unsigned DEFAULT NULL,
  `payPeriod` char(6) DEFAULT NULL,
  `currentHourlyRate` decimal(8,2) DEFAULT NULL,
  `currentHours` decimal(8,2) DEFAULT NULL,
  `adjustmentAmount` decimal(8,2) DEFAULT NULL,
  `adjustmentSign` enum('credit','debit') DEFAULT NULL,
  `totalAmount` decimal(8,2) DEFAULT NULL,
  `paidDate` date DEFAULT '0000-00-00',
  `note` text,
  PRIMARY KEY (`employeePayId`),
  UNIQUE KEY `employeeId` (`employeeId`,`payPeriod`),
  CONSTRAINT `FK_employeeId` FOREIGN KEY (`employeeId`) REFERENCES `employee` (`employeeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `employeepay` */

/*Table structure for table `historysummary` */

DROP TABLE IF EXISTS `historysummary`;

CREATE TABLE `historysummary` (
  `historySummaryId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studentId` int(10) unsigned DEFAULT NULL,
  `employeeId` int(10) unsigned DEFAULT NULL,
  `lessonTypeId` int(10) unsigned DEFAULT NULL,
  `period` char(6) DEFAULT NULL,
  `amountDue` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`historySummaryId`),
  KEY `student` (`studentId`,`period`,`lessonTypeId`),
  KEY `employee` (`employeeId`,`period`,`lessonTypeId`),
  CONSTRAINT `FK_studentId_historysummary` FOREIGN KEY (`studentId`) REFERENCES `student` (`studentId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `historysummary` */

/*Table structure for table `lessoncontrol` */

DROP TABLE IF EXISTS `lessoncontrol`;

CREATE TABLE `lessoncontrol` (
  `lessonControlId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `employeeId` int(10) unsigned NOT NULL,
  `studentId` int(10) unsigned NOT NULL,
  `lessonTypeId` int(10) unsigned NOT NULL,
  `tuitionTypeId` int(10) unsigned NOT NULL,
  `length` decimal(3,0) DEFAULT NULL,
  `rate` decimal(8,2) DEFAULT NULL,
  `options` enum('none','tuition exempt','tuition override') DEFAULT 'none',
  `note` text,
  PRIMARY KEY (`lessonControlId`),
  KEY `FK_studentId` (`studentId`),
  KEY `FK_tuitionTypeId` (`tuitionTypeId`),
  CONSTRAINT `FK_studentId_lessoncontrol` FOREIGN KEY (`studentId`) REFERENCES `student` (`studentId`) ON DELETE CASCADE,
  CONSTRAINT `FK_tuitionTypeId_lessoncontrol` FOREIGN KEY (`tuitionTypeId`) REFERENCES `tuitiontype` (`tuitionTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `lessoncontrol` */

insert  into `lessoncontrol`(`lessonControlId`,`employeeId`,`studentId`,`lessonTypeId`,`tuitionTypeId`,`length`,`rate`,`options`,`note`) values (3,1,2,1,1,'30','50.00','none',NULL),(4,3,2,4,5,'0','360.00','none',NULL);

/*Table structure for table `lessonhistory` */

DROP TABLE IF EXISTS `lessonhistory`;

CREATE TABLE `lessonhistory` (
  `lessonHistoryId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studentId` int(10) unsigned NOT NULL DEFAULT '0',
  `employeeId` int(10) unsigned NOT NULL DEFAULT '0',
  `lessonTypeId` int(10) unsigned NOT NULL DEFAULT '0',
  `date` date DEFAULT '0000-00-00',
  `startTime` time DEFAULT '00:00:00',
  `length` decimal(3,0) DEFAULT NULL,
  `rate` decimal(8,2) DEFAULT NULL,
  `options` enum('none','fee waived','fee override') NOT NULL DEFAULT 'none',
  `disposition` enum('lesson taken','missed - but still charged','missed by student - not charged','missed by teacher - not charged') NOT NULL DEFAULT 'lesson taken',
  `notes` text NOT NULL,
  PRIMARY KEY (`lessonHistoryId`),
  KEY `employee` (`employeeId`,`lessonTypeId`,`date`),
  KEY `student` (`studentId`,`employeeId`,`lessonTypeId`,`date`),
  KEY `lessonTypeId` (`lessonTypeId`),
  CONSTRAINT `FK_studentId_lessonhistory` FOREIGN KEY (`studentId`) REFERENCES `student` (`studentId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `lessonhistory` */

/*Table structure for table `lessonschedule` */

DROP TABLE IF EXISTS `lessonschedule`;

CREATE TABLE `lessonschedule` (
  `scheduleId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `refScheduleId` int(10) unsigned DEFAULT NULL,
  `lessoncontrolId` int(10) unsigned NOT NULL,
  `startDate` date DEFAULT '0000-00-00',
  `endDate` date DEFAULT NULL,
  `smtwtfs` varchar(7) DEFAULT '0000000',
  `startTime` time DEFAULT '00:00:00',
  `options` enum('none','fee waived','fee override') NOT NULL DEFAULT 'none',
  `disposition` enum('lesson taken','missed - but still charged','missed by student - not charged','missed by teacher - not charged') NOT NULL DEFAULT 'lesson taken',
  `note` text,
  PRIMARY KEY (`scheduleId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `lessonschedule` */

insert  into `lessonschedule`(`scheduleId`,`refScheduleId`,`lessoncontrolId`,`startDate`,`endDate`,`smtwtfs`,`startTime`,`options`,`disposition`,`note`) values (1,NULL,1,'2009-01-01',NULL,'0001000','19:00:00','none','lesson taken',NULL),(2,NULL,2,'2009-07-05',NULL,'1000000','15:30:00','none','lesson taken',NULL),(3,NULL,3,'2009-01-01',NULL,'0001000','19:30:00','none','lesson taken',NULL),(4,NULL,4,'2009-03-01',NULL,'0110110','00:00:00','none','lesson taken',NULL);

/*Table structure for table `lessontype` */

DROP TABLE IF EXISTS `lessontype`;

CREATE TABLE `lessontype` (
  `lessonTypeId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category` enum('academic','afterschool','dance','music','course','seasonal camp','special activity','items','fees','other') NOT NULL,
  `lesson` varchar(30) DEFAULT NULL,
  `type` enum('individual','group','n/a') NOT NULL,
  PRIMARY KEY (`lessonTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `lessontype` */

insert  into `lessontype`(`lessonTypeId`,`category`,`lesson`,`type`) values (1,'music','piano','individual'),(2,'music','violin','individual'),(3,'dance','ballet','group'),(4,'other','afterschool','group');

/*Table structure for table `locale` */

DROP TABLE IF EXISTS `locale`;

CREATE TABLE `locale` (
  `localeName` char(5) NOT NULL,
  `language` varchar(100) NOT NULL,
  PRIMARY KEY (`localeName`),
  UNIQUE KEY `SHORT_NAME` (`localeName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `locale` */

insert  into `locale`(`localeName`,`language`) values ('ar_AE','United Arab Emirates/Arabic'),('ar_BH','Bahrain/Arabic'),('ar_DZ','Algeria/Arabic'),('ar_EG','Egypt/Arabic'),('ar_IQ','Iraq/Arabic'),('ar_JO','Jordan/Arabic'),('ar_KW','Kuwait/Arabic'),('ar_LB','Lebanon/Arabic'),('ar_LY','Libya/Arabic'),('ar_MA','Morocco/Arabic'),('ar_OM','Oman/Arabic'),('ar_QA','Qatar/Arabic'),('ar_SA','Saudi Arabia/Arabic'),('ar_SD','Sudan/Arabic'),('ar_SY','Syria/Arabic'),('ar_TN','Tunisia/Arabic'),('ar_YE','Yemen/Arabic'),('be_BY','Belarus/Belarusian'),('bg_BG','Bulgaria/Bulgarian'),('ca_ES','Spain/Catalan'),('cs_CZ','Czech Republic/Czech'),('da_DK','Denmark/Danish'),('de_AT','Austria/German'),('de_CH','Switzerland/German'),('de_DE','Germany/German'),('de_LU','Luxembourg/German'),('el_GR','Greece/Greek'),('en_AU','Australia/English'),('en_CA','Canada/English'),('en_GB','United Kingdom/English'),('en_IE','Ireland/English'),('en_IN','India/English'),('en_NZ','New Zealand/English'),('en_US','United States/English'),('en_ZA','South Africa/English'),('es_AR','Argentina/Spanish'),('es_BO','Bolivia/Spanish'),('es_CL','Chile/Spanish'),('es_CO','Colombia/Spanish'),('es_CR','Costa Rica/Spanish'),('es_DO','Dominican Republic/Spanish'),('es_EC','Ecuador/Spanish'),('es_ES','Spain/Spanish'),('es_GT','Guatemala/Spanish'),('es_HN','Honduras/Spanish'),('es_MX','Mexico/Spanish'),('es_NI','Nicaragua/Spanish'),('es_PA','Panama/Spanish'),('es_PE','Peru/Spanish'),('es_PR','Puerto Rico/Spanish'),('es_PY','Paraguay/Spanish'),('es_SV','El Salvador/Spanish'),('es_UY','Uruguay/Spanish'),('es_VE','Venezuela/Spanish'),('et_EE','Estonia/Estonian'),('fi_FI','Finland/Finnish'),('fr_BE','Belgium/French'),('fr_CA','Canada/French'),('fr_CH','Switzerland/French'),('fr_FR','France/French'),('fr_LU','Luxembourg/French'),('hr_HR','Croatia/Croatian'),('hu_HU','Hungary/Hungarian'),('is_IS','Iceland/Icelandic'),('it_CH','Switzerland/Italian'),('it_IT','Italy/Italian'),('iw_IL','Israel/Hebrew'),('ja_JP','Japan/Japanese'),('ko_KR','South Korea/Korean'),('lt_LT','Lithuania/Lithuanian'),('lv_LV','Latvia/Latvian'),('mk_MK','Macedonia/Macedonian'),('nl_BE','Belgium/Dutch'),('nl_NL','Netherlands/Dutch'),('no_NO','Norway/Norwegian'),('pl_PL','Poland/Polish'),('pt_BR','Brazil/Portuguese'),('pt_PT','Portugal/Portuguese'),('ro_RO','Romania/Romanian'),('ru_RU','Russia/Russian'),('sk_SK','Slovakia/Slovak'),('sl_SI','Slovenia/Slovenian'),('sq_AL','Albania/Albanian'),('sv_SE','Sweden/Swedish'),('th_TH','Thailand/Thai'),('tr_TR','Turkey/Turkish'),('uk_UA','Ukraine/Ukrainian'),('vi_VN','Vietnam/Vietnamese'),('zh_CN','China/Chinese'),('zh_HK','Hong Kong/Chinese'),('zh_TW','Taiwan/Chinese');

/*Table structure for table `login` */

DROP TABLE IF EXISTS `login`;

CREATE TABLE `login` (
  `username` varchar(40) NOT NULL,
  `loginDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `success` tinyint(1) NOT NULL,
  PRIMARY KEY (`username`,`loginDate`),
  CONSTRAINT `FK_username_login` FOREIGN KEY (`username`) REFERENCES `user` (`username`) ON DELETE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `login` */

/*Table structure for table `messages` */

DROP TABLE IF EXISTS `messages`;

CREATE TABLE `messages` (
  `messageId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `priority` enum('high','medium','low') NOT NULL DEFAULT 'high',
  `status` enum('read','unread','delete') NOT NULL DEFAULT 'unread',
  `type` enum('notice','news','todo') NOT NULL DEFAULT 'notice',
  `userId` int(10) unsigned NOT NULL,
  `subject` varchar(250) NOT NULL,
  `body` text,
  `createdTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedTime` timestamp NULL DEFAULT NULL,
  `updatedBy` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`messageId`,`userId`),
  KEY `linkToTable` (`priority`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

/*Data for the table `messages` */

insert  into `messages`(`messageId`,`priority`,`status`,`type`,`userId`,`subject`,`body`,`createdTime`,`updatedTime`,`updatedBy`) values (18,'high','delete','notice',1,'Notice_Subject1','Notice_Message1','2009-05-13 22:10:34','2009-07-26 23:37:23',2),(19,'low','delete','notice',1,'Notice_Subject2','this has been changed by mohammad','2009-05-13 22:16:57','2009-07-26 23:37:23',2),(20,'high','delete','news',1,'New_Subject1','New_Body1','2009-05-13 22:33:02','2009-07-26 23:37:34',2),(21,'medium','delete','news',1,'New_Subject2','New_Body2','2009-05-13 22:58:09','2009-07-26 23:37:34',2),(22,'low','read','todo',1,'TODO_Subject1','ToDo_Body1','2009-05-13 22:59:28','2009-05-14 00:12:57',1),(23,'low','read','todo',1,'TODO_Subject2','ToDo_Subject2','2009-05-13 23:01:39','2009-05-14 00:12:46',1),(24,'high','read','todo',6,'Mohammad needs to finish his project','ASAP!','2009-05-15 23:21:54',NULL,NULL),(25,'low','delete','news',2,'kljhjhkjhjhkljhkjhklj','yutgyugiytfiygviyviyviyviyviuyviv','2009-05-16 00:59:15','2009-07-26 23:37:33',2),(26,'low','delete','notice',1,'Subject Notice 1','Body Notice 1','2009-05-17 16:11:31','2009-07-26 23:37:23',2),(27,'low','delete','news',1,'Subject News 1','Body News 1','2009-05-17 16:12:07','2009-07-26 23:37:33',2),(28,'low','delete','notice',1,'Subjec Notice 2','Body Notice 2','2009-05-17 17:11:01','2009-07-26 23:37:23',2);

/*Table structure for table `payment` */

DROP TABLE IF EXISTS `payment`;

CREATE TABLE `payment` (
  `paymentId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bankDepositDate` datetime DEFAULT NULL,
  `payerPersonId` int(10) unsigned DEFAULT NULL,
  `amount` decimal(8,2) DEFAULT NULL,
  `date` date DEFAULT '0000-00-00',
  `checkNumber` char(20) DEFAULT NULL,
  `returnedFee` decimal(8,2) DEFAULT NULL,
  `cashReceivedByUserId` int(10) unsigned DEFAULT NULL,
  `creditCard` char(30) DEFAULT NULL,
  `expiryDate` char(6) DEFAULT NULL,
  PRIMARY KEY (`paymentId`),
  UNIQUE KEY `bankDepositDate` (`bankDepositDate`,`paymentId`),
  KEY `cashReceivedByUserId` (`cashReceivedByUserId`),
  KEY `checkNumber` (`checkNumber`,`payerPersonId`),
  KEY `payerPersonId` (`payerPersonId`,`checkNumber`),
  KEY `date` (`date`,`checkNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `payment` */

/*Table structure for table `paymentapply` */

DROP TABLE IF EXISTS `paymentapply`;

CREATE TABLE `paymentapply` (
  `paymentApplyId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `paymentId` int(10) unsigned DEFAULT NULL,
  `appliedAmount` decimal(8,2) DEFAULT NULL,
  `appliedToHistorySummary` int(10) unsigned DEFAULT NULL,
  `appliedToOtherTransaction` char(30) DEFAULT NULL,
  PRIMARY KEY (`paymentApplyId`),
  KEY `paymentId` (`paymentId`),
  KEY `appliedToHistorySummary` (`appliedToHistorySummary`),
  CONSTRAINT `FK_paymentId` FOREIGN KEY (`paymentId`) REFERENCES `payment` (`paymentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `paymentapply` */

/*Table structure for table `permissions` */

DROP TABLE IF EXISTS `permissions`;

CREATE TABLE `permissions` (
  `userId` int(10) unsigned NOT NULL,
  `table` enum('user','permissions','employee','employeepay','administrative tables','account','lessoncontrol','payment','paymentapply','attendance') NOT NULL DEFAULT 'account',
  `particularTableId` int(10) unsigned NOT NULL DEFAULT '0',
  `privileges` enum('0-CRUD+override','1-CRUD','2-CRU','3-RU','4-R') DEFAULT '4-R',
  `privilegeLevel` enum('high','low') DEFAULT 'low',
  PRIMARY KEY (`userId`,`table`,`particularTableId`),
  CONSTRAINT `FK_userId` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `permissions` */

/*Table structure for table `person` */

DROP TABLE IF EXISTS `person`;

CREATE TABLE `person` (
  `personId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `first` varchar(30) NOT NULL,
  `last` varchar(30) NOT NULL,
  `firstMetaPhone` varchar(10) DEFAULT NULL,
  `lastMetaPhone` varchar(10) DEFAULT NULL,
  `localeName` char(5) NOT NULL DEFAULT 'en_US',
  `sex` enum('male','female') DEFAULT 'male',
  `dateOfBirth` date DEFAULT '0000-00-00',
  `notes` text,
  PRIMARY KEY (`personId`),
  KEY `firstMeta` (`firstMetaPhone`,`lastMetaPhone`),
  KEY `lastMeta` (`lastMetaPhone`,`firstMetaPhone`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

/*Data for the table `person` */

insert  into `person`(`personId`,`first`,`last`,`firstMetaPhone`,`lastMetaPhone`,`localeName`,`sex`,`dateOfBirth`,`notes`) values (1,'First1','Last2',NULL,NULL,'ru_RU','male','1975-01-25',''),(2,'First2','Last2',NULL,NULL,'en_US','male','1967-05-16',NULL),(7,'First3','Last3',NULL,NULL,'ar_AE','female','1974-02-17',NULL),(10,'First4','Last4',NULL,NULL,'en_US','female','1976-05-07',NULL),(11,'First5','Last5',NULL,NULL,'en_US','male','1975-01-01',''),(12,'Afterschool','Teacher',NULL,NULL,'en_US','male','0000-00-00','');

/*Table structure for table `student` */

DROP TABLE IF EXISTS `student`;

CREATE TABLE `student` (
  `studentId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `personId` int(10) unsigned NOT NULL,
  `accountId` int(10) unsigned NOT NULL,
  `enrollDate` date DEFAULT '0000-00-00',
  `studentType` enum('child','adult') DEFAULT NULL,
  `medication` varchar(30) DEFAULT NULL,
  `allergies` varchar(30) DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`studentId`),
  UNIQUE KEY `personId` (`personId`),
  KEY `FK_student_accountId` (`accountId`),
  CONSTRAINT `FK_student_accountId` FOREIGN KEY (`accountId`) REFERENCES `account` (`accountId`) ON DELETE CASCADE,
  CONSTRAINT `FK_student_personId` FOREIGN KEY (`personId`) REFERENCES `person` (`personId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `student` */

insert  into `student`(`studentId`,`personId`,`accountId`,`enrollDate`,`studentType`,`medication`,`allergies`,`notes`) values (2,10,1,'0000-00-00','child',NULL,NULL,NULL);

/*Table structure for table `transactionlog` */

DROP TABLE IF EXISTS `transactionlog`;

CREATE TABLE `transactionlog` (
  `transactionLogId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tableName` varchar(40) NOT NULL,
  `tableRowId` int(10) unsigned NOT NULL,
  `createdTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedTime` timestamp NULL DEFAULT NULL,
  `updatedBy` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`transactionLogId`),
  UNIQUE KEY `tableName` (`tableName`,`tableRowId`,`transactionLogId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `transactionlog` */

/*Table structure for table `tuitiontype` */

DROP TABLE IF EXISTS `tuitiontype`;

CREATE TABLE `tuitiontype` (
  `tuitionTypeId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `duration` char(30) DEFAULT NULL,
  `rate` decimal(8,2) DEFAULT NULL,
  `length` char(4) DEFAULT NULL,
  `billingInterval` enum('per lesson','per lesson/monthly','per month','per lesson/quarterly','quarterly','per course/semester','annually') DEFAULT 'per lesson/monthly',
  `calculateNumberOfLessons` int(10) DEFAULT NULL,
  PRIMARY KEY (`tuitionTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

/*Data for the table `tuitiontype` */

insert  into `tuitiontype`(`tuitionTypeId`,`duration`,`rate`,`length`,`billingInterval`,`calculateNumberOfLessons`) values (1,'45-minutes','70.00','45','per lesson/monthly',0),(2,'30 minutes','50.00','30','per lesson/monthly',0),(3,'60 minutes','90.00','60','per lesson/monthly',16),(4,'5-days','400.00','0','per course/semester',0),(5,'4-days','360.00','0','per course/semester',0),(6,'3-days','320.00','0','per course/semester',0),(7,'2-days','300.00','0','per course/semester',0),(8,'60-min','65.00','60','per lesson/monthly',0),(9,'45-min','55.00','45','per lesson/monthly',0),(10,'30-min','40.00','30','per lesson/monthly',0);

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `userId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `personId` int(10) unsigned NOT NULL,
  `username` varchar(40) NOT NULL,
  `password` varchar(64) NOT NULL,
  `privileges` enum('crudo','crud','cru','ru','r') DEFAULT 'r',
  `status` enum('active','inactive','disable','pending') NOT NULL DEFAULT 'pending',
  `admin` tinyint(1) DEFAULT '0',
  `notes` text,
  PRIMARY KEY (`userId`),
  UNIQUE KEY `username` (`username`),
  KEY `FK_user` (`personId`),
  CONSTRAINT `FK_user` FOREIGN KEY (`personId`) REFERENCES `person` (`personId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `user` */

insert  into `user`(`userId`,`personId`,`username`,`password`,`privileges`,`status`,`admin`,`notes`) values (1,1,'username1','*6BB4837EB74329105EE4568DDA7DC67ED2CA2AD9','ru','active',1,NULL),(2,2,'username2','*6BB4837EB74329105EE4568DDA7DC67ED2CA2AD9','crudo','active',1,NULL),(6,7,'username3','*6BB4837EB74329105EE4568DDA7DC67ED2CA2AD9','r','disable',0,NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;

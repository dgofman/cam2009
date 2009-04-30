package com.academy.calder.business
{
	import com.academy.calder.model.UserAccount;
	
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.formatters.DateFormatter;
	import mx.rpc.events.FaultEvent;
	import mx.utils.StringUtil;
	
	public class Manager{
		
		private static var instance:Manager;
		
		private var _userAccount:UserAccount;
		
		public static const bundle:ResourceBundle = new ResourceBundle();

		public static function getInstance():Manager{
			if(!instance)
				instance = new Manager();
			return instance;
		}
		
		[Bindable]
		public function get userAccount():UserAccount{
			return _userAccount;
		}
		public function set userAccount(account:UserAccount):void{
			_userAccount = account;
		}
		
		public static function get application():CAM{
			return Application.application as CAM;
		}
		
		public static function getIcon(icon:String):Class{
			return application.getStyle(icon);
		}
		
		public static function formatTime(date:Date):String{
			var timeFormatter:DateFormatter = new DateFormatter();
			timeFormatter.formatString = getProperty("timeFormat");
			if(timeFormatter.formatString == null)
				timeFormatter.formatString = "L:NN A";
			return timeFormatter.format(date);
		}
		
		public static function formatDate(date:Date):String{
			var dateFormatter:DateFormatter = new DateFormatter();
			dateFormatter.formatString = getProperty("dateFormat");
			if(dateFormatter.formatString == null)
				dateFormatter.formatString = "MM/DD/YYYY";
			return dateFormatter.format(date);
		}
		
		public static function formatOutputDate(date:Date):String{
			var dateFormatter:DateFormatter = new DateFormatter();
			dateFormatter.formatString = "YYYY-MM-DD";
			return dateFormatter.format(date);
		}
		
		public static function getE4X(keys:Array, values:Array):XMLList{
			var list:XMLList = <></>;
			for(var r:int = 0; r < values.length; r++){
				var xml:XML = new XML("<r id='" + r + "'></r>");
				for(var i:int = 0; i < keys.length; i++){
					xml.appendChild(StringUtil.substitute("<{0}><![CDATA[{1}]]></{0}>",  [keys[i], values[r][i]]));
				}
				list += xml;
			}
			return list;
		}
		
		public static function getAppParam(key:String, defaultValue:String=null):String{
			if(Manager.application.parameters == null)
				return defaultValue;
			var value:String = application.parameters[key];
			return (value != null) ? value : defaultValue;
		}
		
		public static function getProperty(key:String):String{
		    return bundle[key];
		}
		
		public static function error(msg:String, title:String="Internal Server Error"):void{
			Alert.show(msg, title);
		}
		
		/*[Bindable]
		public var userInfo:Object;
		
		[Bindable]
		public var studentListData:Object;
		
		public static var selectedUserId:Number;
		public static var selectedUserRowIndex:Number;
		
		//User type
		public static var GUEST:Number     = 1;
		public static var EMPLOYEE:Number  = 2;
		public static var STUDENT:Number   = 3;
	
		public static var LOGIN_VIEW:Number        = 0;
		public static var SIGNUP_VIEW:Number       = 1;
		public static var CONFIRM_VIEW:Number      = 2;
		public static var FORGOT_VIEW:Number       = 3;
		public static var RESET_VIEW:Number        = 4;
		public static var ADMIN_VIEW:Number        = 5;
		public static var GUEST_VIEW:Number        = 6;
		public static var STUDENT_VIEW:Number      = 7;
		public static var TEACHER_VIEW:Number      = 8;
		public static var SIGNOUT_VIEW:Number      = 9;
	
		public static var SIGNUP_ACCOUNT_VIEW:Number  = 0;
		public static var SIGNUP_ACCESS_VIEW:Number   = 1;
		public static var SIGNUP_CONFIRM_VIEW:Number  = 2;
		
		public static var ADMIN_HOME_VIEW:Number      = 0;
		public static var ADMIN_MEMBER_VIEW:Number    = 1;
		public static var ADMIN_STUDENT_VIEW:Number   = 2;
		public static var ADMIN_TEACHER_VIEW:Number   = 3;
			
		public static var NOTICE_URL:String = "http://www.calderacademy.com/flex.php?id=notice";
		public static var NEWS_URL:String  = "http://www.calderacademy.com/flex.php?id=news";
		public static var TODO_URL:String  = "http://www.calderacademy.com/flex.php?id=todo";
		public static var HELP_URL:String  = "http://www.calderacademy.com/flex.php?id=started";
		
		public static var MONTHS:Array = new Array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
		public static var DAYS:Array = new Array("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday");
		public static var SHORT_DAYS:Array = new Array("Sun.", "Mon.", "Tue.", "Wed.", "Thu.", "Fri.", "Sat.");
		
		public static var TUITION_OPTIONS:Array = [{label:"none", data:1}, {label:"tuition exempt", data:2}, {label:"tuition override", data:3}];
																								
		public static function getMonthDays(year:Number):Array{
			return [31, 28 + (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
		}
				
		private function Manager(){
			userInfo = new Object();
			studentListData = new Object();
		}
		
		public static function getInstance():Manager{
			if(!instance)
				instance = new Manager();
			return instance;
		}
		
		public static function getTypeId():Number{
			return getUserInfo().typeId;
		}
		
		public static function getStatus():Number{
			return getUserInfo().status;
		}
		
		public static function isAdmin():Boolean{
			return (Number(getUserInfo().admin) == 1);
		}
		
		public static function getUserInfo():Object{
			return getInstance().userInfo;
		}
		
		public static function updateUserInfo(record:Object, username:String, remember:Boolean):Void{
			var userInfo:Object = getUserInfo();
			userInfo.userId = record.userId;
			userInfo.first  = record.first; 
			userInfo.typeId = record.typeId;
			userInfo.admin  = record.admin;
			userInfo.status = record.status;
	
			var so:SharedObject = SharedObject.getLocal("calderUserData", "/");
			so.data.remember = remember;
			so.data.username = ((remember) ? username : null);
			so.flush();
			so.close();
		}
		
		public static function initUserInfo():Void{
			var so:SharedObject = SharedObject.getLocal("calderUserData", "/");
			with(getInstance().userInfo) {
				remember = so.data.remember;
				username = so.data.username;
			};
			so.close();
		}
		
		public static function application:Object{
			return mx.core.Application.application;
		}
		
		public static function alert(msg:Object, title:String, fault:FaultEvent):Void{
			if(fault != undefined){
				trace(fault.fault.faultstring);
			}
			mx.controls.Alert.show(String(msg), title);
		}
		
		public static function trace(msg:Object, _level_:Number):Void{
			Services.trace(msg, _level_);
		}
		
		public static function msg(key:String):String{
			return application.messages[key];
		}
		
		public static function getNumber(value:Number, defValue:Number):Number{
			return Number(getObject(value, defValue));
		}
		
		public static function getObject(value:Object, defValue:Object):Object{
			return ((value == undefined || value == null || value.length == 0) ? defValue : value);
		}
		
		public static function changeMainView(index:Number):Void{
			application.mainView.selectedIndex = index;
		}
		
		public static function changeAdminView(index:Number):Void{
			application.mainView.admin.adminView.selectedIndex = index;
		}
		
		public static function getAdminStudentPanel():Object{
			return application.mainView.admin.adminView.studentView.studentPanel;
		}*/
	}
}
package com.academy.calder.business
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.SharedObject;
	
	import mx.utils.StringUtil;
		
	public class LocalShare
	{
		public static const GLOBAL_LEVEL:uint  = 1;
		public static const USER_LEVEL:uint    = 2;
		
		private static var instance:LocalShare;
		
		private var so:SharedObject;
		
		function LocalShare(){
			so = SharedObject.getLocal("calderacademy");
		}
		
		public static function getInstance():LocalShare{
			if(!instance) instance = new LocalShare();
			return instance;
		}
		
		public static function clear():void{
			getInstance().so.clear();
		}
				
		public static function save(key:String, value:Object, level:int=USER_LEVEL):void{
			var so:SharedObject = getInstance().so;
			if(level == USER_LEVEL){
				var userId:String = getUserId();
				if(!so.data[userId]) so.data[userId] = {};
				so.data[userId][key] = value;
			}else{ //GLOBAL_LEVEL
				so.data[key] = value;
			}
			so.flush();
		}
		
		public static function getValue(key:String, level:int=USER_LEVEL):Object{
			var so:SharedObject = getInstance().so;
			if(level == USER_LEVEL){
				var userId:String = getUserId();
				if(so.data[userId]) 
					return so.data[userId][key];
			}else{
				return so.data[key];
			}
			return null;
		}
		
		private static function getUserId():String{
			if(Manager.instance.currentUser != null)
				return LanguageService.getUserLanguageCode() + '_' + Manager.instance.currentUser.userId;
			else
				return null;
		}
	}
}
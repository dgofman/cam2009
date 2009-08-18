package com.academy.calder.business
{
	import com.academy.calder.helper.MainViewHelper;
	import com.academy.calder.vo.PersonVO;
	import com.academy.calder.vo.UserVO;
	
	import flash.net.URLVariables;
	
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.formatters.DateFormatter;
	
	[Bindable]
	public class Manager{
		
		private static var _instance:Manager;
		private static const DEFAULT_LOCALE:String = "en_US";
		
		private var _localeIndex:uint;
		private var _languages:Array;
		
		private var _currentUser:UserVO;
		private var _cookieParams:URLVariables;
		
		public static const bundle:ResourceBundle = new ResourceBundle();

		public static function get instance():Manager{
			if(!_instance)
				_instance = new Manager();
			return _instance;
		}
		
		public function get localeIndex():uint{
			return _localeIndex;
		}
		public function set localeIndex(value:uint):void{
			_localeIndex = value;
		}
		
		public function get languages():Array{
			return _languages;
		}
		public function set languages(value:Array):void{
			_languages = value;
		}
		
		public function get cookieParams():URLVariables{
			return _cookieParams;
		}
		public function set cookieParams(value:URLVariables):void{
			_cookieParams = value;
		}

		public function get currentUser():UserVO{
			return _currentUser;
		}
		public function set currentUser(value:UserVO):void{
			_currentUser = value;
		}
		
		public static function get application():CAM{
			return Application.application as CAM;
		}
		
		public static function getIcon(icon:String):Class{
			return application.getStyle(icon);
		}
		
		public static function findLocaleIndex(person:PersonVO):void{
			function onLocaleResult(result:Object):void{
				_instance.languages = result as Array;
				findLocaleIndex(person);
			};
			
			if(_instance.languages == null){
				AMFService.send('CAM.locale', null, onLocaleResult);
			}else{
				var name:String = (person && person.localeName) ? person.localeName : DEFAULT_LOCALE;
				for(var i:uint = 0; i < _instance.languages.length; i++){
					if(_instance.languages[i].localeName == name){
						_instance.localeIndex = i;
						if(person != null)
							person.language = _instance.languages[i].language;
						break;
					}
				}
			}
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
		
		public static function signout():void{
			application.mainHelper.changeView(MainViewHelper.SIGNOUT);
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
	}
}
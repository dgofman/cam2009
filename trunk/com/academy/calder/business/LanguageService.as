package com.academy.calder.business
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.controls.Alert;
	import mx.utils.StringUtil;
	
	public class LanguageService
	{		
		public static const DEFAULT_LANGUAGE:String  =  "en_US";
					
		private const MESSAGES:Array = [
				"resources/locale/{0}/labels.txt",
				"resources/locale/{0}/errors.txt",
				"resources/locale/{0}/server.txt",
				"resources/locale/{0}/msg_tooltip.txt"
		];
		
		private static var instance:LanguageService;
				
		private var userLanguageCode:String;
		
		function LanguageService(restricted:Restricted, langCode:String, callBack:Function=null){
			function onLoadDefaultLangugage():void{
				//Load user language
				instance.loadProperties(langCode, callBack);
			};
			//First Load default language
			loadProperties(DEFAULT_LANGUAGE, 
				(langCode == DEFAULT_LANGUAGE) ?  callBack : onLoadDefaultLangugage);
		}
		
		public static function getUserLanguageCode():String{
			if(instance == null)
				throw new Error("Instance not initialized.");
			return instance.userLanguageCode;
		}
		
		public static function switchLanguage(langCode:String, callBack:Function=null):void{
			if(instance == null){
				instance = new LanguageService(new Restricted(), langCode, callBack);
			}else{
				instance.loadProperties(langCode, callBack);
			}
		}
		
		private function loadProperties(langCode:String, callBack:Function):void{
			//Language already loaded
			if(userLanguageCode == langCode){
				callBack();
				return;
			}
			userLanguageCode = langCode;
			function onComplete(event:Event):void {
				var pattern:RegExp = /\r\n|\n/gm;
				var params:String = event.target.data.replace(pattern, "");
				var list:Array = params.split("&");
				for(var i:uint = 0; i < list.length; i++){
					var data:Array = list[i].split("=");
					Manager.bundle[data[0]] = unescape(data[1]);
				}
				clean(event.target);
			};
			function onError(event:IOErrorEvent):void{
				clean(event.target);
			};
			function clean(loader:URLLoader):void{
				for(var i:String in loaders){
					if(loaders[i] == loader){
						loaders.splice(i);
						break;
					}
				};
				loader.removeEventListener(Event.COMPLETE, onComplete);
				loader.removeEventListener(IOErrorEvent.IO_ERROR, onError);
				if(loaders.length == 0){
					Alert.yesLabel = Manager.bundle.getMessage("yes");
					Alert.noLabel  = Manager.bundle.getMessage("no");
					Alert.okLabel  = Manager.bundle.getMessage("ok");
					Alert.cancelLabel  = Manager.bundle.getMessage("cancel");
					Manager.bundle.dispatchEvent(new Event("propertyChange"));
					callBack();
				}
			};
			var i:int;
			var loaders:Array = [];
			//Init properiy file loaders
			for(i = 0; i < MESSAGES.length; i++){
				var loader:URLLoader = new URLLoader();
				loader.addEventListener(Event.COMPLETE, onComplete);
				loader.addEventListener(IOErrorEvent.IO_ERROR, onError);
				loaders.push(loader)
			};
			//Execute
			for(i = MESSAGES.length - 1; i >= 0; i--){
				loaders[i].load(new URLRequest(StringUtil.substitute(MESSAGES[i], langCode)));
			}
		}	
	}
}
class Restricted{};
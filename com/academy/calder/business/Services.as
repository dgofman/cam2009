package com.academy.calder.business
{
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import flash.net.Responder;
	
	import mx.logging.Log;
	import mx.logging.LogEventLevel;
	import mx.logging.targets.TraceTarget;
	import mx.managers.CursorManager;
		
	public class Services
	{	
		private static var GATEWAY_URL:String = "http://localhost/amfphp/gateway.php";
		
		private static var instance:Services = null;
		
		private var gateway:NetConnection;
		private var log:Boolean = true;

		private static function getInstance():Services{
			if(instance == null)
				instance = new Services();
			return instance;
		} 
		
		function Services(){
			if(log == true){
				var logTarget:TraceTarget = new TraceTarget();
		        logTarget.level = LogEventLevel.ALL;
		        logTarget.includeDate = true;
		        logTarget.includeTime = true;
		        logTarget.includeCategory = true;
		        logTarget.includeLevel = true;
		        Log.addTarget(logTarget);
	  		}
			gateway = new NetConnection();
            gateway.objectEncoding = ObjectEncoding.AMF0;
            gateway.connect(GATEWAY_URL);
		}
		
		public static function send(method:String, rest:Array=null, onResult:Function=null, onFault:Function=null):void{
			Logger.info({request:method, args:rest});
			var resultHandler:Function = function(event:*):void{
				CursorManager.removeBusyCursor();
				if(event.error_code != undefined){
					faultHandler(event);
				}else if(onResult != null){
					Logger.debug(event);
					if(event.serverInfo){
						onResult(Manager.getE4X(event.serverInfo.columnNames, event.serverInfo.initialData), event.serverInfo.initialData, event.serverInfo.columnNames);
					}else{
						onResult(event);
					}
				}
			};
			var faultHandler:Function = function(event:*):void{
				Logger.error(event);
				CursorManager.removeBusyCursor();
				if(event.error_code == undefined){
					Manager.error(Manager.bundle.getMessage("INVALID_RESPONSE"));
				}else{
					if(onFault == null){
						Manager.error(Manager.bundle.getMessage(event.error_code));
					}else{
						onFault(event);
					}
				}
			};
            getInstance().gateway.call.apply(null, ["CAM." + method, new Responder(resultHandler, faultHandler)].concat(rest));
            CursorManager.setBusyCursor();
		}
	}
}

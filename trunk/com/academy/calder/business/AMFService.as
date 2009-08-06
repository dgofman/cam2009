package com.academy.calder.business
{
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import flash.net.Responder;
	
	import mx.logging.Log;
	import mx.logging.LogEventLevel;
	import mx.logging.targets.TraceTarget;
	import mx.managers.CursorManager;
	import mx.utils.ObjectUtil;

	public class AMFService
	{
		private static var GATEWAY_URL:String = "http://localhost/camphp/gateway.php";
		
		private static var logTarget:TraceTarget;
		private static var faultHandlerRef:Function;
		
		public static var DEBUG:Boolean;

		public static function send(class_method:String, parameters:Array=null, onResult:Function=null, onFault:Function=null):void{
			if(DEBUG == true)
				Logger.debug(class_method + ": " + ObjectUtil.toString(parameters));
			var resultHandler:Function = function(event:*):void{
				CursorManager.removeBusyCursor();
				if(DEBUG == true)
					Logger.info(class_method + ": " + ObjectUtil.toString(event));
				if(onResult != null)
					onResult(event);
			};
			var faultHandler:Function = function(event:*):void{
				CursorManager.removeBusyCursor();
				Logger.error(class_method + ": " + ObjectUtil.toString(event));
				if(onFault != null){
					if(event is NetStatusEvent)
						onFault({code:event.info.code,  description:event.info.description, detail:event.info.details});
					else
						onFault(event);
				}
			};
			if(logTarget == null){
				var logTarget:TraceTarget = new TraceTarget();
		        logTarget.level = LogEventLevel.ALL;
		        logTarget.includeDate = true;
		        logTarget.includeTime = true;
		        logTarget.includeCategory = true;
		        logTarget.includeLevel = true;
		        Log.addTarget(logTarget);
		 	}
		        
			var gateway:NetConnection = new NetConnection();
			gateway.objectEncoding = ObjectEncoding.AMF3;
			gateway.connect(Manager.getAppParam("gateway", GATEWAY_URL));

			CursorManager.setBusyCursor();
			if(faultHandlerRef != null)
				gateway.removeEventListener(NetStatusEvent.NET_STATUS, faultHandlerRef);
			gateway.addEventListener(NetStatusEvent.NET_STATUS, faultHandlerRef = faultHandler);
			gateway.call.apply(null, [class_method, new Responder(resultHandler, faultHandler)].concat(parameters));
		}
	}
}
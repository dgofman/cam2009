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

	public class AMFService
	{
		private static var GATEWAY_URL:String = "http://localhost/camphp/gateway.php";

		private static var gateway:NetConnection = null;
		private static var faultHandlerRef:Function;

		public static function send(class_method:String, parameters:Array=null, onResult:Function=null, onFault:Function=null):void{
			var resultHandler:Function = function(event:*):void{
				CursorManager.removeBusyCursor();
				if(onResult != null)
					onResult(event);
			};
			var faultHandler:Function = function(event:*):void{
				CursorManager.removeBusyCursor();
				if(onFault != null){
					if(event is NetStatusEvent)
						onFault({code:event.info.code,  description:event.info.description, detail:event.info.details});
					else
						onFault(event);
				}
			};
			if(gateway == null){
				var logTarget:TraceTarget = new TraceTarget();
		        logTarget.level = LogEventLevel.ALL;
		        logTarget.includeDate = true;
		        logTarget.includeTime = true;
		        logTarget.includeCategory = true;
		        logTarget.includeLevel = true;
		        Log.addTarget(logTarget);
		        
				gateway = new NetConnection();
				gateway.objectEncoding = ObjectEncoding.AMF3;
				gateway.connect(Manager.getAppParam("gateway", GATEWAY_URL));
			}
			CursorManager.setBusyCursor();
			if(faultHandlerRef != null)
				gateway.removeEventListener(NetStatusEvent.NET_STATUS, faultHandlerRef);
			gateway.addEventListener(NetStatusEvent.NET_STATUS, faultHandlerRef = faultHandler);
			gateway.call.apply(null, [class_method, new Responder(resultHandler, faultHandler)].concat(parameters));
		}
	}
}
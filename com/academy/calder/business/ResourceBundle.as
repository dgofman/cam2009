package com.academy.calder.business
{
	import mx.utils.StringUtil;
	import flash.events.Event;
	
	[Bindable]
	public dynamic class ResourceBundle
	{
		[Bindable(event="propertyChange")]
		public function getMessage(key:*, args:Array=null):String{
			var message:String = this[key];
			if(message != null && args != null && args.length){
				message = StringUtil.substitute(this[key], args);
			}
			return message == null ? key : message;
		}
		
		[Bindable(event="propertyChange")]
		public function addChangeListener(data:Object):*{
			return data;
		}
		
		[Bindable(event="propertyChange")]
		public function get resourceBundleChange():ResourceBundle{
			return this;
		}
	}
}
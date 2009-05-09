package com.academy.calder.helper
{
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import mx.core.IMXMLObject;
	
	internal class ViewHelper extends EventDispatcher implements IMXMLObject
	{
		private static const viewHelpers:Object = {};
		
		protected var _view:Object;
		protected var _id:String;
			
		public function initialized(document:Object, id:String):void {
			_view = document;
			_id = id;
			if(getDefinitionByName(className).getSelf == null){
				throw new IllegalOperationError("Abstract method 'getSelf' must be implemented in subclass.");
			}
			_view.addEventListener(Event.ADDED, registerView);
     		_view.addEventListener(Event.REMOVED, unregisterView);
		}
		
		private function get className():String{
			return getQualifiedClassName(this);
		}
		
		private function registerView(event:Event):void{
         	if(event.target == _view){
				viewHelpers[className] = this;
			}
      	}
		
		private function unregisterView(event:Event):void{
			if(event.target == _view){
				_view.removeEventListener(Event.ADDED, registerView);
     			_view.removeEventListener(Event.REMOVED, unregisterView);
				delete viewHelpers[className];
   			}
		}
		
		protected static function getViewHelper(_class:Class):* {
			return viewHelpers[getQualifiedClassName(_class)];
		}
	}
}
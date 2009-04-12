package com.academy.calder.helper
{
	import mx.core.IMXMLObject;
	import flash.errors.IllegalOperationError;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getDefinitionByName;
	import flash.events.Event;
	
	internal class ViewHelper implements IMXMLObject
	{
		private static const viewHelpers:Object = {};
		
		protected var view:Object;
		protected var id:String;
			
		public function initialized(document:Object, id:String):void {
			this.view = document;
			this.id = id;
			if(getDefinitionByName(className).getSelf == null){
				throw new IllegalOperationError("Abstract method 'getSelf' must be implemented in subclass.");
			}
			view.addEventListener(Event.ADDED, registerView);
     		view.addEventListener(Event.REMOVED, unregisterView);
		}
		
		private function get className():String{
			return getQualifiedClassName(this);
		}
		
		private function registerView(event:Event):void{
         	if(event.target == view){
				viewHelpers[className] = this;
			}
      	}
		
		private function unregisterView(event:Event):void{
			if(event.target == view){
				view.removeEventListener(Event.ADDED, registerView);
     			view.removeEventListener(Event.REMOVED, unregisterView);
				delete viewHelpers[className];
   			}
		}
		
		protected static function getViewHelper(_class:Class):* {
			return viewHelpers[getQualifiedClassName(_class)];
		}
	}
}
package com.academy.calder.helper
{
	import com.academy.calder.business.LocalShare;
	import com.academy.calder.view.admin.AdminScreen;
	
	import flash.events.Event;
	
	import mx.containers.ViewStack;
	import mx.core.Container;
	
	public class AdminViewHelper extends ViewHelper
	{
		public static const HOME:String    = "adminHome";
		public static const USER:String    = "userMember";
		public static const STUDENT:String = "adminStudent";
		public static const TEACHER:String = "adminTeacher";
		
		public static const VIEW_SHARE_ID:String = "adminView";
		public static const ADMINVIEW_CHANGE:String = "adminViewChange";
		
		override public function initialized(document:Object, id:String):void {
			super.initialized(document, id);
			MainViewHelper.getSelf().addEventListener(MainViewHelper.MAINVIEW_CHANGE, onMainViewChange);
		}
		
		private function onMainViewChange(event:Event):void{
			var adminViewName:String = LocalShare.getValue(VIEW_SHARE_ID, LocalShare.GLOBAL_LEVEL) as String;
			if(adminViewName != null){
				changeView(adminViewName);
				dispatchEvent(new Event(ADMINVIEW_CHANGE));
			}
		}
		
		public function changeView(name:String):void{
			LocalShare.save(VIEW_SHARE_ID, name, LocalShare.GLOBAL_LEVEL);
			if(adminViewStack.getChildByName(name) is Container)
				adminViewStack.selectedChild = adminViewStack.getChildByName(name) as Container;
		}
		
		public function get adminViewStack():ViewStack{
			return getView().adminViewStack;
		}
				
		public function getView():AdminScreen{
            return view as AdminScreen;
        }
        
        public static function getSelf():AdminViewHelper{
        	return getViewHelper(AdminViewHelper);
        }
	}
}
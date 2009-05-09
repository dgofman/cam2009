package com.academy.calder.helper
{
	import com.academy.calder.business.LocalShare;
	
	import mx.containers.ViewStack;
	import mx.core.Container;
	
	[Bindable]
	public class MainViewHelper extends ViewHelper
	{
		public static const LOGIN:String   = "login";
		public static const SIGNUP:String  = "signup";
		public static const CONFIRM:String = "confirm";
		public static const RESET:String   = "reset";
		public static const CHANGE:String  = "change";
		public static const ADMIN:String   = "admin";
		public static const GUEST:String   = "guest";
		public static const STUDENT:String = "student";
		public static const TEACHER:String = "teacher";
		public static const SIGNOUT:String = "signout";
		
		public static const VIEW_SHARE_ID:String = "mainView";
		public static const MAINVIEW_CHANGE:String = "mainViewChange";
		
		public function changeView(name:String):void{
			LocalShare.save(VIEW_SHARE_ID, name, LocalShare.GLOBAL_LEVEL);
			if(mainViewStack.getChildByName(name) is Container)
				mainViewStack.selectedChild = mainViewStack.getChildByName(name) as Container;
		}
		
		public function get mainViewStack():ViewStack{
			return view.mainViewStack;
		}
				
		public function get view():CAM{
            return _view as CAM;
        }
        
        public static function getSelf():MainViewHelper{
        	return getViewHelper(MainViewHelper);
        }
	}
}
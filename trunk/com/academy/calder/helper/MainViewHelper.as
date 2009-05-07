package com.academy.calder.helper
{
	import com.academy.calder.business.LocalShare;
	
	import mx.containers.ViewStack;
	import mx.core.Container;
	
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
		
		public function changeView(name:String):void{
			LocalShare.save("mainView", name, LocalShare.GLOBAL_LEVEL);
			if(mainViewStack.getChildByName(name) is Container)
				mainViewStack.selectedChild = mainViewStack.getChildByName(name) as Container;
		}
		
		public function get mainViewStack():ViewStack{
			return getView().mainViewStack;
		}
				
		public function getView():CAM{
            return view as CAM;
        }
        
        public static function getSelf():MainViewHelper{
        	return getViewHelper(MainViewHelper);
        }
	}
}
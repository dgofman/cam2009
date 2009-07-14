package com.academy.calder.helper
{
	import com.academy.calder.business.LocalShare;
	import com.academy.calder.view.admin.AdminScreen;
	import com.academy.calder.view.admin.AdminView;
	
	import mx.containers.ViewStack;
	import mx.core.Container;
	
	[Bindable]
	public class AdminViewHelper extends ViewHelper
	{
		private var _viewName:String;
		private var _selectedIndex:int;
		
		public static const HOME:String    = "adminHome";
		public static const PERSON:String  = "adminPerson";
		public static const STUDENT:String = "adminStudent";
		public static const TEACHER:String = "adminTeacher";
		
		public static const VIEW_SHARE_ID:String = "adminView";
		
		public function changeView(name:String):void{
			LocalShare.save(VIEW_SHARE_ID, name, LocalShare.GLOBAL_LEVEL);
			viewName = name;
		}
		
		public function get adminViewStack():ViewStack{
			return view.adminViewStack;
		}
		
		public function get adminView():AdminView{
			return adminViewStack.getChildByName(HOME) as AdminView;
		}
		private function set adminView(value:AdminView):void{
			adminViewStack.selectedChild = value;
		}
		
		public function get viewName():String{
			return _viewName;
		}
		public function set viewName(value:String):void{
			_viewName = value;
			if(adminViewStack.getChildByName(value) is Container){
				adminViewStack.selectedChild = adminViewStack.getChildByName(value) as Container;
				adminViewStack.selectedChild.dispatchEvent(new Event(Event.ACTIVATE));
			}
		}
		
		public function get selectedIndex():int{
			return _selectedIndex;
		}
		private function set selectedIndex(value:int):void{
			_selectedIndex = value;
		}
			
		public function get view():AdminScreen{
            return _view as AdminScreen;
        }

        public static function getSelf():AdminViewHelper{
        	return getViewHelper(AdminViewHelper);
        }
	}
}
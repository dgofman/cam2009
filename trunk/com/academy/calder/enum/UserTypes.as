package com.academy.calder.enum
{
	import com.academy.calder.business.Manager;
	
	[Bindable]
	public class UserTypes
	{
		public static const Admin:UserTypes    = new UserTypes(0, "admin");
        public static const Employee:UserTypes = new UserTypes(1, "employee");
		public static const Guest:UserTypes    = new UserTypes(2, "guest");
        public static const Student:UserTypes  = new UserTypes(3, "student");

        private var _value:int;
		private var _stringValue:String;
		
		public function UserTypes(value:int, stringValue:String){
			_value = value;
			_stringValue = stringValue;
		}
        
        public function get value():int{
            return _value;
        }
        
        public function get label():String{
			return Manager.bundle.getMessage(_stringValue);
		}
		public function set label(value:String):void{}
                
        public static function valueOf(value:int):UserTypes
        {
            for(var i:uint = 0; i < list.length; i++){
            	var type:UserTypes = list[i];
            	if(value == type.value)
            		return type;
            }
            return null;
        }

        public function toString():String{
        	return _stringValue;
        }
        
        public static function get list():Array
        {
            return [
            		Admin,
	                Employee,
	        		Student,
	                Guest
	               			];
        }
    }
}
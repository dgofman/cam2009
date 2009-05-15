package com.academy.calder.enum
{
	import com.academy.calder.business.Manager;
	
	[Bindable]
	public class UserTypes
	{
		public static const Admin:UserTypes    = new UserTypes("admin");
        public static const Employee:UserTypes = new UserTypes("employee");
        public static const Student:UserTypes  = new UserTypes("student");
		public static const Other:UserTypes    = new UserTypes("other");

        private var _value:String;
		
		public function UserTypes(value:String){
			_value = value;
		}
        
        public function get value():String{
            return _value;
        }
        
        public function get label():String{
			return Manager.bundle.getMessage(_value);
		}
		public function set label(value:String):void{}
                
        public static function valueOf(value:String):UserTypes
        {
            for(var i:uint = 0; i < list.length; i++){
            	var type:UserTypes = list[i];
            	if(value == type.value)
            		return type;
            }
            return null;
        }

        public function toString():String{
        	return _value;
        }
        
        public static function get list():Array
        {
            return [
            		Admin,
	                Employee,
	        		Student,
	                Other
	               			];
        }
    }
}
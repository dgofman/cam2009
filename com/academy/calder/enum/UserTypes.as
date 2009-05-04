package com.academy.calder.enum
{
	public class UserTypes
	{
		public static const Admin:UserTypes    = new UserTypes(0);
        public static const Employee:UserTypes = new UserTypes(1);
		public static const Guest:UserTypes    = new UserTypes(2);
        public static const Student:UserTypes  = new UserTypes(3);

        private var _value:int;

        public function UserTypes(value:int){
            _value = value;
        }
        
        public function get value():int{
            return _value;
        }
                
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
        	return String(_value);
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
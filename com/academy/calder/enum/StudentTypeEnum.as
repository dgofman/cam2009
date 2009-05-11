package com.academy.calder.enum
{
	import com.academy.calder.business.Manager;
	
	public class StudentTypeEnum
	{
        public static const Child:StudentTypeEnum    = new StudentTypeEnum(1, 'child');
        public static const Adult:StudentTypeEnum  = new StudentTypeEnum(2, 'adult');
		

		private var _value:int;
		private var _stringValue:String;
		
		public function StudentTypeEnum(value:int, stringValue:String){
			_value = value;
			_stringValue = stringValue;
		}
		
		public function get value():int{
			return _value;
		}
		   
		public function get label():String{
			return Manager.bundle.getMessage(_stringValue);
		}
               
        public static function valueOf(value:int):StudentTypeEnum
        {
            for(var i:uint = 0; i < list.length; i++){
            	var type:StudentTypeEnum = list[i];
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
	                Child,
	                Adult
	        		      ];
        }
    }
}
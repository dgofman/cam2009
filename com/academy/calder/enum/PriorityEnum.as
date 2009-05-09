package com.academy.calder.enum
{
	import com.academy.calder.business.Manager;
	
	public class PriorityEnum
	{
        public static const High:PriorityEnum    = new PriorityEnum(1, 'high');
        public static const Medium:PriorityEnum  = new PriorityEnum(2, 'medium');
		public static const Low:PriorityEnum     = new PriorityEnum(3, 'low');

		private var _value:int;
		private var _stringValue:String;
		
		public function PriorityEnum(value:int, stringValue:String){
			_value = value;
			_stringValue = stringValue;
		}
		
		public function get value():int{
			return _value;
		}
		   
		public function get label():String{
			return Manager.bundle.getMessage(_stringValue);
		}
               
        public static function valueOf(value:int):PriorityEnum
        {
            for(var i:uint = 0; i < list.length; i++){
            	var type:PriorityEnum = list[i];
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
	                High,
	                Medium,
	        		Low
	               			];
        }
    }
}
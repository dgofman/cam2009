package com.academy.calder.enum
{
	public class PriorityEnum
	{
        public static const High:PriorityEnum    = new PriorityEnum(1);
        public static const Medium:PriorityEnum  = new PriorityEnum(2);
		public static const Low:PriorityEnum     = new PriorityEnum(3);

        private var _value:int;

        public function PriorityEnum(value:int){
            _value = value;
        }
        
        public function get value():int{
            return _value;
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
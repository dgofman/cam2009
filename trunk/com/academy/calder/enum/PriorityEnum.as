package com.academy.calder.enum
{
	import com.academy.calder.business.Manager;
	
	[Bindable]
	public class PriorityEnum
	{
        public static const High:PriorityEnum    = new PriorityEnum('high');
        public static const Medium:PriorityEnum  = new PriorityEnum('medium');
		public static const Low:PriorityEnum     = new PriorityEnum('low');

		private var _value:String;

		public function PriorityEnum(value:String){
			_value = value;
		}
		
		public function get value():String{
			return _value;
		}
		   
		public function get label():String{
			return Manager.bundle.getMessage(_value);
		}
               
        public static function valueOf(value:String):PriorityEnum
        {
            for(var i:uint = 0; i < list.length; i++){
            	var type:PriorityEnum = list[i];
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
	                High,
	                Medium,
	        		Low
	               			];
        }
    }
}
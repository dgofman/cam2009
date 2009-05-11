package com.academy.calder.enum
{
	import com.academy.calder.business.Manager;
	
	[Bindable]
	public class Gender
	{
		public static const Male:Gender    = new Gender(1, "male");
        public static const Female:Gender  = new Gender(2, "female");

        private var _value:int;
		private var _stringValue:String;
		
		public function Gender(value:int, stringValue:String){
			_value = value;
			_stringValue = stringValue;
		}
        
        public function get value():int{
            return _value;
        }
        
        public function get label():String{
			return Manager.bundle.getMessage(_stringValue);
		}
                
        public static function valueOf(value:int):Gender
        {
            for(var i:uint = 0; i < list.length; i++){
            	var type:Gender = list[i];
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
            		Male,
	                Female
	               			];
        }
    }
}
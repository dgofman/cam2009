package com.academy.calder.enum
{
	import com.academy.calder.business.Manager;
	
	[Bindable]
	public class Gender
	{
		public static const Male:Gender    = new Gender("male");
        public static const Female:Gender  = new Gender("female");

        private var _value:String;

		public function Gender(value:String){
			_value = value;
		}
        
        public function get value():String{
            return _value;
        }
        
        public function get label():String{
			return Manager.bundle.getMessage(_value);
		}
                
        public static function valueOf(value:String):Gender
        {
            for(var i:uint = 0; i < list.length; i++){
            	var type:Gender = list[i];
            	if(value == type.value)
            		return type;
            }
            return null;
        }

        public function toString():String{
        	return label;
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
package com.academy.calder.enum
{
	import com.academy.calder.business.Manager;
	
	[Bindable]
	public class AddressPriority
	{
		public static const Residence:AddressPriority = new AddressPriority("residence");
        public static const Secondary:AddressPriority = new AddressPriority("secondary");
        public static const Inactive:AddressPriority  = new AddressPriority("inactive");
        public static const Office:AddressPriority    = new AddressPriority("office");

        private var _value:String;

		public function AddressPriority(value:String){
			_value = value;
		}
        
        public function get value():String{
            return _value;
        }
        
        public function get label():String{
			return Manager.bundle.getMessage(_value);
		}
                
        public static function valueOf(value:String):AddressPriority
        {
            for(var i:uint = 0; i < list.length; i++){
            	var type:AddressPriority = list[i];
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
            		Residence,
            		Office,
            		Secondary,
            		Inactive
	               			];
        }
    }
}
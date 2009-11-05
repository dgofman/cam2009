package com.academy.calder.enum
{
	import com.academy.calder.business.Manager;
	
	[Bindable]
	public class ContactAvailability
	{
        public static const Always:ContactAvailability = new ContactAvailability('always');
		public static const Daytime:ContactAvailability = new ContactAvailability('daytime');
        public static const Evenings:ContactAvailability  = new ContactAvailability('evenings');
		public static const MessageOnly:ContactAvailability = new ContactAvailability('messageOnly');

        private var _value:String;

        public function ContactAvailability(value:String){
            _value = value;
        }
        
        public function get value():String{
            return _value;
        }
        
        public function get label():String{
            return Manager.bundle.getMessage(_value);
        }
                
        public static function valueOf(value:String):ContactAvailability
        {
            for(var i:uint = 0; i < list.length; i++){
            	var type:ContactAvailability = list[i];
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
	                Always,
	                Daytime,
	        		Evenings,
	        		MessageOnly
	        		];
        }
    }
}
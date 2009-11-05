package com.academy.calder.enum
{
	import com.academy.calder.business.Manager;
	
	[Bindable]
	public class ContactCategory
	{
		public static const Home:ContactCategory = new ContactCategory('home');
        public static const Business:ContactCategory = new ContactCategory('business');
        public static const Personal:ContactCategory  = new ContactCategory('personal');
		public static const Other:ContactCategory = new ContactCategory('other');

        private var _value:String;

        public function ContactCategory(value:String){
            _value = value;
        }
        
        public function get value():String{
            return _value;
        }
        
        public function get label():String{
            return Manager.bundle.getMessage(_value);
        }
                
        public static function valueOf(value:String):ContactCategory
        {
            for(var i:uint = 0; i < list.length; i++){
            	var type:ContactCategory = list[i];
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
	                Home,
	                Business,
	        		Personal,
	        		Other
	        		];
        }
    }
}
package com.academy.calder.enum
{
	import com.academy.calder.business.Manager;
	
	[Bindable]
	public class ContactType
	{
        public static const Email:ContactType = new ContactType('email');
		public static const Phone:ContactType = new ContactType('phone');
        public static const Cell:ContactType  = new ContactType('cell');
		public static const Pager:ContactType = new ContactType('pager');
		public static const Fax:ContactType   = new ContactType('fax');

        private var _value:String;

        public function ContactType(value:String){
            _value = value;
        }
        
        public function get value():String{
            return _value;
        }
        
        public function get label():String{
            return Manager.bundle.getMessage(_value);
        }
                
        public static function valueOf(value:String):ContactType
        {
            for(var i:uint = 0; i < list.length; i++){
            	var type:ContactType = list[i];
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
	                Email,
	                Phone,
	        		Cell,
	        		Pager,
	        		Fax
	               			];
        }
    }
}
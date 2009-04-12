package com.academy.calder.enum
{
	import com.academy.calder.business.Manager;
	
	public class UserLanguage
	{
		public static const English:UserLanguage = new UserLanguage("en_US", "english");
        
        private var _value:String;
        private var _stringValue:String;
        
        public function UserLanguage(value:String, stringValue:String){
            _value = value;
            _stringValue = stringValue;
        }
        
        public function get value():String{
            return _value;
        }
        
        public function get stringValue():String{
            return _stringValue;
        }
        
        public static function valueOf(value:*):UserLanguage
        {
            for(var i:uint = 0; i < list().length; i++){
            	var type:UserLanguage = list()[i];
            	if(value == type.value || value == type.stringValue)
            		return type;
            }
			return English;
        }
        
        public function toString():String{
        	return String(_value);
        }
        
        public static function get dispalayList():Array{
			var types:Array = [];
			for(var i:uint = 0; i < list().length; i++){
				var type:UserLanguage = list()[i];
				types[i] = {label:Manager.bundle.getMessage(type.stringValue), data:type.value};
			}
			return types;
        }

        public static function list():Array
        {
            return [
	                English
	               				];
        }
    }
}
package com.academy.calder.enum
{
	public class AccountStatus
	{
		public static const Inactive:AccountStatus = new AccountStatus(1);
        public static const Active:AccountStatus   = new AccountStatus(2);
        public static const Disable:AccountStatus  = new AccountStatus(3);

        private var _value:int;

        public function AccountStatus(value:int){
            _value = value;
        }
        
        public function get value():int{
            return _value;
        }
                
       public static function valueOf(value:int):AccountStatus
        {
            for(var i:uint = 0; i < list().length; i++){
            	var type:AccountStatus = list()[i];
            	if(value == type.value)
            		return type;
            }
            return null;
        }

        public function toString():String{
        	return String(_value);
        }
        
        public static function list():Array
        {
            return [
	                Inactive,
	                Active,
	        		Disable
	               			];
        }
    }
}
package com.academy.calder.enum
{
	import com.academy.calder.business.Manager;
	
	[Bindable]
	public class AccountStatus
	{
		public static const Any:AccountStatus      = new AccountStatus(NaN, 'any');
        public static const Active:AccountStatus   = new AccountStatus(1, 'active');
        public static const Disable:AccountStatus  = new AccountStatus(2, 'disable');
		public static const Inactive:AccountStatus = new AccountStatus(3, 'inactive');

        private var _value:Number;
        private var _stringValue:String;

        public function AccountStatus(value:Number, stringValue:String){
            _value = value;
            _stringValue = stringValue;
        }
        
        public function get value():Number{
            return _value;
        }
        
        public function get label():String{
            return Manager.bundle.getMessage(_stringValue);
        }
                
        public static function valueOf(value:int):AccountStatus
        {
            for(var i:uint = 0; i < list.length; i++){
            	var type:AccountStatus = list[i];
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
            		Any,
	                Active,
	                Inactive,
	        		Disable
	               			];
        }
        
        public static function get userList():Array
        {
            return [
	                Active,
	                Inactive,
	        		Disable
	               			];
        }
    }
}
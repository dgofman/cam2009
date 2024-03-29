package com.academy.calder.enum
{
	import com.academy.calder.business.Manager;
	
	[Bindable]
	public class AccountStatus
	{
        public static const Active:AccountStatus   = new AccountStatus('active');
        public static const Disable:AccountStatus  = new AccountStatus('disable');
		public static const Inactive:AccountStatus = new AccountStatus('inactive');
		public static const Pending:AccountStatus  = new AccountStatus('pending');

        private var _value:String;

        public function AccountStatus(value:String){
            _value = value;
        }
        
        public function get value():String{
            return _value;
        }
        
        public function get label():String{
            return Manager.bundle.getMessage(_value);
        }
                
        public static function valueOf(value:String):AccountStatus
        {
            for(var i:uint = 0; i < list.length; i++){
            	var type:AccountStatus = list[i];
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
	                Active,
	                Inactive,
	        		Disable,
	        		Pending
	               			];
        }
    }
}
package com.academy.calder.enum
{
	import com.academy.calder.business.Manager;
	
	[Bindable]
	public class PrivilegeEnum
	{
		public static const CRUDO:PrivilegeEnum  = new PrivilegeEnum('crudo');
        public static const CRUD:PrivilegeEnum   = new PrivilegeEnum('crud');
        public static const CRU:PrivilegeEnum    = new PrivilegeEnum('cru');
		public static const RU:PrivilegeEnum     = new PrivilegeEnum('ru');
		public static const R:PrivilegeEnum      = new PrivilegeEnum('r');
		
		private var _value:String;

		public function PrivilegeEnum(value:String){
			_value = value;
		}
		
		public function get value():String{
			return _value;
		}
		   
		public function get label():String{
			return Manager.bundle.getMessage(_value);
		}
               
        public static function valueOf(value:String):PrivilegeEnum
        {
            for(var i:uint = 0; i < list.length; i++){
            	var type:PrivilegeEnum = list[i];
            	if(value == type.value)
            		return type;
            }
            return null;
        }

        public function toString():String{
        	return _value;
        }
        
        public static function get list():Array
        {
            return [
	                CRUDO,
	                CRUD,
	                CRU,
	                RU,
	                R
	               	];
        }
    }
}
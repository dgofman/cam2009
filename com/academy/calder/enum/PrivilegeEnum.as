package com.academy.calder.enum
{
	import com.academy.calder.business.Manager;
	
	[Bindable]
	public class PrivilegeEnum
	{
		public static const CRUDO:PrivilegeEnum  = new PrivilegeEnum(1, 'crudo');
        public static const CRUD:PrivilegeEnum   = new PrivilegeEnum(2, 'crud');
        public static const CRU:PrivilegeEnum    = new PrivilegeEnum(3, 'cru');
		public static const RU:PrivilegeEnum     = new PrivilegeEnum(4, 'ru');
		public static const R:PrivilegeEnum      = new PrivilegeEnum(5, 'r');
		
		private var _value:int;
		private var _stringValue:String;
		
		public function PrivilegeEnum(value:int, stringValue:String){
			_value = value;
			_stringValue = stringValue;
		}
		
		public function get value():int{
			return _value;
		}
		   
		public function get label():String{
			return Manager.bundle.getMessage(_stringValue);
		}
               
        public static function valueOf(value:int):PrivilegeEnum
        {
            for(var i:uint = 0; i < list.length; i++){
            	var type:PrivilegeEnum = list[i];
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
	                CRUDO,
	                CRUD,
	                CRU,
	                RU,
	                R
	               	];
        }
    }
}
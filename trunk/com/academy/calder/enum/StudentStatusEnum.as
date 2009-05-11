package com.academy.calder.enum
{
	public class StudentStatusEnum
	{
        public static const Pending:StudentStatusEnum    = new StudentStatusEnum(1);
        public static const Active:StudentStatusEnum  = new StudentStatusEnum(2);
		public static const Inactive:StudentStatusEnum  = new StudentStatusEnum(3);
		public static const Suspend:StudentStatusEnum	= new StudentStatusEnum(4);

        private var _value:int;

        public function StudentStatusEnum(value:int){
            _value = value;
        }
        
        public function get value():int{
            return _value;
        }
                
       public static function valueOf(value:int):StudentStatusEnum
        {
            for(var i:uint = 0; i < list.length; i++){
            	var type:StudentStatusEnum = list[i];
            	if(value == type.value)
            		return type;
            }
            return null;
        }

        public function toString():String{
        	return String(_value);
        }
        
        public static function get list():Array
        {
            return [
	                Pending,
	                Active,
	        		Inactive,
	        		Suspend
	               	];
        }
    }
}
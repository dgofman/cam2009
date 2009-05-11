package com.academy.calder.enum
{
	[Bindable]
	public class MessageStatusEnum
	{
        public static const Read:MessageStatusEnum    = new MessageStatusEnum(1);
        public static const Unread:MessageStatusEnum  = new MessageStatusEnum(2);
		public static const Delete:MessageStatusEnum  = new MessageStatusEnum(3);

        private var _value:int;

        public function MessageStatusEnum(value:int){
            _value = value;
        }
        
        public function get value():int{
            return _value;
        }
                
       public static function valueOf(value:int):MessageStatusEnum
        {
            for(var i:uint = 0; i < list.length; i++){
            	var type:MessageStatusEnum = list[i];
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
	                Read,
	                Unread,
	        		Delete
	               	];
        }
    }
}
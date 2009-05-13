package com.academy.calder.enum
{
	[Bindable]
	public class MessageStatusEnum
	{
        public static const Read:MessageStatusEnum    = new MessageStatusEnum('read');
        public static const Unread:MessageStatusEnum  = new MessageStatusEnum('unread');
		public static const Delete:MessageStatusEnum  = new MessageStatusEnum('delete');

        private var _value:String;

        public function MessageStatusEnum(value:String){
            _value = value;
        }
        
        public function get value():String{
            return _value;
        }
                
       public static function valueOf(value:String):MessageStatusEnum
        {
            for(var i:uint = 0; i < list.length; i++){
            	var type:MessageStatusEnum = list[i];
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
	                Read,
	                Unread,
	        		Delete
	               	];
        }
    }
}
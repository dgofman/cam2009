package com.academy.calder.enum
{
	import com.academy.calder.business.Manager;
	
	[Bindable]
	public class Relation
	{
        public static const Self:Relation   = new Relation('self');
        public static const Father:Relation = new Relation('father');
		public static const Mother:Relation = new Relation('mother');
		public static const Guardian:Relation = new Relation('guardian');
		public static const Emergency:Relation = new Relation('emergency');
		
        private var _value:String;

        public function Relation(value:String){
            _value = value;
        }
        
        public function get value():String{
            return _value;
        }
        
        public function get label():String{
            return Manager.bundle.getMessage(_value);
        }
                
        public static function valueOf(value:String):Relation
        {
            for(var i:uint = 0; i < list.length; i++){
            	var type:Relation = list[i];
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
	                Self,
	                Father,
	        		Mother,
	        		Guardian,
	        		Emergency
	               			];
        }
    }
}
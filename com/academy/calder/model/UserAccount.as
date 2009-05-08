package com.academy.calder.model
{
	import com.academy.calder.enum.UserTypes;
	
	[Bindable]
	public class UserAccount
	{
		private var _id:Number;
		
		private var _first:String;
		
		private var _language:String;
		
		private var _type:UserTypes;
		
		public function UserAccount(id:Number, first:String, language:String, type:UserTypes){
			this.id = id;
			this.first = first;
			this.language = language;
			this.type = type;
		}
		
		public function get id():Number{
			return _id;
		}
		public function set id(value:Number):void{
			_id = value;
		}
		
		public function get first():String{
			return _first;
		}
		public function set first(value:String):void{
			_first = value;
		}
		
		public function get language():String{
			return _language;
		}
		public function set language(value:String):void{
			_language = value;
		}

		public function get type():UserTypes{
			return _type;
		}
		public function set type(value:UserTypes):void{
			_type = value;
		}
	}
}
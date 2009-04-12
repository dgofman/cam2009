package com.academy.calder.model
{
	import com.academy.calder.enum.UserTypes;
	
	[Bindable]
	public class UserAccount
	{
		private var _id:Number;
		
		private var _first:String;
		
		private var _language:String;
		
		private var _admin:Boolean;
		
		private var _type:UserTypes;
		
		public function UserAccount(id:Number, first:String, language:String,
										admin:Boolean, type:UserTypes){
			_id = id;
			_first = first;
			_language = language;
			_admin = admin;
			_type = type;
		}
		
		public function get id():Number{
			return _id;
		}
		
		public function get first():String{
			return _first;
		}
		
		public function get language():String{
			return _language;
		}
		
		public function get admin():Boolean{
			return _admin;
		}
		
		public function get type():UserTypes{
			return _type;
		}
	}
}
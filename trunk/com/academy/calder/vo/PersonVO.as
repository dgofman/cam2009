package com.academy.calder.vo
{
	import com.academy.calder.enum.Gender;
	import com.academy.calder.enum.UserTypes;
	
	import flash.events.Event;
	
	import mx.events.PropertyChangeEvent;
	
	[Bindable]
	public class PersonVO
	{
		public function PersonVO(result:Object=null){
			if(result != null){
				userId = result.userId;
				personId = result.personId;
				accountId = result.accountId;
				first = result.first;
				last = result.last;
				localeName = result.localeName;
				dateOfBirth = result.dateOfBirth;
				notes = result.notes;
				sex = Gender.valueOf(result.sex);
				typeOf = UserTypes.valueOf(result.typeOf);
			}
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE));
		}
		
		public var userId:String;
		public var personId:String;
		public var accountId:String;
		public var first:String;
		public var last:String;
		public var localeName:String;
		public var dateOfBirth:String;
		public var notes:String;
		public var sex:Gender = Gender.Male;
		public var typeOf:UserTypes = UserTypes.Other;
		
		private var _language:String;
		
		public function set language(value:String):void{
			_language = value;
			dispatchEvent(new Event("attributesChange"));
		}
		
		[Bindable("attributesChange")]
		public function get attributes():Array{
			return [
				new UserItem({label:'first', value:first}),
				new UserItem({label:'last', value:last}),
				new UserItem({label:'dob', value:dateOfBirth}),
				new UserItem({label:'accountId', value:accountId}),
				new UserItem({label:'sex', value:sex}),
				new UserItem({label:'userType', value:typeOf}),
				new UserItem({label:'language', value:_language}),
				new UserItem({label:'notes', value:notes})
					];
		}
	}
}
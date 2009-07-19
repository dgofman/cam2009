package com.academy.calder.vo
{
	import com.academy.calder.enum.Gender;

	import flash.events.Event;
	
	import mx.events.PropertyChangeEvent;
	
	[Bindable]
	public class PersonVO
	{
		public function PersonVO(result:Object=null){
			if(result != null){
				userId = result.userId;
				personId = result.personId;
				first = result.first;
				last = result.last;
				localeName = result.localeName;
				dateOfBirth = result.dateOfBirth;
				notes = result.notes;
				sex = Gender.valueOf(result.sex);
			}
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE));
		}
		
		public var userId:String;
		public var personId:String;
		public var first:String;
		public var last:String;
		public var localeName:String;
		public var dateOfBirth:String;
		public var notes:String;
		public var sex:Gender = Gender.Male;

		private var _language:String;
		
		public function set language(value:String):void{
			_language = value;
			//dispatchEvent(new Event("attributesChange"));
		}
		
		/*[Bindable("attributesChange")]
		public function get attributes():Array{
			return [
				new UserItem('first', first),
				new UserItem('last',last),
				new UserItem('dob', dateOfBirth),
				new UserItem('sex', sex),
				new UserItem('language', _language),
				new UserItem('notes', notes)
					];
		}*/
	}
}
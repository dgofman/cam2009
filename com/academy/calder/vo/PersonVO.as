package com.academy.calder.vo
{
	import com.academy.calder.enum.Gender;
	
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
		}
		
		public var userId:String;		
		public var personId:String;
		public var first:String;
		public var last:String;
		public var localeName:String;
		public var dateOfBirth:String;
		public var notes:String;
		public var sex:Gender = Gender.Male;

		public var language:String;
	}
}
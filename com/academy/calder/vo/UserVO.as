package com.academy.calder.vo
{
	[Bindable]
	public class UserVO
	{
		public function UserVO(result:Object){
			if(result != null){
				userId = result.userId;
				accountId = result.accountId;
				first = result.first;
				last = result.last;
				namesoundex = result.namesoundex;
				language = result.language;
				sex = result.sex;
				dateOfBirth = result.dateOfBirth;
				notes = result.notes;
			}
		}
		
		public var userId:String;
		public var accountId:String;
		public var first:String;
		public var last:String;
		public var namesoundex:String;
		public var language:String;
		public var sex:String;
		public var dateOfBirth:String;
		public var notes:String;
	}
}
package com.academy.calder.vo
{
	import com.academy.calder.enum.AccountStatus;
	import com.academy.calder.enum.Gender;
	import com.academy.calder.enum.PrivilegeEnum;
	import com.academy.calder.enum.UserTypes;
	
	[Bindable]
	public class UserVO
	{
		public function UserVO(result:Object=null){
			if(result != null){
				userId = result.userId;
				personId = result.personId;
				accountId = result.accountId;
				username = result.username;
				first = result.first;
				last = result.last;
				namesoundex = result.namesoundex;
				localeName = result.localeName;
				dateOfBirth = result.dateOfBirth;
				notes = result.notes;
				sex = Gender.valueOf(result.sex);
				typeOf = UserTypes.valueOf(result.typeOf);
				privileges = PrivilegeEnum.valueOf(result.privileges);
				status = AccountStatus.valueOf(result.status);
			}
		}
		
		public var userId:String;
		public var personId:String;
		public var accountId:String;
		public var username:String;
		public var first:String;
		public var last:String;
		public var namesoundex:String;
		public var localeName:String;
		public var dateOfBirth:String;
		public var notes:String;
		public var sex:Gender;
		public var typeOf:UserTypes;
		public var privileges:PrivilegeEnum;
		public var status:AccountStatus;
	}
}
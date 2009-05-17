package com.academy.calder.vo
{
	import com.academy.calder.enum.AccountStatus;
	import com.academy.calder.enum.Gender;
	import com.academy.calder.enum.PrivilegeEnum;
	import com.academy.calder.enum.UserTypes;
	
	import flash.events.Event;
	
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
		public var password:String;
		public var first:String;
		public var last:String;
		public var namesoundex:String;
		public var localeName:String;
		public var dateOfBirth:String;
		public var notes:String;
		public var sex:Gender = Gender.Male;
		public var typeOf:UserTypes = UserTypes.Other;
		public var privileges:PrivilegeEnum = PrivilegeEnum.R;
		public var status:AccountStatus = AccountStatus.Pending;
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
				new UserItem({label:'namesoundex', value:namesoundex}),
				new UserItem({label:'username', value:username}),
				new UserItem({label:'dob', value:dateOfBirth}),
				new UserItem({label:'accountId', value:accountId}),
				new UserItem({label:'sex', value:sex}),
				new UserItem({label:'userType', value:typeOf}),
				new UserItem({label:'privileges', value:privileges}),
				new UserItem({label:'userStatus', value:status}),
				new UserItem({label:'language', value:_language}),
				new UserItem({label:'notes', value:notes})
					];
		}
	}
}
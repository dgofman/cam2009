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
				{label:'first', value:first},
				{label:'last', value:last},
				{label:'namesoundex', value:namesoundex},
				{label:'username', value:username},
				{label:'dob', value:dateOfBirth},
				{label:'accountId', value:accountId},
				{label:'sex', value:sex},
				{label:'userType', value:typeOf},
				{label:'privileges', value:privileges},
				{label:'userStatus', value:status},
				{label:'language', value:_language},
				{label:'notes', value:notes}
					];
		}
	}
}
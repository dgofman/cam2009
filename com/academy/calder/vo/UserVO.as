package com.academy.calder.vo
{
	import com.academy.calder.enum.AccountStatus;
	import com.academy.calder.enum.PrivilegeEnum;
	
	import mx.events.PropertyChangeEvent;
	
	[Bindable]
	public class UserVO
	{
		public function UserVO(result:Object=null){
			if(result != null){
				userId = result.userId;
				username = result.username;
				privileges = PrivilegeEnum.valueOf(result.privileges);
				status = AccountStatus.valueOf(result.status);
				notes = result.notes;
				
				personRef = new PersonVO(result);
			}
			dispatchEvent(new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE));
		}
		
		public var userId:String;
		public var username:String;
		public var password:String;
		public var privileges:PrivilegeEnum = PrivilegeEnum.R;
		public var status:AccountStatus = AccountStatus.Pending;
		public var notes:String;
		public var personRef:PersonVO;
		
		[Bindable("attributesChange")]
		public function get attributes():Array{
			return [
				new UserItem({label:'userId', value:userId}),
				new UserItem({label:'username', value:username}),
				new UserItem({label:'password', value:password}),
				new UserItem({label:'privileges', value:privileges}),
				new UserItem({label:'userStatus', value:status}),
				new UserItem({label:'notes', value:notes})
					];
		}
	}
}
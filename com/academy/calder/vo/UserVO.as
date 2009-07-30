package com.academy.calder.vo
{
	import com.academy.calder.enum.AccountStatus;
	import com.academy.calder.enum.PrivilegeEnum;
	
	[Bindable]
	public class UserVO
	{
		public function UserVO(result:Object=null){
			if(result != null){
				userId = result.userId;
				username = result.username;
				admin = (result.admin == 1);
				privileges = PrivilegeEnum.valueOf(result.privileges);
				status = AccountStatus.valueOf(result.status);
				notes = result.notes;
			}
		}
		
		public var userId:String;
		public var username:String;
		public var password:String;
		public var admin:Boolean;
		public var privileges:PrivilegeEnum = PrivilegeEnum.R;
		public var status:AccountStatus = AccountStatus.Pending;
		public var notes:String;
		
		private var _personRef:PersonVO;
		
		public function get personRef():PersonVO{
			return _personRef;
		}
		public function set personRef(value:PersonVO):void{
			_personRef = value;
		}
	}
}
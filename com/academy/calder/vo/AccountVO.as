package com.academy.calder.vo
{
	[Bindable]
	public class AccountVO
	{
		public function AccountVO(result:Object=null){
			if(result != null){
				accountId = result.accountId;
				selectedBillingAddressId = result.selectedBillingAddressId;
				selectedBillingEmailContactId = result.selectedBillingEmailContactId;
				currentBalance = result.currentBalance;
				lastPaymentDate = result.lastPaymentDate;
				updateTime = result.updateTime;
				updateBy = result.updateBy;
				notes = result.notes;
			}
		}
		
		public var accountId:String;
		public var selectedBillingAddressId:String;
		public var selectedBillingEmailContactId:String;
		public var currentBalance:String;
		public var lastPaymentDate:String;
		public var updateTime:String;
		public var updateBy:String;
		public var notes:String;
	}

	}
}
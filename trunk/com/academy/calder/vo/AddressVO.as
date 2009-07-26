package com.academy.calder.vo
{
	[Bindable]
	public class AddressVO
	{
		public function AddressVO(result:Object=null){
			if(result != null){
				addressId = result.addressId;
				priority = result.priority; 
				address1 = result.address1;
				address2 = result.address2;
				city = result.city;
				stateProvince = result.stateProvince;
				postalCode = result.postalCode;
				country = result.country;
				inactiveAsOfDate = result.inactiveAsOfDate;
				createdTime = result.createdTime;
				updatedTime = result.updatedTime;
				updatedBy = result.updatedBy;
				notes = result.notes;
			}
		}
		
		public var addressId:String;
		public var priority:String;
		public var address1:String;
		public var address2:String;
		public var city:String;
		public var stateProvince:String;
		public var postalCode:String;
		public var country:String;
		public var inactiveAsOfDate:String;
		public var createdTime:String;
		public var updatedTime:String;
		public var updatedBy:String;
		public var notes:String;
	}
}
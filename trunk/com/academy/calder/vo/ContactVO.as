package com.academy.calder.vo
{
	[Bindable]
	public class ContactVO
	{
		public function ContactVO(result:Object=null){
			if(result != null){
				contactId = result.contactId;
				type = result.type;
				category = result.category;
				entry = result.entry;
				available = result.available;
				inactiveAsOfDate = result.inactiveAsOfDate;
				createdTime = result.createdTime;
				updatedTime = result.updatedTime;
				updatedBy = result.updatedBy;
				notes = result.notes;
			}
		}
		
		public var contactId:String;
		public var type:String;
		public var category:String;
		public var entry:String;
		public var available:String;
		public var inactiveAsOfDate:String;
		public var createdTime:String;
		public var updatedTime:String;
		public var updatedBy:String;
		public var notes:String;
	}
}
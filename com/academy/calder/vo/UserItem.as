package com.academy.calder.vo{

	[Bindable]
	public class UserItem{

		public var label:String;
		public var value:*;
		
		public function UserItem(o:Object){
			this.label = o.label;
			this.value = o.value;
		}
	}
}
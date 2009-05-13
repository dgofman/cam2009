package com.academy.calder.vo
{
	import com.academy.calder.enum.PriorityEnum;
	
	[Bindable]
	public class MessageVO
	{
		public function MessageVO(result:Object=null){
			if(result != null){
				messageId = result.messageId;
				subject = result.subject;
				body = result.body;
				createdTime = result.createdTime;
				priority = PriorityEnum.valueOf(result.priority);
			}
		}
		public var messageId:String;
		public var subject:String;
		public var body:String;
		public var createdTime:String;
		public var priority:PriorityEnum = PriorityEnum.Low;
	}
}
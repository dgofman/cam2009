package com.academy.calder.vo
{
	import com.academy.calder.enum.AccountStatus;
	import com.academy.calder.enum.PrivilegeEnum;
	
	import mx.events.PropertyChangeEvent;
	
	[Bindable]
	public class LessonVO
	{
		public function LessonVO(result:Object=null){
			if(result != null){
				lessonControlId = result.lessonControlId;
				type = result.type;
				rate = result.rate;
				first = result.first;
				last = result.last;
				lesson = result.lesson;
				duration = result.duration;
			}
		}
		
		public var lessonControlId:String;
		public var type:String;
		public var rate:String;
		public var first:String;
		public var last:String;
		public var lesson:String;
		public var duration:String;
	}
}
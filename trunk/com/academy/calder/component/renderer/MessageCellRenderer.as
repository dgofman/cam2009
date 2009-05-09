package com.academy.calder.component.renderer
{
	import com.academy.calder.enum.MessageStatusEnum;
	import com.academy.calder.enum.PriorityEnum;
	
	import mx.controls.Label;
	import mx.controls.dataGridClasses.DataGridListData;

	public class MessageCellRenderer extends Label{
		
		override public function set data(value:Object):void{
        	super.data = value;
        	if(data && listData){
        		text = data[DataGridListData(listData).dataField];
        		setStyle('fontWeight', data.status == MessageStatusEnum.Unread.value ? 'bold' : 'normal');
        		
        		var color:Number = 0;
        		switch(PriorityEnum.valueOf(data.priority)){
        			case PriorityEnum.High:
        				color = 0xCC0066;
        				break;
        			case PriorityEnum.Medium:
        				color = 0xFF9933;
        				break;
        		}
        		setStyle('color', color);
        	}
        }
	}
}

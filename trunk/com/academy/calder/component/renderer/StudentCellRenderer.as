package com.academy.calder.component.renderer
{
	import com.academy.calder.enum.StudentStatusEnum;
	import com.academy.calder.enum.StudentTypeEnum;
	
	import mx.controls.Label;
	import mx.controls.dataGridClasses.DataGridListData;

	public class StudentCellRenderer extends Label{
		
		override public function set data(value:Object):void{
        	super.data = value;
        	if(data && listData){
        		text = data[DataGridListData(listData).dataField];
        		setStyle('fontWeight', data.status == StudentStatusEnum.Active.value ? 'bold' : 'normal');
        		
        		
        		var color:Number = 0;
        		
        		switch(StudentTypeEnum.valueOf(data.type)){	
        			case StudentTypeEnum.Child:
        				color = 0xCC0066;
        				break;
        			case StudentTypeEnum.Adult:
        				color = 0xFF9933;
        				break;
        		}
        		setStyle('color', color);
        	}
        }
	}
}


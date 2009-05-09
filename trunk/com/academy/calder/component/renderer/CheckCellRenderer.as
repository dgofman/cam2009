package com.academy.calder.component.renderer
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.controls.CheckBox;
	import mx.controls.dataGridClasses.DataGridListData;
	import mx.controls.listClasses.BaseListData;

	public class CheckCellRenderer extends CheckBox {
	
		override protected function createChildren():void{
        	super.createChildren();
			addEventListener("dataChange", handleDataChanged);
		}
		
		override public function set listData(value:BaseListData):void{
			super.listData = value;
			if (listData){
				handleDataChanged(null);
			}
		}

		public function handleDataChanged(event:Event):void {
			if(data && listData){
				selected = (data[DataGridListData(listData).dataField] == true);
			}
		}

		override protected function clickHandler(event:MouseEvent):void{
			super.clickHandler(event);
			if(data && listData){
				data[DataGridListData(listData).dataField] = selected;
			}
		}
	}
}

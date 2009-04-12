package com.academy.calder.component.renderer
{
	import mx.core.UIComponent;
	import mx.controls.DateField;
	
	/*
	 * CheckBox cell renderer ActionScript implementation class used in various
	 * datagrids to display a checkbox
	 */
	class DateCellRenderer extends UIComponent {
	
		var date : MovieClip;
		var listOwner : MovieClip; // the reference we receive to the list
		var getCellIndex : Function; // the function we receive from the list
		var getDataLabel : Function; // the function we receive from the list
	
		function DateCellRenderer() {
		}
	
		function createChildren(Void) : Void {
			date = createClassObject(DateField, "date", 1, {styleName:this, owner:this});
			size();
		}
	
		function setValue(str:String, item:Object, sel:Boolean) : Void {
			date._visible = (item!=undefined);
			date.text = item[getDataLabel()];
		}
	}
}
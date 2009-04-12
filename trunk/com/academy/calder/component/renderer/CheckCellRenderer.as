package com.academy.calder.component.renderer
{
	import mx.core.UIComponent
	import mx.controls.CheckBox
	
	/*
	 * CheckBox cell renderer ActionScript implementation class used in various
	 * datagrids to display a checkbox
	 */
	public class CheckCellRenderer extends UIComponent {
	
		function CheckCellRenderer() {
		}
	
		/*function createChildren(Void) : Void {
			check = createClassObject(CheckBox, "check", 1, {styleName:this, owner:this});
			check.addEventListener("click", this);
			size();
		}
	
		// note that setSize is implemented by UIComponent and calls size(), after setting
		// __width and __height
		function size(Void) : Void {
			check.setSize(getPreferredWidth(), layoutHeight);
			check._x = (layoutWidth-getPreferredWidth())/2;
			check._y = (layoutHeight-getPreferredHeight())/2;
		}
	
		function setValue(str:String, item:Object, sel:Boolean) : Void {
			check._visible = (item!=undefined);
			check.selected = item[getDataLabel()];
		}
	
		function getPreferredHeight(Void) : Number {
			return 16;
		}
	
		function getPreferredWidth(Void) : Number {
			return 20;
		}
	
		function click() {
			listOwner.editField(getCellIndex().itemIndex, getDataLabel(), check.selected);
		}*/
	}
}

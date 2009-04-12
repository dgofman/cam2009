package com.academy.calder.component.renderer
{
	
	import mx.core.UIComponent
	import mx.controls.Label
	
	/*
	 * CheckBox cell renderer ActionScript implementation class used in various
	 * datagrids to display a checkbox
	 */
	public class PhoneCellRenderer extends UIComponent {
	
		function PhoneCellRenderer() {
		}
	
		/*function createChildren(Void) : Void {
			label = createClassObject(Label, "label", 1, {styleName:this, owner:this});
			size();
		}
	
		// note that setSize is implemented by UIComponent and calls size(), after setting
		// __width and __height
		function size(Void) : Void {
			label.setSize(layoutWidth, layoutHeight);
		}
	
		function setValue(str:String, item:Object, sel:Boolean) : Void {
			var str:String = item[getDataLabel()];
			var value:Array = [];
			value.push("(");
			if(str.length > 2) value.push(str.substring(0, 3));
			value.push(") ");
			if(str.length > 6) {
				value.push(str.substring(3, 6));
				value.push("-");
				value.push(str.substring(6));
			}else if(str.length > 3){
				value.push(str.substring(3));
			}
			label.text = value.join("");
		}
	
		function getPreferredHeight(Void) : Number {
			return 16;
		}
	
		function getPreferredWidth(Void) : Number {
			return 20;
		}*/
	}
}

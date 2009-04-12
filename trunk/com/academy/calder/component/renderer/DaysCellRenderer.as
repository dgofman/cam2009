package com.academy.calder.component.renderer
{
	import mx.core.UIComponent
	import mx.controls.Label
	
	/*
	 * CheckBox cell renderer ActionScript implementation class used in various
	 * datagrids to display a checkbox
	 */
	public class DaysCellRenderer extends UIComponent {
	
		/*var label : MovieClip;
		var listOwner : MovieClip; // the reference we receive to the list
		var getCellIndex : Function; // the function we receive from the list
		var getDataLabel : Function; // the function we receive from the list
		var days:Array = ["S", "M", "T", "W", "T", "F", "S"];
		*/
		function DaysCellRenderer() {
		}
	
		/*function createChildren(Void) : Void {
			label = createClassObject(Label, "label", 1, {styleName:this, owner:this, html:true});
			size();
		}
	
		// note that setSize is implemented by UIComponent and calls size(), after setting
		// __width and __height
		function size(Void) : Void {
			label.setSize(layoutWidth, getPreferredHeight());
			label._y = (layoutHeight-getPreferredHeight())/2;
		}
		
		function getPreferredHeight(Void) : Number {
			return 16;
		}
	
		function setValue(str:String, item:Object, sel:Boolean) : Void {
			var d:Array = [];
			if(item != undefined){
				var value:String = item[getDataLabel()];
				for(var i:Number = 0; i < days.length; i++){
					d[i] = ((value.charAt(i) == '1') ? "<b><font color='#ff0000'>" + days[i] + "</font></b>" : "<font color='#cccccc'>" + days[i] + "</font>");
				}
			}
			label.htmlText = d.join("");
		}*/
	}
}

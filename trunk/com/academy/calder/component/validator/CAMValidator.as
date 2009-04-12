import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.utils.setTimeout;

import mx.controls.ToolTip;
import mx.core.Container;
import mx.events.FlexEvent;
import mx.events.ValidationResultEvent;
import mx.managers.ToolTipManager;
import com.academy.calder.business.Manager;
	
private var sources:Object  = [];

private function init(required:Boolean, property:String):void{
	this.requiredFieldError = Manager.bundle.getMessage("error_val_requiredField");
	this.required = required;
	this.property = property;
}

public function showError(src:*, showErrorMessage:Boolean=true):Boolean{
	var event:ValidationResultEvent = getValidateEvent(src);
	if(event && event.type == ValidationResultEvent.INVALID){
		if(showErrorMessage == true)
	        showToolTip(src, event.message);
	   return false;
	}else{
		return true;
	}
}

public static function showToolTip(src:*, message:String):void{
	var y:Number = 0;
	var p:Point = new Point(src.x, src.y -  src.height);
	var parent:Container = src.parent as Container;
	var parentY:Function = function(parent:Container):int{
		var y:int = 0;
		while(parent){
			y += parent.y;
			parent = parent.parent as Container;
		}
		return y;
	};
	while(parent){
		var py:int = parent.contentToGlobal(p).y - parentY(parent);
		
		if(py < src.height && parent.verticalScrollPosition > y + src.y){
			parent.verticalScrollPosition = y + src.y;
			break;
		}
		var offset:int = (parent.horizontalScrollBar) ? parent.horizontalScrollBar.height : 0;
		if(py > parent.height - y - src.height * 2 - offset){
			parent.verticalScrollPosition = y + src.y + src.height + offset - parent.height;
		}
		y += parent.y;

		parent = parent.parent as Container;
	}
	setTimeout(createTooltip, 100, src, message);
}

private static function createTooltip(src:*, message:String):void{
	var toolTips:Object = [];
	var hideTooltip:Function = function(event:Event):void{
    	src.removeEventListener(FlexEvent.VALUE_COMMIT, hideTooltip);
    	src.removeEventListener(MouseEvent.MOUSE_OVER, hideTooltip);
    	src.systemManager.removeEventListener(MouseEvent.MOUSE_DOWN, hideTooltip);
    	src.systemManager.removeEventListener(Event.RESIZE, hideTooltip);
    	if(toolTips[src]){
    		ToolTipManager.destroyToolTip(toolTips[src]);
    		delete toolTips[src];
    	}
    };
	src.addEventListener(FlexEvent.VALUE_COMMIT, hideTooltip);
	src.addEventListener(MouseEvent.MOUSE_OVER, hideTooltip);
	src.systemManager.addEventListener(MouseEvent.MOUSE_DOWN, hideTooltip);
	src.systemManager.addEventListener(Event.RESIZE, hideTooltip, false, 0, true);

	var pt1:Point = new Point(src.x, src.y);
    var pt2:Point = src.contentToGlobal(pt1);
	toolTips[src] = ToolTipManager.createToolTip(message, pt2.x - pt1.x + src.width + 4, pt2.y - pt1.y - 1, "errorTipRight");
}

public function isValidField(src:DisplayObject):Boolean{
	var event:ValidationResultEvent = getValidateEvent(src);
	return (event == null) ? false : (event.type == ValidationResultEvent.VALID);
}

public function getValidateEvent(src:DisplayObject):ValidationResultEvent{
	if(!src || src.visible == false) return null;
	this.source = src;
	sources[src] = src;
	return validate();
}

public function reset():void{
	for(var i:String in sources){
		this.source = sources[i];
		if(this.source){
			dispatchEvent(new ValidationResultEvent(ValidationResultEvent.VALID));
			delete sources[i];
		}
	}
}

public function get invalidFields():Array{
	var list:Array = [];
	for(var i:String in sources){
		this.source = sources[i];
		if(validate().type == ValidationResultEvent.INVALID){
			list.push(this.source);
		}
	}
	return list;
}
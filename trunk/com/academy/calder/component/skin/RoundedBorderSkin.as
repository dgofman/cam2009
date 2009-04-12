package com.academy.calder.component.skin
{
	import flash.display.Graphics;
    import mx.graphics.RectangularDropShadow;
    import mx.skins.RectangularBorder;
    
    public class RoundedBorderSkin extends RectangularBorder {
	
		protected var ds:RectangularDropShadow;
		
        override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
            super.updateDisplayList(unscaledWidth, unscaledHeight);
            var cornerRadius:Number = getStyle("cornerRadius");
            var backgroundColor:int = getStyle("backgroundColor");
            var backgroundAlpha:Number = getStyle("backgroundAlpha");
            graphics.clear();
            
            if(!ds){
                ds = new RectangularDropShadow();
	            ds.distance = 5;
    	        ds.angle = 45;
        	    ds.color = 0;
            	ds.alpha = 0.4;
	            ds.tlRadius = cornerRadius;
    	        ds.trRadius = cornerRadius;
        	    ds.blRadius = cornerRadius;
            	ds.brRadius = cornerRadius;
            }
            // Background
            drawRoundRect(0, 0, unscaledWidth, unscaledHeight, {tl:ds.tlRadius, tr:ds.trRadius, bl:ds.blRadius, br:ds.brRadius}, backgroundColor, backgroundAlpha);
        }
    }
}
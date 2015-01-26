package com.game.scenes {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class BackButton extends MovieClip {
		
		public var back_mc:MovieClip;
		
		public function BackButton() {
			this.addEventListener(Event.ADDED_TO_STAGE, GetElements);
			
			back_mc.addEventListener(MouseEvent.MOUSE_OVER, OnMouseOver);
			back_mc.addEventListener(MouseEvent.MOUSE_OUT, OnMouseOut);
		}
		
		private function GetElements(e:Event)
		{
			back_mc.mouseChildren = false;
		}
		
		public function AddMouseUpEventListener(func:Function)
		{
			back_mc.addEventListener(MouseEvent.MOUSE_UP, func);
		}
		
		public function RemoveMouseUpEventListener(func:Function)
		{
			back_mc.removeEventListener(MouseEvent.MOUSE_UP, func);
		}
		
		function OnMouseOver(e:MouseEvent)
		{
			this.alpha = 0.8;
		}
		
		function OnMouseOut(e:MouseEvent)
		{
			this.alpha = 1;
		}
	}
	
}

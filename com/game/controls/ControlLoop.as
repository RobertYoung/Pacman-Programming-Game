package com.game.controls {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.game.elements.Stack;
	import flash.text.TextField;
	import flash.events.Event;
	import com.greensock.loading.LoaderMax;
	import com.game.factory.Game;
	import com.game.scenes.Controls;
	
	public class ControlLoop extends Control {
		
		public var loopTimes_txt:TextField;
		
		public function ControlLoop() {
			this.x = super.nX
			this.y = super.nY;
			
			this.controlName = "Loop";
			this.controlDescription = "";
		}
		
		override function AddControlToStack(e:MouseEvent, stackPosition:Stack)
		{
			super.AddControlToStack(e, stackPosition);
			
			var controls:Controls = LoaderMax.getContent(Game.SWF_CONTROLS).rawContent as Controls;
			
			if (controls){
				this.gotoAndStop(controls.GetCurrentSymbol() + 3);
			}
			this.loopTimes_txt.restrict = "0-9";
		}
		
		public function GetLoopTimes():Number
		{
			return parseInt(this.loopTimes_txt.text) as Number;
		}
	}
	
}

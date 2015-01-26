package com.game.scenes {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.greensock.loading.LoaderMax;
	import com.game.factory.Game;
	import fl.containers.ScrollPane;
	import flash.events.Event;
	import com.game.elements.HelpText;
	
	public class Help extends MovieClip {
		
		private var backButton:BackButton;
		private var main:Main;
		public var helpScrollPane:ScrollPane;
		
		public function Help() {
			this.addEventListener(Event.ADDED_TO_STAGE, AddedToStage);
		}
		
		public function Init() 
		{
			main = this.stage.getChildAt(0) as Main;
			backButton = LoaderMax.getContent(Game.SWF_BACK_BUTTON).rawContent as BackButton;
			backButton.AddMouseUpEventListener(BackButtonMouseUp);
		}
		
		public function AddedToStage(e:Event)
		{
			var helpText:HelpText = new HelpText();
			
			helpScrollPane.source = helpText;
		}
		
		private function BackButtonMouseUp(e:MouseEvent)
		{
			main.GoToMenu();
		}
	}
	
}

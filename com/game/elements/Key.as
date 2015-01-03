package com.game.elements {
	
	import flash.display.MovieClip;
	import com.game.*;
	import com.game.objects.KeyObject;
	import flash.text.TextField;
	
	public class Key extends MovieClip {
		
		public var key:KeyObject;
		public var numberOfKeys_txt:TextField;
		
		public function Key(setKey:KeyObject) {
			key = setKey;
			
			UpdateKey();
		}
		
		public function UpdateKey() 
		{
			this.numberOfKeys_txt.text = key.numberOfKeys.toString();
			this.key.actualNumberOfKeys = key.numberOfKeys;
		}
	}
	
}

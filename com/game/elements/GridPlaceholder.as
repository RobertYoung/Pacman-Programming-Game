package com.game.elements {
	
	import flash.display.MovieClip;
	import com.game.elements.gridblocks.GridBlock;
	
	public class GridPlaceholder extends MovieClip {
		
		public var gridBlock:String;
		
		public function GridPlaceholder() {

		}
		
		public function SetGridBlock(newGridBlock:String)
		{
			gridBlock = newGridBlock;
		}
		
		// Returns the Grid block on the placeholder
		public function GetGridBlockMovieClip():GridBlock
		{
			return this.getChildByName(this.gridBlock) as GridBlock;
		}
		
		public function ElementExists(elementName:String):Boolean
		{
			if (this.getChildByName(elementName) == null)
				return false;
			
			return true;
		}
		
		public function RemoveChildByName(childName:String)
		{
			var findChild = this.getChildByName(childName);
			
			if (findChild != null)
			{
				this.removeChild(findChild);
				return;
			}
			
			throw new Error("Error: Cannot find child to remove");
		}
		
		//******************//
		// HELPER FUNCTIONS //
		//******************//
		public function TraceChildren()
		{
			for (var i = 0; i < this.numChildren; i++)
			{
				trace("Object: " + this.getChildAt(i) + " Name: " + this.getChildAt(i).name);
			}
		}
	}
	
}

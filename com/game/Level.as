package com.game {
	
	import com.game.Grid;
	
	public class Level {

		public var grids:Array = new Array();
		
		// Row 1 
		public var row1_col1:Grid = new Grid();
		public var row1_col2:Grid = new Grid();
		public var row1_col3:Grid = new Grid();
		public var row1_col4:Grid = new Grid();
		public var row1_col5:Grid = new Grid();
		public var row1_col6:Grid = new Grid();
		public var row1_col7:Grid = new Grid();
		public var row1_col8:Grid = new Grid();

		// Row 2
		public var row2_col1:Grid = new Grid();
		public var row2_col2:Grid = new Grid();
		public var row2_col3:Grid = new Grid();
		public var row2_col4:Grid = new Grid();
		public var row2_col5:Grid = new Grid();
		public var row2_col6:Grid = new Grid();
		public var row2_col7:Grid = new Grid();
		public var row2_col8:Grid = new Grid();
		
		// Row 3
		public var row3_col1:Grid = new Grid();
		public var row3_col2:Grid = new Grid();
		public var row3_col3:Grid = new Grid();
		public var row3_col4:Grid = new Grid();
		public var row3_col5:Grid = new Grid();
		public var row3_col6:Grid = new Grid();
		public var row3_col7:Grid = new Grid();
		public var row3_col8:Grid = new Grid();
		
		// Row 4
		public var row4_col1:Grid = new Grid();
		public var row4_col2:Grid = new Grid();
		public var row4_col3:Grid = new Grid();
		public var row4_col4:Grid = new Grid();
		public var row4_col5:Grid = new Grid();
		public var row4_col6:Grid = new Grid();
		public var row4_col7:Grid = new Grid();
		public var row4_col8:Grid = new Grid();
		
		// Row 5
		public var row5_col1:Grid = new Grid();
		public var row5_col2:Grid = new Grid();
		public var row5_col3:Grid = new Grid();
		public var row5_col4:Grid = new Grid();
		public var row5_col5:Grid = new Grid();
		public var row5_col6:Grid = new Grid();
		public var row5_col7:Grid = new Grid();
		public var row5_col8:Grid = new Grid();
		
		// Row 6
		public var row6_col1:Grid = new Grid();
		public var row6_col2:Grid = new Grid();
		public var row6_col3:Grid = new Grid();
		public var row6_col4:Grid = new Grid();
		public var row6_col5:Grid = new Grid();
		public var row6_col6:Grid = new Grid();
		public var row6_col7:Grid = new Grid();
		public var row6_col8:Grid = new Grid();
		
		// Row 7
		public var row7_col1:Grid = new Grid();
		public var row7_col2:Grid = new Grid();
		public var row7_col3:Grid = new Grid();
		public var row7_col4:Grid = new Grid();
		public var row7_col5:Grid = new Grid();
		public var row7_col6:Grid = new Grid();
		public var row7_col7:Grid = new Grid();
		public var row7_col8:Grid = new Grid();
		
		// Row 8
		public var row8_col1:Grid = new Grid();
		public var row8_col2:Grid = new Grid();
		public var row8_col3:Grid = new Grid();
		public var row8_col4:Grid = new Grid();
		public var row8_col5:Grid = new Grid();
		public var row8_col6:Grid = new Grid();
		public var row8_col7:Grid = new Grid();
		public var row8_col8:Grid = new Grid();

		
		public function Level() {
			// constructor code
		}
		
		public function ConstructLevel() {
			
			for (var row = 1; row <= 8; row++)
			{
				for (var col = 1; col <= 8; col++)
				{
					grids.push(this["row" + row + "_col" + col]);
				}
			}
		}
	}
	
}

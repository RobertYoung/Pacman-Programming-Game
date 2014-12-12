package com.game {
	
	import com.game.Grid;
	
	public class Level {

		public var grids:Array = new Array();
		
		// Row Variables
		public var row1_col1, row1_col2, row1_col3, row1_col4, row1_col5, row1_col6, row1_col7, row1_col8:Grid;
		public var row2_col1, row2_col2, row2_col3, row2_col4, row2_col5, row2_col6, row2_col7, row2_col8:Grid;
		public var row3_col1, row3_col2, row3_col3, row3_col4, row3_col5, row3_col6, row3_col7, row3_col8:Grid;
		public var row4_col1, row4_col2, row4_col3, row4_col4, row4_col5, row4_col6, row4_col7, row4_col8:Grid;
		public var row5_col1, row5_col2, row5_col3, row5_col4, row5_col5, row5_col6, row5_col7, row5_col8:Grid;
		public var row6_col1, row6_col2, row6_col3, row6_col4, row6_col5, row6_col6, row6_col7, row6_col8:Grid;
		public var row7_col1, row7_col2, row7_col3, row7_col4, row7_col5, row7_col6, row7_col7, row7_col8:Grid;
		public var row8_col1, row8_col2, row8_col3, row8_col4, row8_col5, row8_col6, row8_col7, row8_col8:Grid;
		
		public function Level() {
			// Assign all grid variables with the row and column properties added
			for (var row = 1; row <= 8; row++)
			{
				for (var col = 1; col <= 8; col++)
				{
					this["row" + row + "_col" + col] = new Grid(row, col, Grid.BOX);
				}
			}
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

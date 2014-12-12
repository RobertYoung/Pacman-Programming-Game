package com.game {
	
	import com.game.Grid;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import com.adobe.serialization.json.JSONDecoder;
	import flash.events.Event;
	import flash.display.MovieClip;
	
	public class Level {

		// List of required grids for the level
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
		
		// URL Loader and Request to fetch JSON
		var loader:URLLoader = new URLLoader();
		var request:URLRequest = new URLRequest();	
		
		// Instance of the main stage
		var main:MovieClip;
		
		public function Level(mc:MovieClip, urlOfJSON:String = "") {
			// Assign all grid variables with the row and column properties added
			for (var row = 1; row <= 8; row++)
			{
				for (var col = 1; col <= 8; col++)
				{
					this["row" + row + "_col" + col] = new Grid(row, col, Grid.BOX);
				}
			}

			main = mc;
			
			request.url = urlOfJSON;
			loader.load(request);

			loader.addEventListener(Event.COMPLETE, JSONLoadComplete);
		}
		
		public function CreateArrayOfGrids() {
			
			for (var row = 1; row <= 8; row++)
			{
				for (var col = 1; col <= 8; col++)
				{
					grids.push(this["row" + row + "_col" + col]);
				}
			}
		}
		
		function JSONLoadComplete(e:Event):void
		{
			trace(loader.data);
			
			var jsonData = new JSONDecoder(loader.data, false).getValue();

			// Go through each object from the JSON data and create a Grid
			// object to store in the levels list
			for (var rows in jsonData)
			{
				for (var rowNumber in jsonData[rows])
				{
					for (var columns in jsonData[rows][rowNumber])
					{
						for (var columnNumber in jsonData[rows][rowNumber][columns])
						{
							// Get the grid block for each grid in the JSON
							var gridBlock = jsonData[rows][rowNumber][columns][columnNumber].gridBlock
							
							this["row" + rowNumber + "_col" + columnNumber].SetGridBlockAndElements(gridBlock); 
						}
					}
						
				}
			}
			
			// Store all the grids in an array
			CreateArrayOfGrids();
			
			// Create the stage and add to the view
			var pacmanStage:PacmanStage = new PacmanStage(this);

			pacmanStage.x = 300;
			pacmanStage.y = 400;

			main.stage.addChild(pacmanStage);
		}
	}
	
}

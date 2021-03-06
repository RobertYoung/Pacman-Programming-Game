﻿package com.game.elements {
	
	import com.game.elements.Grid;
	import com.game.scenes.PacmanStage;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import com.adobe.serialization.json.JSONDecoder;
	import flash.events.Event;
	import flash.display.MovieClip;
	import com.game.factory.Game;
	import flash.system.Security;
	
	public class Level {

		//*******************************//
		// LIST OF GRIDS TO BE DISPLAYED //
		//*******************************//
		public var grids:Array = new Array();
		
		//******************//
		// LEVEL PROPERTIES //
		//******************//
		public var stageNumber:int = 0;
		public var levelNumber:int = 0;
		
		//*************************************//
		// ALL THE GRID VARIABLES OF TYPE GRID //
		//*************************************//
		public var row1_col1, row1_col2, row1_col3, row1_col4, row1_col5, row1_col6, row1_col7, row1_col8:Grid;
		public var row2_col1, row2_col2, row2_col3, row2_col4, row2_col5, row2_col6, row2_col7, row2_col8:Grid;
		public var row3_col1, row3_col2, row3_col3, row3_col4, row3_col5, row3_col6, row3_col7, row3_col8:Grid;
		public var row4_col1, row4_col2, row4_col3, row4_col4, row4_col5, row4_col6, row4_col7, row4_col8:Grid;
		public var row5_col1, row5_col2, row5_col3, row5_col4, row5_col5, row5_col6, row5_col7, row5_col8:Grid;
		public var row6_col1, row6_col2, row6_col3, row6_col4, row6_col5, row6_col6, row6_col7, row6_col8:Grid;
		public var row7_col1, row7_col2, row7_col3, row7_col4, row7_col5, row7_col6, row7_col7, row7_col8:Grid;
		public var row8_col1, row8_col2, row8_col3, row8_col4, row8_col5, row8_col6, row8_col7, row8_col8:Grid;
		
		//**********************************//
		// VARIABLES TO FETCH THE JSON DATA //
		//**********************************//
		var loader:URLLoader = new URLLoader();
		var request:URLRequest = new URLRequest();	
		
		//******************************************************//
		// INSTANCE OF THE MOVIECLIP THAT INITILIZED THIS CLASS //
		//	- Used so this class knows where to add the stage   //
		//******************************************************//
		var main:MovieClip;
		
		//*******************//
		// LEVEL CONSTRUCTOR //
		//*******************//
		public function Level(mc:MovieClip, setStageNumber:int, setLevelNumber:int) {
			flash.system.Security.allowDomain("*");
			// On initilization, create all the grid variables with the correct 
			// column and row 
			// They are given a default grid block of BOX
			for (var row = 1; row <= 8; row++)
			{
				for (var col = 1; col <= 8; col++)
				{
					this["row" + row + "_col" + col] = new Grid(row, col, Grid.BOX);
				}
			}

			main = mc;
			
			request.url = "../assets/levels/level" + setStageNumber + "-" + setLevelNumber + ".json";
			loader.load(request);

			loader.addEventListener(Event.COMPLETE, JSONLoadComplete);
			
			this.stageNumber = setStageNumber;
			this.levelNumber = setLevelNumber;
		}
		
		//*******************************************//
		// STORES ALL THE GRID VARIABLES IN AN ARRAY //
		//*******************************************//
		public function CreateArrayOfGrids() {
			
			for (var row = 1; row <= 8; row++)
			{
				for (var col = 1; col <= 8; col++)
				{
					grids.push(this["row" + row + "_col" + col]);
				}
			}
		}
		
		//**********************//
		// PARSES THE JSON DATA //
		//**********************//
		function JSONLoadComplete(e:Event):void
		{
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
							// The grid variable
							var grid = this["row" + rowNumber + "_col" + columnNumber];
							
							// Get the grid block for each grid in the JSON
							var jsonGridData = jsonData[rows][rowNumber][columns][columnNumber];
							
							// Get the grid block type
							if (jsonGridData.gridBlock)
								grid.SetGridBlock(jsonGridData.gridBlock);
							
							// Get Pacman start position
							if (jsonGridData.pacman)
								grid.SetPacmanStart(jsonGridData.pacman);
							
							// Get reward
							if (jsonGridData.reward)
								grid.SetReward(jsonGridData.reward);
							
							// Get monster
							if (jsonGridData.monster)
								grid.SetMonster(jsonGridData.monster);
							
							// Get door
							if (jsonGridData.door)
								grid.SetDoor(jsonGridData.door);
							
							// Get hole
							if (jsonGridData.hole)
								grid.SetHole(jsonGridData.hole);
							
							// Get keys
							if (jsonGridData.key)
								grid.SetKey(jsonGridData.key.isKey, jsonGridData.key.numberOfKeys);
						}
					}
						
				}
			}
			
			// Store all the grids in an array
			CreateArrayOfGrids();
			
			// Check if there are holes to add a monster in a random place
			//ImplementHoleWithMonster();
			
			// Create the stage and add to the view
			/*
			var pacmanStage:PacmanStage = new PacmanStage(this);

			pacmanStage.x = 280;
			pacmanStage.y = 400;
			pacmanStage.name = Game.SWF_PACMAN_STAGE;

			main.addChild(pacmanStage);
			*/
		}
		
		public function ImplementHoleWithMonster()
		{
			var gridsWithHole:Array = new Array();
			
			// Find all the grids with holes
			for (var i = 0; i < grids.length; i++)
			{
				var myGrid:Grid = grids[i] as Grid;
				
				// Add int position of grid in grids array
				if (myGrid.hole){
					gridsWithHole.push(i);
					myGrid.holeWithMonster = false;
				}
			}
			
			// Randomly select a grid
			var randomNumber = (Math.floor(Math.random() * ((gridsWithHole.length - 1) - 0 + 1)) + 0);
			
			trace("Random Monster Number: " + randomNumber);
			
			// Set the randomly selected grid with hole to true for a monster
			if (gridsWithHole.length > 0)
				grids[gridsWithHole[randomNumber]].holeWithMonster = true;
		}
	}
	
}

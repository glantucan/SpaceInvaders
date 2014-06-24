package game.gamerounds 
{
	import com.greensock.TimelineLite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import game.ProjectileList;
	import game.ships.HeroShip;
	import game.UpdatableList;
	/**
	 * ...
	 * @author Glantucan
	 */
	public class AGameRound 
	{
		protected var battleField:MovieClip;
		protected var timeline:TimelineLite;
		
		protected var formationWidth:Number;
		protected var formationMargin:Number;
		protected var battleWidth:Number;
		protected var enemyCols:int;
		protected var enemyRows:int;
		protected var totalVDrift:Number;
		protected var vDriftsCount:int;
		
		private var frameCount:int;
		
		protected var updatableObjects:UpdatableList;
		protected var heroProjectiles:ProjectileList;
		protected var alienProjectiles:ProjectileList;
		protected var hero:HeroShip;
		
		/**
		 * battleField must have a reference_mc movieclip wich covers the total width and height of the battleField.
		 * @param	battleField must have a MovieClip with an instance name of "reference_mc"  wich covers the total 
		 * 			width and height of the battleField.
		 */
		public function AGameRound(battleField:MovieClip) 
		{
			this.battleField = battleField;
			

			battleWidth = battleField.reference_mc.width;
			formationWidth = 0.6 * battleWidth;
			formationMargin =  0.05 * battleWidth;
			
			timeline = new TimelineLite();
			
			// Creamos las listas de proyectiles y de objetos a actualizar en cada fotograma
			updatableObjects = new UpdatableList();
			heroProjectiles = new ProjectileList();
			alienProjectiles = new ProjectileList();
		}
		
		
		
		public function buildRound():void
		{
			createBackground();
			createAndConfigureShips();
		}
		 
		public function startRound():void
		{
			battleField.stage.addEventListener(Event.ENTER_FRAME, enCadaFrame);
		}
		
		public function endRound():void
		{
			trace("round finished");
			//battleField.removeEventListener(Event.ENTER_FRAME, enCadaFrame);
		}
		
		
		protected function createBackground():void { }
		
		protected function createAndConfigureShips():void { }
		
		
		
		private function enCadaFrame(e:Event):void 
		{
			updatableObjects.update(frameCount);
			
			if (updatableObjects.length == 1 || hero.destroyed)
			{
				endRound();
			}
			frameCount++;
		}
		
		
		
		
	}

}
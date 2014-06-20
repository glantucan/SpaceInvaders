package game.gamerounds 
{
	import com.greensock.data.TweenLiteVars;
	import com.greensock.TimelineLite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import game.AUpdater;
	import game.GameUpdater;
	import game.projectiles.AProjectile;
	import game.ships.AShip;
	import game.AUpdater;
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
		
		protected var updater:GameUpdater;
		protected var collisionChecker:AUpdater;
		
		
		
		/**
		 * battleField must have a reference_mc movieclip wich covers the total width and height of the battleField.
		 * @param	battleField must have a MovieClip with an instance name of "reference_mc"  wich covers the total 
		 * 			width and height of the battleField.
		 * @param	updater
		 */
		public function AGameRound(battleField:MovieClip, updater:GameUpdater, collisionChecker:AUpdater) 
		{
			this.battleField = battleField;
			this.updater = updater;
			this.collisionChecker = collisionChecker;
			
			battleWidth = battleField.reference_mc.width;
			formationWidth = 0.6 * battleWidth;
			formationMargin =  0.05 * battleWidth;
			
			timeline = new TimelineLite();
		}
		
		
		/**
		 * Template
		 */
		public function buildRound():void
		{
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
		
		
		public function addEnemyProjectile(projectile:AProjectile):void
		{
			updater.addEnemyProjectile(projectile);
			collisionChecker.addEnemyProjectile(projectile);
		}
		
		public function removeEnemyProjectile(projectile:AProjectile):void
		{
			updater.removeEnemyProjectile(projectile)
			collisionChecker.removeEnemyProjectile(projectile)
		}
		
		public function addHeroProjectile(projectile:AProjectile):void
		{
			updater.addHeroProjectile(projectile);
			collisionChecker.addHeroProjectile(projectile);
		}
		
		public function removeHeroProjectile(projectile:AProjectile, collision:Boolean = false):void
		{
			updater.removeHeroProjectile(projectile);
			if(collision) collisionChecker.removeHeroProjectile(projectile);
		}
		
		protected function createAndConfigureShips():void { }
		
		protected function enCadaFrame(e:Event):void 
		{
			
			updater.update(frameCount);
			updater.disposeAllDestroyed();
			collisionChecker.disposeAllDestroyed();
			
			collisionChecker.update(frameCount);
			if (updater.checkRoundEnd())
			{
				endRound();
			}
			frameCount++;
		}
		
		
		
		
	}

}
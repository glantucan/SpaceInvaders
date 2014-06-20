package game 
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import game.projectiles.AProjectile;
	import game.ships.AShip;
	/**
	 * ...
	 * @author Glantucan
	 */
	public class GameUpdater extends AUpdater 
	{
		private var debugSprite:Sprite;
		
		public function GameUpdater(debugSprite:Sprite) 
		{
			super();
			this.debugSprite = debugSprite;
		}
		
		override public function update(frame:int):void 
		{
			
			_heroShip.update();
			
			var enemyProjCount:int = enemyProjectiles.length;
			var curEnemy:AShip;
			for (var i:int = 0; i < enemyProjCount; i++) 
			{
				curProjectile = enemyProjectiles[i];
				curProjectile.update();
			}
			
			var enemyShipsCount:int = enemyShips.length;
			var curProjectile:AProjectile;
			for (var j:int = 0; j < enemyShipsCount; j++) 
			{
				curEnemy = enemyShips[j];
				if (!curEnemy.disposed) 
				{
					curEnemy.update();
				}
			}
			
			var heroProjCount:int = heroProjectiles.length;
			for (var k:int = 0; k < heroProjCount; k++) 
			{
				curProjectile = heroProjectiles[k];
				curProjectile.update();
			}
		}
		
		public function checkRoundEnd():Boolean
		{
			if (enemyProjectiles.length == 0 && enemyShips.length == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
	}

}
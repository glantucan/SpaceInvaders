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
			
			debugSprite.graphics.clear();
			
			var curProjectile:AProjectile;
			var curEnemy:AShip;
			
			_heroShip.update();
			
			var enemyProjCount:int = enemyProjectiles.length;
			for (var i:int = 0; i < enemyProjCount; i++) 
			{
				curProjectile = enemyProjectiles[i];
				curProjectile.update();
			}
			
			var enemyShipsCount:int = enemyShips.length;
			for (var j:int = 0; j < enemyShipsCount; j++) 
			{
				curEnemy = enemyShips[j];
				if (!curEnemy.disposed) 
				{
					curEnemy.update();
					
					/*if (curEnemy.getSkin())
					{
						var rect:Rectangle = curEnemy.getCollider();
						debugSprite.graphics.lineStyle(1, 0x000000 );
						debugSprite.graphics.drawRect(rect.x, rect.y, rect.width, rect.height);
					}*/
				}
			}
			
			var heroProjCount:int = heroProjectiles.length;
			for (var k:int = 0; k < heroProjCount; k++) 
			{
				curProjectile = heroProjectiles[k];
				curProjectile.update();
				
				/*if (curProjectile.skin)
				{
					rect = curProjectile.getCollider();
					if (rect)
					{
						debugSprite.graphics.lineStyle(1, 0x000000 );
						debugSprite.graphics.drawRect(rect.x, rect.y, rect.width, rect.height);
					}
				}*/
			}
			
			
		}
		
		
		override public function removeHeroProjectile(projectile:AProjectile):void 
		{
			trace("projectile " + projectile.id + " ------->> Removed from game updater")
			trace();
			super.removeHeroProjectile(projectile);
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
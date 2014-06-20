package game 
{
	import flash.geom.Rectangle;
	import game.projectiles.AProjectile;
	import game.ships.AShip;
	
	/**
	 * ...
	 * @author Glantucan
	 */
	public class CollisionChecker extends AUpdater 
	{
		
		public function CollisionChecker() 
		{
			super();
			
		}
		
		override public function update(frame:int):void
		{
			var enemyProjCount:int = enemyProjectiles.length;
			
			
			var disposableHProjCount:int;
			var disposableEShipsCount:int;
			
			// Check for hero impacts 
			var heroCollider:Rectangle = _heroShip.getCollider();
			var curProjectile:AProjectile;
			
			for (var i:int = 0; i < enemyProjCount; i++) 
			{
				curProjectile = enemyProjectiles[i];
				if ( heroCollider.intersects( curProjectile.getCollider() ) )
				{
					_heroShip.takeDamage(curProjectile);
				}
			}
			
			var curEnemy:AShip;
			var curEnemyCollider:Rectangle;
			
			var enemyShipsCount:int = enemyShips.length;
			for (var j:int = 0; j < enemyShipsCount; j++) 
			{
				curEnemy = enemyShips[j];
				curEnemyCollider = curEnemy.getCollider();
				
				
				var heroProjCount:int = heroProjectiles.length;
				for (var k:int = 0; k < heroProjCount; k++) 
				{
					curProjectile = heroProjectiles[k];
					
					if (!curEnemy.destroyed)
					{
						if (curEnemyCollider.intersects( curProjectile.getCollider() ) )
						{
							trace("Frame " + frame + ":" + curProjectile.id + " inpact on " + curEnemy.id);
							trace("Projectile collider: " + curProjectile.getCollider());
							trace("Projectile collider: " + curEnemyCollider);
							//trace();
							
							
							curEnemy.takeDamage(curProjectile);
							// Check if curEnemy has't been destroyed by another projectile
							if (curEnemy.destroyed)
							{
								// Ship is destroyed. We need to avaoid checking the same ship again
								removeEnemyShip(curEnemy);
							}
							
							curProjectile.hit();
							// Projectile is destroyed. We need to avaoid checking the same projectile again
							// So we add it to the list of to be disposed projectiles 
							removeHeroProjectile(curProjectile);
						}
					}
				}
				
				// Finished checking the hero projectiles list. Dispose destroyed ones:
				if (disposableHProj.length > 0)
				{
					trace("Collision disposable projectiles: " + disposableHProj.length, disposableHProj.join(","));
					disposeDestroyedObjects(heroProjectiles, disposableHProj);
					trace("Collision disposable projectiles after cleaning: " + disposableHProj.length, disposableHProj.join(","));
					trace("Collision projectiles left: " + heroProjectiles.length, heroProjectiles.join(","));
				}
			}
			
			// Finished checking the enemy ships list. Dispose destroyed ones:
			disposeDestroyedObjects(enemyShips, disposableEShips);
		}
	}

}
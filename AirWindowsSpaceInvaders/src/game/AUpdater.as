package game 
{
	import flash.geom.Rectangle;
	import game.projectiles.AProjectile;
	import game.ships.AShip;
	/**
	 * ...
	 * @author Glantucan
	 */
	public class AUpdater 
	{
		
		// Array of enemy Ships 
		protected var enemyShips:Array;
		
		protected var _heroShip:AShip;
		
		// Array of enemy projectiles
		protected var enemyProjectiles:Array;
		
		// Array of hero projectiles
		protected var heroProjectiles:Array;
		
		protected var disposableEProj:Array;
		protected var disposableHProj:Array;
		protected var disposableEShips:Array;
		
		public function AUpdater() 
		{
			
			enemyShips = [];
			enemyProjectiles = [];
			heroProjectiles = [];
			
			disposableEProj = [];
			disposableHProj = [];
			disposableEShips = [];
		}
		
		
		
		public function set heroShip(value:AShip):void 
		{
			_heroShip = value;
		}
		
		public function addEnemyShip(ship:AShip):void
		{
			enemyShips.push(ship);
		}
		
		public function removeEnemyShip(ship:AShip):void
		{
			disposableEShips.push(ship);
		}
		
		public function addEnemyProjectile(projectile:AProjectile):void
		{
			enemyProjectiles.push(projectile);
		}
		
		public function removeEnemyProjectile(projectile:AProjectile):void
		{
			disposableEProj.push(projectile);
		}
		
		public function addHeroProjectile(projectile:AProjectile):void
		{
			heroProjectiles.push(projectile);
		}
		
		public function removeHeroProjectile(projectile:AProjectile):void
		{
			disposableHProj.push(projectile);
		}
		
		
		public function update(frame:int):void
		{
			
		}
		
		public function disposeAllDestroyed():void
		{
			disposeDestroyedObjects(heroProjectiles, disposableHProj);
			disposeDestroyedObjects(enemyShips, disposableEShips);
			disposeDestroyedObjects(enemyProjectiles, disposableEProj);
		}
		
		public function disposeDestroyedObjects(objects:Array, disposable:Array):void
		{
			var disposableCount:int = disposable.length;
			
			for (var i:int = 0; i < disposableCount ; i++) 
			{
				trace("disposing " + disposable[i].id)
				objects.splice( objects.indexOf( disposable[i] ), 1 );
			}
			if (disposable.length > 0)
			{
				
				disposable.splice(0);
				
			}
		}
		
		
		
		
	}

}
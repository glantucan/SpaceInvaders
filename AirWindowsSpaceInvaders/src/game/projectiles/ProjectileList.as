package game.projectiles {
	import adobe.utils.CustomActions;
	import flash.geom.Rectangle;
	import game.ships.AShip;
	/**
	 * ...
	 * @author Glantucan
	 */
	public class ProjectileList 
	{
		
		private var projectiles:Array;
		private var disposables:Array;
		
	
		public function ProjectileList() 
		{
			projectiles = new Array();
			disposables = new Array();
		}
		
		
		/**
		 * Añade un objeto a la lista
		 * @param	projectile
		 */
		public function add(projectile:AProjectile):void
		{
			projectiles.push(projectile);
		}

		
		/**
		 * Este método no elimina directamente el objeto de la lista, lo marca para su eliminación
		 * en la fase de limpieza (método clean())
		 * Si se eliminara directamente mientras se setá recoriendo la lista con un bucle, 
		 * tendríamos serios problemas, por que los índices del array ya no corresponderían 
		 * al objeto que esperamos
		 * @param	projectile
		 */
		public function remove(projectile:AProjectile):void
		{
			disposables.push(projectile);
		}
		
		
		/**
		 * Comprueba las colisiones entre la nave especificada y todos los proyectiles de la lista.
		 * @param	ship
		 */
		public function collisionCheck(ship:AShip):void
		{
			if (!ship.destroyed)
			{
				var numProjectiles:int = projectiles.length;
				var shipCollider:Rectangle = ship.collider;
				
				var curProj:AProjectile;
				
				for (var i:int = 0; i < numProjectiles; i++) 
				{
					curProj = projectiles[i]
					if (!curProj.destroyed)
					{
						if ( shipCollider.intersects( curProj.collider ) )
						{
							ship.takeDamage(curProj);
							curProj.hit();
						}
					}
				}
			}
			
			if (disposables.length > 0)
			{
				clean();
			}
		}
		
		
		/**
		 * Elimina definitivamente los projectiles que han sido destruidos de la lista.
		 */
		public function clean():void
		{
			var toRemoveCount:int = disposables.length;
			
			// Recorremos la lista de projectiles a eliminar y los eliminamos definitivamente de la lista
			// de proyectiles.
			for (var i:int = 0; i < toRemoveCount ; i++) 
			{
				//trace("Projectile " + disposables[i].id + " cleaned form projectile list");
				//trace(toRemoveCount,disposables[i],projectiles.indexOf( disposables[i]));
				projectiles.splice( projectiles.indexOf( disposables[i] ), 1 );
			}
			
			// Limpiar la lista de proyectiles a eliminar
			disposables.splice(0);
		}
		
	}

}
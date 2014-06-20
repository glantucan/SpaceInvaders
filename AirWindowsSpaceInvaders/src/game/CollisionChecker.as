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
			// Comprobamos si hay colisiones entre los proyectiles enemigos y nuestra nave
			var enemyProjCount:int = enemyProjectiles.length;
			var heroCollider:Rectangle = _heroShip.getCollider();
			var curProjectile:AProjectile;
			for (var i:int = 0; i < enemyProjCount; i++) 
			{
				curProjectile = enemyProjectiles[i];
				// Si hay colisión (lo comprobamos con la intersección de los dos rectángulos)...
				if ( heroCollider.intersects( curProjectile.getCollider() ) )
				{
					// El proyectil le hace pupa a nuestra nave.
					_heroShip.takeDamage(curProjectile);
				}
			}
			
			// Comprobamos si hay colisiones entre nuestros proyectiles y cada nave enemiga
			var enemyShipsCount:int = enemyShips.length;
			var curEnemy:AShip;
			var curEnemyCollider:Rectangle;
			// Para cada nave enemiga...
			for (var j:int = 0; j < enemyShipsCount; j++) 
			{
				var heroProjCount:int = heroProjectiles.length;
				curEnemy = enemyShips[j];
				curEnemyCollider = curEnemy.getCollider();	
				// ... y para cada uno de nuestros proyectiles...
				for (var k:int = 0; k < heroProjCount; k++) 
				{
					curProjectile = heroProjectiles[k];
					// ... si esta nave no ha sido destruida ya por otro proyectil 
					// (no es estrictamente neesario hacer esta comprobación 
					// pero nos ahorra unas cuantas operaciones en algunas ocasiones)
					if (!curEnemy.destroyed)
					{
						// ...y hay colision entre el enemigo y el proyectil que estamos comprobando...
						if (curEnemyCollider.intersects( curProjectile.getCollider() ) )
						{
							// ... el proyectil le hace pupa al enemigo...
							curEnemy.takeDamage(curProjectile);
							// ... si despuñes de hacerle pupa el enemigo ha sido destruido...
							if (curEnemy.destroyed)
							{
								// ... quitamos al enemigo de la lista, ya no necesitamos comprobarlo más.
								removeEnemyShip(curEnemy);
								// Recuerda que este método no elimina el enemigo de la lista inmediatamente
								// para no modificar la lista mientras la está recorriendo el bucle. 
							}
							// ... y el proyectil se destruye
							curProjectile.hit();
							//... por tanto tenemos que añadirlo a la lista de nuestros proyectiles a eliminar
							removeHeroProjectile(curProjectile);
						}
					}
				}
				
				// Si hay proyectiles a eliminar, ahora es el momento, antes de realizar otra pasada sobre la 
				// lista de proyectiles para ver si chocan con el siguiente enemigo.
				if (disposableHProj.length > 0)
				{
					disposeDestroyedObjects(heroProjectiles, disposableHProj);
				}
			}
			
			// Hemos terminado de comprobar los choques de todos los proyectiles con todos los enemigos. 
			// Es el momento de eliminar todos los que han sido marcados como destruidos.
			disposeDestroyedObjects(enemyShips, disposableEShips);
		}
	}

}
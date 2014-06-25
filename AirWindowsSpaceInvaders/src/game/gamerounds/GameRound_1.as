package game.gamerounds 
{
	import com.greensock.TweenLite;
	import flash.display.MovieClip;
	import game.ships.EnemyShip;
	import game.ships.EnemyVanguard;
	import game.ships.HeroShip;
	/**
	 * ...
	 * @author Glantucan
	 */
	public class GameRound_1 extends AGameRound
	{
		
		
		/**
		 * Constructor
		 * @param	battleField Contenedor en el que colocamos todos los objetos del juego
		 */
		public function GameRound_1(battleField:MovieClip) 
		{
			super(battleField);
			
			// Aquí configuramos todas las propiedades específicas de la ronda 
			
			enemyCols = 8;
			enemyRows = 4;
			verticalStepDistance = 50;
			animationSteps = 10;
		}
		
		
		/**
		 * Sobreescritura del método que sirve para crear y configurar todas las naves de esta ronda
		 */
		override protected function createAndConfigureShips():void 
		{
			// Crear al heroe ;)
			hero = new HeroShip(battleField, "Hero", updatableObjects, heroProjectiles, alienProjectiles);
			hero.place( battleWidth / 2, battleField.reference_mc.height - hero.height / 2 );
			
			var enemySkins:Array = []; 
			var curEnemy:EnemyShip;
			
			var xPos:Number = 0;
			var yPos:Number = 100;
			
			//Doble bucle para crear y colocar las naves enemigas en formación 
			for (var i:int = 0; i < enemyCols ; i++) 
			{
				for (var k:int = 0; k < enemyRows; k++) 
				{
					curEnemy = new EnemyVanguard(battleField, "vanguard_" + i + "_" + k, updatableObjects, alienProjectiles, heroProjectiles);
					
					// utilizamos los valores definidos para colocar la formación de las naves alien
					xPos = formationMargin + i * formationWidth / (enemyCols - 1) ;
					yPos = 100 + k * verticalStepDistance;
					curEnemy.place(xPos, yPos);
					// añadimos la piel de cada nave enemiga a un array, para luego animar toda la formación de naves
					// del tirón
					enemySkins.push(curEnemy.getSkin());
				}
			}
			
			
			// Ahora configuramos la línea de tiempo de la animación de la formación de naves enemigas.
			
			var horizontalDistance:Number = battleWidth - formationWidth - formationMargin * 2;
			
			// Lo configuramos por pasos, añadiendo dos tweens (uno de movimiento horizontal y otro de movimiento vertical)
			// en cada uno, al final de la línea de tiempo.
			for (var j:int = 0; j < animationSteps; j++) 
			{
				if (j % 2 == 0)
				{
					// en los pasos pares movemos la formación de naves hacia la derecha (fijate en "+=" para la x)
					timeline.add(TweenLite.to ( enemySkins, 3, { x:"+=" + horizontalDistance.toString() } ) );
				}
				else
				{
					// en los impares movemos la formación de naves hacia la izquierda
					timeline.add(TweenLite.to ( enemySkins, 3, { x:"-=" + horizontalDistance.toString() } ) );
				}
				// En todos los pasos añadimos un desplazamiento en vertical hacia abajo
				timeline.add(TweenLite.to ( enemySkins, 1, { y:"+=" + verticalStepDistance.toString() } ) );
				
			}
		}
	}
}
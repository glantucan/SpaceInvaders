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
		
		
		
		public function GameRound_1(battleField:MovieClip) 
		{
			super(battleField);
			
			enemyCols = 8;
			enemyRows = 4;
			verticalStepDistance = 50;
			verticalStepNumber = 10;
		}
		
		
		
		override protected function createAndConfigureShips():void 
		{
			// Crear al heroe ;)
			hero = new HeroShip(battleField, "Hero", updatableObjects, heroProjectiles, alienProjectiles);
			hero.place( battleWidth / 2, battleField.reference_mc.height - hero.height / 2 );
			
			var enemySkins:Array = []; 
			var curEnemy:EnemyShip;
			
			var xPos:Number = 0;
			var yPos:Number = 100;
			
			for (var i:int = 0; i < enemyCols ; i++) 
			{
				for (var k:int = 0; k < enemyRows; k++) 
				{
					curEnemy = new EnemyVanguard(battleField, "vanguard_" + i + "_" + k, updatableObjects, alienProjectiles, heroProjectiles);
					xPos = formationMargin + i * formationWidth / (enemyCols - 1) ;
					yPos = 100 + k * 50;
					curEnemy.place(xPos, yPos);
					enemySkins.push(curEnemy.getSkin());
				}
			}
			
			
			// Configure movement of enemies
			
			var totalHDrift:Number = battleWidth - formationWidth - formationMargin * 2;
			
			for (var j:int = 0; j < verticalStepNumber; j++) 
			{
				if (j % 2 == 0)
				{
					timeline.add(TweenLite.to ( enemySkins, 3, { x:"+=" + totalHDrift.toString() } ) );
				}
				else
				{
					timeline.add(TweenLite.to ( enemySkins, 3, { x:"-=" + totalHDrift.toString() } ) );
				}
				timeline.add(TweenLite.to ( enemySkins, 1, { y:"+=" + verticalStepDistance.toString() } ) );
				
			}
		}
	}
}
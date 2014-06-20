package game.gamerounds 
{
	import com.greensock.data.TweenLiteVars;
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.ReturnKeyLabel;
	import game.AUpdater;
	import game.ships.AShip;
	import game.ships.EnemyShip;
	import game.ships.EnemyVanguard;
	import game.ships.HeroShip;
	import game.AUpdater;
	/**
	 * ...
	 * @author Glantucan
	 */
	public class GameRound_1 extends AGameRound
	{
		
		
		public function GameRound_1(battleField:MovieClip, updater:AUpdater, collisionChecker:AUpdater) 
		{
			super(battleField, updater, collisionChecker);
			
			enemyCols = 8;
			enemyRows = 4;
			totalVDrift = 50;
			vDriftsCount = 10;
		}
		
		
		
		override protected function createAndConfigureShips():void 
		{
			var hero:HeroShip = new HeroShip(battleField, this);
			hero.place( battleWidth / 2, battleField.reference_mc.height - hero.getCollider().height / 2 );
			updater.heroShip = hero;
			collisionChecker.heroShip = hero;
			
			var enemySkins:Array = []; 
			var curEnemy:EnemyShip;
			
			var xPos:Number = 0;
			var yPos:Number = 100;
			
			for (var i:int = 0; i < enemyCols ; i++) 
			{
				for (var k:int = 0; k < enemyRows; k++) 
				{
					curEnemy = new EnemyVanguard(battleField, this);
					curEnemy.id = "vanguard_" + i + "_" + k;
					updater.addEnemyShip(curEnemy);
					collisionChecker.addEnemyShip(curEnemy);
					
					xPos = formationMargin + i * formationWidth / (enemyCols - 1) ;
					yPos = 100 + k * 50;
					curEnemy.place(xPos, yPos);
					enemySkins.push(curEnemy.getSkin());
				}
			}
			
			
			// Configure movement of enemies
			
			var totalHDrift:Number = battleWidth - formationWidth - formationMargin * 2;
			
			for (var j:int = 0; j < vDriftsCount; j++) 
			{
				if (j % 2 == 0)
				{
					timeline.add(TweenLite.to ( enemySkins, 3, { x:"+=" + totalHDrift.toString() } ) );
				}
				else
				{
					timeline.add(TweenLite.to ( enemySkins, 3, { x:"-=" + totalHDrift.toString() } ) );
				}
				timeline.add(TweenLite.to ( enemySkins, 1, { y:"+=" + totalVDrift.toString() } ) );
				
			}
			
		}
		
		
		
	}

}
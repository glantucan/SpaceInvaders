package game.ships 
{
	import flash.display.MovieClip;
	import game.ProjectileList;
	import game.UpdatableList;
	
	public class EnemyVanguard extends EnemyShip 
	{
		
		public function EnemyVanguard(	theContainer:MovieClip, shipId:String, updatables:UpdatableList, 
										friendProjectiles:ProjectileList, enemyProjectiles:ProjectileList) 
		{
			super(theContainer, shipId, updatables, friendProjectiles, enemyProjectiles);
			skin =  new VanguardSkin()
			theContainer.addChild(skin);
			life = 3;
		}
		
		
	}
	
}

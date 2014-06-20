package game.ships {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import game.AUpdater;
	import game.gamerounds.AGameRound;
	
	public class EnemyVanguard extends EnemyShip 
	{
		
		
		public function EnemyVanguard(theContainer:MovieClip, gamerRound:AGameRound) 
		{
			skin = theContainer.addChild( new VanguardSkin() ) as MovieClip;
			super(theContainer, gameRound);
			life = 2;
		}
		
		
	}
	
}

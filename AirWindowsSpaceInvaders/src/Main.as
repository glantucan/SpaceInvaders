package 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import game.CollisionChecker;
	import game.gamerounds.AGameRound;
	import game.gamerounds.GameRound_1;
	import game.AUpdater;
	import game.GameUpdater;
	
	/**
	 * ...
	 * @author Glantucan
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			var battleField:MovieClip = new SpaceSkin();
			addChild(battleField);
			
			
			var debugSprite:Sprite = new Sprite();
			battleField.addChild(debugSprite);
			
			var round:AGameRound = new GameRound_1(battleField, new GameUpdater(debugSprite), new CollisionChecker());
			round.buildRound();
			round.startRound();
		}
		
	}
	
}
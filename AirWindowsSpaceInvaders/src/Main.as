package 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import game.gamerounds.AGameRound;
	import game.gamerounds.GameRound_1;
	
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
			
			var round:AGameRound = new GameRound_1(battleField);
			round.buildRound();
			round.startRound();
		}
		
	}
	
}
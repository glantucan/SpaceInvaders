package game.projectiles {
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import game.gamerounds.AGameRound;
	/**
	 * ...
	 * @author Glantucan
	 */
	public class HeroBullet extends AProjectile
	{
		
		
		public function HeroBullet(theContainer:DisplayObjectContainer, theGameRound:AGameRound, projId:String) 
		{
			super(theContainer, theGameRound, projId);
			skin = container.addChild(new HeroBulletSkin()) as MovieClip;
			
			damage_mc = skin.damage_mc;
			skin.removeChild(skin.damage_mc);
			
			collider = skin.getBounds(container.stage);
			aY = -1;
			vMax = 10;
			damage = 1;
		}
		
		
	}

}
package game.projectiles {
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import game.gamerounds.AGameRound;
	/**
	 * ...
	 * @author Glantucan
	 */
	public class AProjectile 
	{
		protected var gameRound:AGameRound;
		protected var container:MovieClip;
		protected var damage_mc:MovieClip;
		
		public var skin:MovieClip;
		protected var collider:Rectangle;
		public var damage:int;
		
		protected var vX:Number;
		protected var vY:Number;
		protected var aX:Number;
		protected var aY:Number;
		protected var vMax:Number;
		public var destroyed:Boolean;
		
		public var id:String;
		
		
		public function AProjectile(theContainer:MovieClip, theGameRound:AGameRound,projId:String) 
		{
			gameRound = theGameRound;
			id = projId;
			container = theContainer;
			vX = 0;
			vY = 0;
			aX = 0;
			aY = 0;
			vMax = 0;
		}
		
		public function place(x:Number, y:Number):void
		{
			collider.x = x - skin.width / 2;
			collider.y = y - skin.height;
			skin.x = x;
			skin.y = y;
		}
		
		public function getCollider():Rectangle
		{
			if (!destroyed)
			{
				if (!collider)
				{
					collider = skin.getBounds(container.reference_mc);
				}
				else 
				{
					collider.x = skin.x - skin.width / 2;
					collider.y = skin.y - skin.height;
				}
			}
			return collider;
		}
		
	
		
		//Abstract
		public function hit():void
		{
			destroyed = true;
			collider = null;
			skin.gotoAndPlay("hit");
			trace("projectile" + id + " hit. Exploding!");
		}
		
		public function update():void 
		{
			if (!destroyed)
			{
				if (aX != 0 || aY != 0)
				{
					if (vX * vX + vY * vY < vMax * vMax)
					{
						vX += aX;
						vY += aY;
						skin.x += vX;
						skin.y += vY;
					} 
					else
					{
						aX = 0;
						aY = 0;
					}
				}
				else
				{
					skin.x += vX;
					skin.y += vY;
				}
				collider.x = skin.x - skin.width/2;
				collider.y = skin.y - skin.height;
			}
			else
			{
				if (skin.currentLabel == "destroyed")
				{
					trace("projectile " + id + " finished exploding");
					dispose();
					gameRound.removeHeroProjectile(this);
				}
			}
			if (isOutOfScreen())
			{
				trace("Projectile " + id + " is Out of Screen");
				gameRound.removeHeroProjectile(this,true);
				dispose();
			}
			
		}
		
		public function isOutOfScreen():Boolean 
		{
			//trace(collider + "-------------" + container.reference_mc.getBounds(container.stage) )
			if (!destroyed)
			{
				if (collider.intersects( container.reference_mc.getBounds(container.stage) ) )
				{
					return false;
				} 
				else
				{
					return true;
				}
			}
			else
			{
				return false;
			}
		}
		
		
		public function dispose():void
		{
			trace("projectile " + id + " destroyed");
			trace();
			skin.parent.removeChild(skin);
			skin = null;
			collider = null;
			container = null;
		}
		
		public function getDamageMC():MovieClip 
		{
			return damage_mc;
		}
		
	}

}
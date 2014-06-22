package game.colliders 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import game.projectiles.AProjectile;
	import game.projectiles.ProjectileList;
	import game.UpdatableList;
	/**
	 * ...
	 * @author Glantucan
	 */
	public class ACollider 
	{
		
		protected var container:MovieClip;
		protected var reference:DisplayObject;
		
		
		// Lista de objetos actualizables en cada fotograma
		protected var updatableList:UpdatableList;
		
		// Lista de proyectiles que le hacen pupa al enemigo
		protected var fProjectiles:ProjectileList;
		
		protected var _collider:Rectangle;
		public var destroyed:Boolean;
		public var id:String;
		protected var skin:MovieClip;
		
		public function ACollider(theContainer:MovieClip, theId:String, updatables:UpdatableList) 
		{
			container = theContainer;
			reference = container.reference_mc;
			id = theId;
			
			updatableList = updatables;
			updatableList.add(this);
			theContainer.addEventListener(Event.ADDED, onAddedToContainer);
			
		}
		
		private function onAddedToContainer(e:Event):void 
		{
			container.removeEventListener(Event.ADDED, onAddedToContainer);
			_collider = skin.getBounds(container.reference_mc);
		}
		
		public final function get x():Number
		{
			return skin.x;
		}
		
		public final function get y():Number
		{
			return skin.y;
		}
		
		public final function place(x:Number, y:Number):void
		{
			skin.x = x;
			skin.y = y;
			if (!_collider)
			{
				_collider = skin.getBounds(container.reference_mc);
			}
		}
		
		public final function get collider():Rectangle
		{
			return _collider;
		}
		
		
		public final function get width():Number
		{
			return _collider.width;
		}
		
		public final function get height():Number
		{
			return _collider.height;
		}
		
		
		////////////////////////////////////////////////////////////////////////////////
		// Métodos plantilla
		
		public final function update():void  
		{
			if (!destroyed)
			{
 				_collider.x = skin.x - _collider.width / 2;
				_collider.y = skin.y - _collider.height;
				onUpdate();
				
			}
			else if (skin.animation_mc.currentLabel == "destroyed")
			{
				//if (this is AProjectile) trace("Projectile " + id +" is destroyed, removing from updatables");
				
				updatableList.remove(this);
			}
		}
		
		public final function dispose():void
		{
			onDisposal();
			
			skin.parent.removeChild(skin);
			skin = null;
			_collider = null;
			container = null;
			reference = null;
			//id = null;
			updatableList = null;
		}
		
		
		////////////////////////////////////////////////////////////////////////////////
		// Métodos abstractos (a ser sobreescritos con override)
		
		protected function onUpdate():void 
		{
			
		}
		
		
		protected function onDisposal():void 
		{
			
		}
		
	}

}
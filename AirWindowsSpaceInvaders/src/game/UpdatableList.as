package game 
{
	import game.colliders.ACollider;
	import game.projectiles.AProjectile;
	/**
	 * ...
	 * @author Glantucan
	 */
	public class UpdatableList 
	{
		private var updatables:Array;
		private var disposables:Array;
		
		public function UpdatableList() 
		{
			updatables = new Array();
			disposables = new Array();
		}
		
		public function get length():int
		{
			return updatables.length;
		}
		/**
		 * Añade un objeto a la lista
		 * @param	projectile
		 */
		public function add(updatable:ACollider):void
		{
			updatables.push(updatable);
		}

		
		/**
		 * Este método no elimina directamente el objeto de la lista, lo marca para su eliminación
		 * en la fase de limpieza (método clean())
		 * Si se eliminara directamente mientras se setá recoriendo la lista con un bucle, 
		 * tendríamos serios problemas, por que los índices del array ya no corresponderían 
		 * al objeto que esperamos
		 * @param	projectile
		 */
		public function remove(updatable:ACollider):void
		{
			disposables.push(updatable);
		}
		
		/**
		 * Actualiza todo lo que haya que actualize de los elementos de la lista llamando al método update() 
		 * de cada uno de ellos.
		 * @param	frame
		 */
		public function update(frame:int):void
		{
			var numUpdatables:int = updatables.length;
			
			var curUpdatable:ACollider;
			for (var i:int = 0; i < numUpdatables; i++) 
			{
				curUpdatable = updatables[i];
				curUpdatable.update();
			}
			
			if (disposables.length > 0)
			{
				clean();
			}
		}
		
		
		/**
		 * Elimina definitivamente los projectiles que han sido destruidos de la lista.
		 */
		private function clean():void
		{
			var toRemoveCount:int = disposables.length;
			
			// Recorremos la lista de projectiles a eliminar y los eliminamos definitivamente de la lista
			// de proyectiles.
			for (var i:int = 0; i < toRemoveCount ; i++) 
			{
				if(disposables[i] is AProjectile) trace("Projectile " + disposables[i].id + " cleaned form updatables list")
				updatables.splice( updatables.indexOf( disposables[i] ), 1 );
				disposables[i].dispose();
			}
			
			// Limpiar la lista de proyectiles a eliminar
			disposables.splice(0);
		}
	}

}
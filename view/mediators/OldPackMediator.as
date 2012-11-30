/**
 * @author Saad Shams :: sshams@live.com
 * Copy or reuse is prohibited.
 * */
package view.mediators {
	import flash.events.Event;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.components.OldPack;
	
	public class OldPackMediator extends Mediator implements IMediator {
		
		public static const NAME:String = "OldPackMediator";
		
		public function OldPackMediator(viewComponent:Object=null) {
			super(NAME, viewComponent);
			oldPack.addEventListener(OldPack.NEXT, oldPack_nextHandler);
		}
		
		private function oldPack_nextHandler(event:Event):void {
			sendNotification(ApplicationFacade.SHOW_PUZZLE);
		}
		
		public function get oldPack():OldPack {
			return viewComponent as OldPack;
		}
		
	}
}
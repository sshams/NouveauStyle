/**
 * @author Saad Shams :: sshams@live.com
 * Copy or reuse is prohibited.
 * */
package view.mediators {
	import flash.events.Event;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.components.End;
	
	public class EndMediator extends Mediator implements IMediator {
		
		public static const NAME:String = "EndMediator";
		
		public function EndMediator(viewComponent:Object=null) {
			super(NAME, viewComponent);
			end.addEventListener(End.NEXT, end_nextHandler);
		}
		
		private function end_nextHandler(event:Event):void {
			sendNotification(ApplicationFacade.RESTART);
		}
		
		public function get end():End {
			return viewComponent as End;
		}
		
	}
}
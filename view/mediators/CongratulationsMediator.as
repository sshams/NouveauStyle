/**
 * @author Saad Shams :: sshams@live.com
 * Copy or reuse is prohibited.
 * */
package view.mediators {
	import flash.events.Event;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.components.Congratulations;
	
	public class CongratulationsMediator extends Mediator implements IMediator {
		
		public static const NAME:String = "CongratulationsMediator";
		
		public function CongratulationsMediator(viewComponent:Object=null) {
			super(NAME, viewComponent);
			congratulations.addEventListener(Congratulations.NEXT, congratulations_nextHandler);
		}
		
		private function congratulations_nextHandler(event:Event):void {
			sendNotification(ApplicationFacade.SHOW_END);
		}
		
		public function get congratulations():Congratulations {
			return viewComponent as Congratulations;
		}
		
	}
}
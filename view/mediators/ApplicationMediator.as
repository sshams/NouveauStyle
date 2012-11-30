/**
 * @author Saad Shams :: sshams@live.com
 * Copy or reuse is prohibited.
 * */
package view.mediators {
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class ApplicationMediator extends Mediator implements IMediator {
		
		public static const NAME:String = "ApplicationMediator";
		
		public function ApplicationMediator(viewComponent:Object=null) {
			super(NAME, viewComponent);
		}
		
		override public function listNotificationInterests():Array {
			return [
				ApplicationFacade.SHOW_OLD_PACK,
				ApplicationFacade.SHOW_PUZZLE,
				ApplicationFacade.SHOW_CONGRATULATIONS,
				ApplicationFacade.SHOW_END,
				ApplicationFacade.RESTART
			];
		}
		
		override public function handleNotification(notification:INotification):void {
			switch(notification.getName()){
				case ApplicationFacade.SHOW_OLD_PACK:
					nouveauStyle.hideIntro();
					nouveauStyle.showOldPack();
					break;
				case ApplicationFacade.SHOW_PUZZLE:
					nouveauStyle.hideOldPack();
					nouveauStyle.showPuzzle();
					break;
				case ApplicationFacade.SHOW_CONGRATULATIONS:
					nouveauStyle.hidePuzzle();
					nouveauStyle.showCongratulations();
					break;
				case ApplicationFacade.SHOW_END:
					nouveauStyle.hideCongratulations();
					nouveauStyle.showEnd();
					break;
				case ApplicationFacade.RESTART:
					nouveauStyle.hideEnd();
					nouveauStyle.showIntro();
					break;
			}
		}
		
		public function get nouveauStyle():NouveauStyle {
			return viewComponent as NouveauStyle;
		}
		
	}
}
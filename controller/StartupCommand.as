/**
 * @author Saad Shams :: sshams@live.com
 * Copy or reuse is prohibited.
 * */
package controller {
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import view.mediators.ApplicationMediator;
	import view.mediators.CongratulationsMediator;
	import view.mediators.EndMediator;
	import view.mediators.IntroMediator;
	import view.mediators.OldPackMediator;
	import view.mediators.PuzzleMediator;
	
	public class StartupCommand extends SimpleCommand {
		override public function execute(notification:INotification):void {
			var app:NouveauStyle = notification.getBody() as NouveauStyle;
			
			facade.registerMediator(new ApplicationMediator(app));
			facade.registerMediator(new IntroMediator(app.intro));
			facade.registerMediator(new OldPackMediator(app.oldPack));
			facade.registerMediator(new PuzzleMediator(app.puzzle));
			facade.registerMediator(new CongratulationsMediator(app.congratulations));
			facade.registerMediator(new EndMediator(app.end));
		}
	}
}
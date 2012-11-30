/**
 * @author Saad Shams :: sshams@live.com
 * Copy or reuse is prohibited.
 * */
package view.components {
	import com.greensock.easing.Quint;
	import com.muizz.IAnimatable;
	import com.muizz.TweenClips;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class OldPack extends MovieClip implements IAnimatable {
		
		public static const NEXT:String = "next";
		
		private const TOTAL_CLIPS:int = 4;
		
		private var clips:Vector.<MovieClip>;
		private var clips2:Vector.<MovieClip>;
		
		private var timer:Timer;
		private var glowTimer:Timer;
		
		private var glowColor:Number = 0xFFFFFF;
		
		public function OldPack() {
			clips = new Vector.<MovieClip>();
			clips2 = new Vector.<MovieClip>();
			
			timer = new Timer(2000, 1); //total time the content remains on screen
			timer.addEventListener(TimerEvent.TIMER, timer_timerHandler);
			
			glowTimer = new Timer(1500);
			glowTimer.addEventListener(TimerEvent.TIMER, glowTimer_timerHandler);
			
			for(var i:int=0; i<TOTAL_CLIPS; i++){
				clips.push(this.getChildByName("clip_" + i));
			}
			clips2.push(this.getChildByName("clip_0"));
		}
		
		public function animateIn():void {
			TweenClips.animateInFrom(clips, .4, {y:String(10), alpha: 0, ease:Quint.easeOut}, 0, animateIn_completeHandler);
		}
		
		public function animateIn_completeHandler():void {
			timer.start();
			glowTimer.start();
		}
		
		public function animateOut():void {
			TweenClips.animateOutTo(clips, .2, {y:String(-10), alpha: 0, ease:Quint.easeOut}, 0, animateOut_completeHandler);
		}
		
		public function animateOut_completeHandler():void {
			timer.stop();
			glowTimer.stop();
			dispatchEvent(new Event(NEXT));
		}
		
		public function reset():void {
			TweenClips.animateOutTo(clips, .1, {y:String(10), alpha: 1});
		}
		
		private function timer_timerHandler(event:TimerEvent):void { //auto transition to next slide
			timer.stop();
			animateOut();
		}
		
		private function glowTimer_timerHandler(event:TimerEvent):void {
			TweenClips.animateGlow(clips2, 1.5, {glowFilter:{color:glowColor, blurX:30, blurY:30, strength:1, alpha:1}}, {glowFilter:{color:glowColor, blurX:5, blurY:5, strength:1, alpha:1}});
		}
		
	}
}
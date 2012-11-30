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
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.media.SoundTransform;
	import flash.utils.Timer;
	
	public class End extends MovieClip implements IAnimatable {
		
		public static const NEXT:String = "next";
		
		private var clips:Vector.<MovieClip>;
		private var clips2:Vector.<MovieClip>;
		private var clips3:Vector.<MovieClip>;
		private const TOTAL_CLIPS:int = 7;
		
		private var glowTimer:Timer;
		private var glowPackTimer:Timer;
		private var glowColor:Number = 0x0082c8;
		
		public function End() {
			clips = new Vector.<MovieClip>();
			clips2 = new Vector.<MovieClip>();
			clips3 = new Vector.<MovieClip>();
			
			glowTimer = new Timer(1500);
			glowPackTimer = new Timer(1500);
			
			
			for(var i:int=0; i<TOTAL_CLIPS; i++){
				clips.push(this.getChildByName("clip_" + i));
			}
			
			clips2.push(this.getChildByName("clip_5"));
			clips2[0].addEventListener(MouseEvent.MOUSE_DOWN, restart_mouseDownHandler);
			clips2[0].buttonMode = true;
			
			clips3.push(this.getChildByName("clip_4"));
			
			glowTimer.addEventListener(TimerEvent.TIMER, glowTimer_timerHandler);
			glowPackTimer.addEventListener(TimerEvent.TIMER, glowPackTimer_timerHandler);
			
		}
		
		public function animateIn():void {
			TweenClips.animateInFrom(clips, .4, {y:String(10), alpha: 0, ease:Quint.easeOut}, 0, animateIn_completeHandler);
			glowTimer.start();
			glowPackTimer.start();
		}
		
		public function animateIn_completeHandler():void {
			new Whoosh2().play(0, 1, new SoundTransform(0.5));
			clips[TOTAL_CLIPS-1].play();
		}
		
		public function animateOut():void {
			TweenClips.animateOutTo(clips, .2, {y:String(-10), alpha: 0, ease:Quint.easeOut}, 0, animateOut_completeHandler);
		}
		
		public function animateOut_completeHandler():void {
			glowTimer.stop();
			glowPackTimer.stop();
			dispatchEvent(new Event(NEXT));
		}
		
		public function reset():void {
			TweenClips.animateOutTo(clips, .1, {y:String(10), alpha: 1});
			clips[TOTAL_CLIPS-1].gotoAndStop(1);
		}
		
		private function restart_mouseDownHandler(event:MouseEvent):void {
			new Click().play();
			animateOut();
		}
		
		private function glowTimer_timerHandler(event:TimerEvent):void {
			TweenClips.animateGlow(clips2, 1.5, {glowFilter:{color:glowColor, blurX:20, blurY:20, strength:1, alpha:1}}, {glowFilter:{color:glowColor, blurX:5, blurY:5, strength:1, alpha:1}});
		}
		
		private function glowPackTimer_timerHandler(event:TimerEvent):void {
			TweenClips.animateGlow(clips3, 1.5, {glowFilter:{color:0xFFFFFF, blurX:40, blurY:40, strength:1, alpha:1}}, {glowFilter:{color:0xFFFFFF, blurX:5, blurY:5, strength:1, alpha:1}});
		}
		
	}
}
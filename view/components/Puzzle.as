/**
 * @author Saad Shams :: sshams@live.com
 * Copy or reuse is prohibited.
 * */
package view.components {
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Quart;
	import com.greensock.easing.Quint;
	import com.muizz.IAnimatable;
	import com.muizz.TweenClips;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.DropShadowFilter;
	import flash.media.SoundTransform;
	import flash.utils.Timer;
	
	public class Puzzle extends MovieClip implements IAnimatable {
		
		public static const NEXT:String = "next";
		
		private const TOTAL_CLIPS:int = 6;
		private const TOTAL_ANSWERS:int = 3;
		
		private var clips:Vector.<MovieClip>;
		
		private var dropShadowFilter:DropShadowFilter;
		private var dropShadowFilterOver:DropShadowFilter;
		private var dropShadowFilterSelected:DropShadowFilter;
		
		
		private var pairs:Array = [[5, 0], [1, 4], [3, 2]]; //0 index is always a playable clip with additional frames
		private var pairsSelected:Array = [];
		
		private var timer:Timer;
		
		private var totalAnswers:int = 0;
		
		public function Puzzle() {
			clips = new Vector.<MovieClip>();
			
			dropShadowFilter = this.getChildByName("clip_0").filters[0];
			dropShadowFilterOver = this.getChildByName("clip_1").filters[0];
			dropShadowFilterSelected = this.getChildByName("clip_2").filters[0];
			
			for(var i:int=0; i<TOTAL_CLIPS; i++){
				clips.push(this.getChildByName("clip_" + i));
				clips[i].filters = [dropShadowFilter];
			}
			
			timer = new Timer(2000, 1);
			timer.addEventListener(TimerEvent.TIMER, dispatchNext);
		}
		
		public function animateIn():void {
			new Whoosh().play(0, 1, new SoundTransform(.5));
			TweenClips.animateInFrom(clips, .35, {x:String(300), alpha: 0, ease:Back.easeOut}, .6, animateIn_completeHandler);
		}
		
		public function animateIn_completeHandler():void {
			for(var i:int=0; i<TOTAL_CLIPS; i++){
				clips[i].addEventListener(MouseEvent.MOUSE_OVER, clips_mouseOverHandler);
				clips[i].addEventListener(MouseEvent.MOUSE_OUT, clips_mouseOutHandler);
				clips[i].addEventListener(MouseEvent.MOUSE_DOWN, clips_mouseDownHandler);
				clips[i].buttonMode = true;
			}
		}
		
		public function animateOut():void {
			new Whoosh().play(0, 1, new SoundTransform(0.5));
			TweenClips.animateOutTo(clips, .2, {x:String(300), alpha: 0, ease:Back.easeOut}, .8, animateOut_completeHandler);
		}
		
		public function animateOut_completeHandler():void {
			dispatchEvent(new Event(NEXT));
		}
		
		public function reset():void {
			TweenClips.animateOutTo(clips, .4, {x:String(-300), alpha: 1, ease:Back.easeOut});		
			
			for(var i:int=0; i<pairs.length; i++){
				clips[pairs[i][0]].play();
			}
			totalAnswers = 0;
		}
		
		private function dispatchNext(event:TimerEvent):void {
			animateOut();
		}
		
		private function clips_mouseOverHandler(event:MouseEvent):void { //mouse over filter
			var target:MovieClip = MovieClip(event.currentTarget);
			target.filters = [dropShadowFilterOver];
		}
		
		private function clips_mouseOutHandler(event:MouseEvent):void { //reset filter on mouseOut
			var target:MovieClip = MovieClip(event.currentTarget);
			target.filters = [dropShadowFilter];
		}
		
		private function clips_mouseDownHandler(event:MouseEvent):void { //store id's in an array and then compare with pairs array
			new Click().play(0, 1, new SoundTransform(.5));
			
			var target:MovieClip = MovieClip(event.currentTarget);
			target.filters = [dropShadowFilterSelected];
			
			var id = parseInt(target.name.split("_")[1]);
			
			if(clips[id].totalFrames > 1) { //playable clips
				clips[id].play();
				fadeOutPair(id);
				removeInteraction(id);
				totalAnswers++;
				
				if(totalAnswers == 3){
					timer.start();
				}
				
				resetShadows();
				
			} else if(clips[id].totalFrames == 1){ //other non playable clips with sorry message
				var sorry:MovieClip = clips[id].getChildByName("sorry") as MovieClip;
				TweenMax.to(sorry, .5, {alpha: 1});
				TweenMax.to(sorry, .5, {alpha: 0, delay: 1.5});
			}
			
		}
		
		private function fadeOutPair(index:int):void {
			for(var i:int=0; i<pairs.length; i++){
				if(pairs[i][0] == index){
					TweenMax.to(clips[pairs[i][1]], .5, {alpha: 0});
					removeInteraction(pairs[i][1]);
				}
			}
		}
		
		private function resetSorry():void {
			for(var i:int=0; i<pairs.length; i++){
				clips[pairs[i][1]].getChildByName('sorry').alpha = 0;
			}
		}
		
		private function removeInteraction(index:int):void { //remove interaction from clips who have been revealed
			clips[index].removeEventListener(MouseEvent.MOUSE_OVER, clips_mouseOverHandler);
			clips[index].removeEventListener(MouseEvent.MOUSE_OUT, clips_mouseOutHandler);
			clips[index].removeEventListener(MouseEvent.MOUSE_DOWN, clips_mouseDownHandler);
			clips[index].buttonMode = false;
		}
		
		public function resetShadows():void { //reset the drop shadow
			for(var i:int=0; i<TOTAL_CLIPS; i++){
				clips[i].filters = [dropShadowFilter];
			}
		}
		
	}
}
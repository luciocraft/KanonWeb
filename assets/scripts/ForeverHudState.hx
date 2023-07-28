//////////////////////////////////
// IMPORTS, YOU MAY IGNORE THEM //
//////////////////////////////////

import backend.CoolUtil;
import haxe.ds.StringMap;
import flixel.tweens.FlxTween;
import flixel.text.FlxText;
import flixel.util.FlxStringUtil;

import backend.Difficulty; // TO GET THE DIFFICULTY NAME
import backend.ClientPrefs; // ACCESS NOTESPLASH SKIN VARIABLE
import states.MainMenuState; // ACCESS VERSION TEXT
import objects.NoteSplash; // FOR DECREASING SPLASH SIZE
import StringTools; // FOR SOME STRING OPERATIONS

//////////////////////////////////
//////////////////////////////////
//////////////////////////////////

var hudSettings:StringMap = [
	// If the watarmark with the engine name should be displayed
	"forever-watermark" => true,
	// Red and Lime healthbar, just like vanilla/forever
	"forever-healthbar" => false,
	// Ratings and Combo get assigned to the world instead of HUD
	"ratings-in-world" => true,
	// Mimics forever engine splashes by making them smaller in size -- only works with VANILLA splash skin
	"mimic-splash" => false,
	// If the center text should show time instead of difficulty
	"center-shows-time" => true,
];

var centerMark:FlxText;
var currentRank:String = "N/A";

function onCreatePost():Void {
	hidePsychUI();

	game.scoreTxt.borderSize = 1.5;
	game.scoreTxt.size = 18;

	if (hudSettings["forever-healthbar"])
		game.healthBar.setColors(0xFFFF0000, 0xFF66FF33);

	if (hudSettings["forever-watermark"]) {
		var versionStuff:String = 'Kanon Engine v' + MainMenuState.kanonEngineVersion + '\n';
		var cornerMark:FlxText = new FlxText(0, 0, 0, versionStuff);
		cornerMark.setFormat(Paths.font('vcr.ttf'), 18, 0xFFFFFFFF);
		cornerMark.setBorderStyle(game.scoreTxt.borderStyle, 0xFF000000, 2);
		cornerMark.setPosition(FlxG.width - (cornerMark.width + 5), 5);
		cornerMark.camera = game.camHUD;
		game.add(cornerMark);
	}

	centerMark = new FlxText(0, 0, 0, getCenterTxt());
	centerMark.setFormat(Paths.font('vcr.ttf'), 24, 0xFFFFFFFF);
	centerMark.setBorderStyle(game.scoreTxt.borderStyle, 0xFF000000, 2);
	centerMark.camera = game.camHUD;
	centerMark.screenCenter();
	centerMark.y = (ClientPrefs.data.downScroll ? FlxG.height - 40 : 10);
	game.add(centerMark);
}

function onUpdatePost(e:Float):Void {
	if (hudSettings["center-shows-time"])
		centerMark.text = getCenterTxt();
}

function getCenterTxt():String {
	var showTime:Bool = hudSettings["center-shows-time"]; // *Bowser Voice*
	var centerTxt:String = "- " + game.songName + " ";

	if (showTime) {
		var curTime:Float = Math.max(0, Conductor.songPosition - ClientPrefs.data.noteOffset);
		centerTxt += "[" + FlxStringUtil.formatTime(Math.floor(curTime) / 1000) + " / " +
		FlxStringUtil.formatTime(Math.floor(game.inst.length) / 1000) + "]";
	}
	else
		centerTxt += "[" + Difficulty.getString().toUpperCase() + "]";
	centerTxt += ' -';
}

function goodNoteHit():Void {
	if (hudSettings["ratings-in-world"]) {
    	for (i in game.members)
        	if (i != null && Std.isOfType(i, FlxSprite) && i.exists && i.acceleration.y != 0)
        		i.camera = game.camGame;
    }

    if (hudSettings["mimic-splash"] && ClientPrefs.data.splashSkin == "Vanilla") {
	    for (splash in game.grpNoteSplashes) {
	    	if (splash != null && splash.exists && Std.isOfType(splash, NoteSplash)) {
	    		splash.scale.set(0.7, 0.7);
	    		splash.updateHitbox();
	    		splash.offset.set(-30, -25);
	    	}
	    }
	}
}

var scoreDiv:String = " • ";

function onUpdateScore(m:Bool):Void {
	var newText:String = "";
	var accuracyStr:String = "0%";
	if (game.totalPlayed > 0) {
		accuracyStr = Std.string(getAccuracy(2)) + "%";
		if (game.ratingFC != "" && game.ratingFC != "Clear") // no clears in forever so yeah
			accuracyStr += " [" + game.ratingFC + "]";
	}

	newText += "Score: " + game.songScore;
	newText += scoreDiv + "Accuracy: " + accuracyStr;
	newText += scoreDiv + "Combo Breaks: " + game.songMisses;
	newText += scoreDiv + "Rank: " + currentRank;

	game.scoreTxt.text = newText;
}

// IGNORE DEEZ
function hidePsychUI():Void {
	game.timeBar.visible = false;
	game.timeTxt.visible = false;
}

function onEvent(name:String, v1:String, v2:String, time:Float):Void {
	if (name == "Change Character" && hudSettings["forever-healthbar"])
		game.healthBar.setColors(0xFFFF0000, 0xFF66FF33);
}

var scoreRanking = [
	["S+", 100],
	["S", 95],
	["A", 90],
	["B", 85],
	["C", 80],
	["D", 75],
	["E", 70],
	["F", 65]
];

function calculateRank():Void {
	for (rank in scoreRanking) {
		if (getAccuracy(2) >= rank[1]) {
			currentRank = rank[0];
			break;
		}
	}
}

function onRecalculateRating():Void {
	calculateRank();
}

function getAccuracy(digits:Int):Float
	return CoolUtil.floorDecimal(game.ratingPercent * 100, digits);

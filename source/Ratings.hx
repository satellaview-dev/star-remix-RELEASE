import flixel.FlxG;

class Ratings
{
    public static function GenerateLetterRank(accuracy:Float) // generate a letter ranking
    {
        var ranking:String = "BOT";
		if(FlxG.save.data.botplay)
			ranking = "BotPlay";

        if (PlayState.misses == 0 && PlayState.bads == 0 && PlayState.shits == 0 && PlayState.goods == 0) // Marvelous (SICK) Full Combo
            ranking = "(SICK-FC!)";
        else if (PlayState.misses == 0 && PlayState.bads == 0 && PlayState.shits == 0 && PlayState.goods >= 1) // Good Full Combo (Nothing but Goods & Sicks)
            ranking = "(GOOD-FC!)";
        else if (PlayState.misses == 0) // Regular FC
            ranking = "(FULL-COMBO!)";
        else if (PlayState.misses < 10) // Single Digit Combo Breaks
            ranking = "(SDCB)";
        else
            ranking = "(PASS)";

        // WIFE TIME :)))) (based on Wife3)

        var wifeConditions:Array<Bool> = [
            accuracy >= 99.9935, // PERFECT
            accuracy >= 99.980, // AAAA-MAZING:
            accuracy >= 99.970, // AAAA-MAZING.
            accuracy >= 99.955, // AAAA-MAZING
            accuracy >= 99.90, // AAA-MAZING:
            accuracy >= 99.80, // AAA-MAZING.
            accuracy >= 99.70, // AAA-MAZING
            accuracy >= 99, // AA-MAZING:
            accuracy >= 96.50, // AA-MAZING.
            accuracy >= 93, // AA-MAZING
            accuracy >= 90, // AMAZING!~:
            accuracy >= 85, // AMAZING!.
            accuracy >= 80, // AMAZING
            accuracy >= 70, // BEAUTIFUL
            accuracy >= 60, // COOL
            accuracy < 60 // DAMN
        ];

        for(i in 0...wifeConditions.length)
        {
            var b = wifeConditions[i];
            if (b)
            {
                switch(i)
                {
                    case 0:
                        ranking += " PERFECT";
                    case 1:
                        ranking += " AAAA-MAZING:";
                    case 2:
                        ranking += " AAAA-MAZING.";
                    case 3:
                        ranking += " AAAA-MAZING";
                    case 4:
                        ranking += " AAAM-AZING:";
                    case 5:
                        ranking += " AAA-MAZING.";
                    case 6:
                        ranking += " AAA-MAZING";
                    case 7:
                        ranking += " AA-MAZING:";
                    case 8:
                        ranking += " AA-MAZING.";
                    case 9:
                        ranking += " AA-MAZING";
                    case 10:
                        ranking += " AMAZING!~:";
                    case 11:
                        ranking += " AMAZING!.";
                    case 12:
                        ranking += " AMAZING";
                    case 13:
                        ranking += " BEAUTIFUL";
                    case 14:
                        ranking += " COOL";
                    case 15:
                        ranking += " DAMN";
                }
                break;
            }
        }

        if (accuracy == 0)
            ranking = "N/A";
		else if(FlxG.save.data.botplay)
			ranking = "BotPlay";

        return ranking;
    }
    
    public static function CalculateRating(noteDiff:Float, ?customSafeZone:Float):String // Generate a judgement through some timing shit
    {

        var customTimeScale = Conductor.timeScale;

        if (customSafeZone != null)
            customTimeScale = customSafeZone / 166;

        // trace(customTimeScale + ' vs ' + Conductor.timeScale);

        // I HATE THIS IF CONDITION
        // IF LEMON SEES THIS I'M SORRY :(

        // trace('Hit Info\nDifference: ' + noteDiff + '\nZone: ' + Conductor.safeZoneOffset * 1.5 + "\nTS: " + customTimeScale + "\nLate: " + 155 * customTimeScale);

	if (FlxG.save.data.botplay)
	    return "good"; // FUNNY
	    
        if (noteDiff > 166 * customTimeScale) // so god damn early its a miss
            return "miss";
        if (noteDiff > 135 * customTimeScale) // way early
            return "shit";
        else if (noteDiff > 90 * customTimeScale) // early
            return "bad";
        else if (noteDiff > 45 * customTimeScale) // your kinda there
            return "good";
        else if (noteDiff < -45 * customTimeScale) // little late
            return "good";
        else if (noteDiff < -90 * customTimeScale) // late
            return "bad";
        else if (noteDiff < -135 * customTimeScale) // late as fuck
            return "shit";
        else if (noteDiff < -166 * customTimeScale) // so god damn late its a miss
            return "miss";
        return "sick"; // dang bro you got some mf timing and shit -stella
    }

    public static function CalculateRanking(score:Int,scoreDef:Int,nps:Int,maxNPS:Int,accuracy:Float):String
    {
        return 
        (FlxG.save.data.npsDisplay ? "NPS: " + nps + " (Max " + maxNPS + ")" + (!FlxG.save.data.botplay ? " | " : "") : "") + (!FlxG.save.data.botplay ?	// NPS Toggle
        "Score:" + (Conductor.safeFrames != 10 ? score + " (" + scoreDef + ")" : "" + score) + 									// Score
        " | Combo Breaks:" + PlayState.misses + 																				// Misses/Combo Breaks
        " | Accuracy:" + (FlxG.save.data.botplay ? "N/A" : HelperFunctions.truncateFloat(accuracy, 2) + " %") +  				// Accuracy
        " | " + GenerateLetterRank(accuracy) : ""); 																			// Letter Rank
    }
}

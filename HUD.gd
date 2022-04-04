extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var scoreString = ""
	if Globals.score < 10000:
		if Globals.score < 1000:
			if Globals.score < 100:
				if Globals.score < 10:
					scoreString = str("0000", Globals.score)
				else:
					scoreString = str("000", Globals.score)
			else:
				scoreString = str("00", Globals.score)
		else:
			scoreString = str("0", Globals.score)
	else:
		scoreString = str("", Globals.score)
	$ReferenceRect/ScoreLabel.text = str("SCORE\n", scoreString)
	
	var powerString = ""
	if Globals.power/10 < 100:
		if Globals.power/10 < 10:
			powerString = str("00", Globals.power/10)
		else:
			powerString = str("0", Globals.power/10)
	else:
		powerString = str("", Globals.power/10)
	$ReferenceRect/PowerLabel.text = str("POWER\n ", powerString, " ")

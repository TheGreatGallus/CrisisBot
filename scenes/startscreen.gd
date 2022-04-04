extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Label2_pressed():
	Globals.backgroundColor = Globals.PURPLE
	Globals.zoneColor = Globals.PINK
	Globals.neutralColor = Globals.GREY
	Globals.botColor = Globals.LIGHTBLUE
	get_tree().change_scene("res://scenes/spaceship.tscn")


func _on_Label3_pressed():
	Globals.backgroundColor = Globals.NAVY
	Globals.zoneColor = Globals.RUST
	Globals.neutralColor = Globals.GREY
	Globals.botColor = Globals.LIGHTGREEN
	get_tree().change_scene("res://scenes/submarine.tscn")


func _on_Label4_pressed():
	Globals.backgroundColor = Globals.GREY
	Globals.zoneColor = Globals.TEAL
	Globals.neutralColor = Globals.BLACK
	Globals.botColor = Globals.ORANGE
	get_tree().change_scene("res://scenes/arctic.tscn")


func _on_Label5_pressed():
	Globals.backgroundColor = Globals.DARKGREEN
	Globals.zoneColor = Globals.TEAL
	Globals.neutralColor = Globals.GREY
	Globals.botColor = Globals.RED
	get_tree().change_scene("res://scenes/scilab.tscn")

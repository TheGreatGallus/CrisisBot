extends Sprite

var warning_tex = preload("res://assets/warning.png")
var danger_tex = preload("res://assets/danger.png")
var critical_tex = preload("res://assets/critical.png")

var health = 600
var damage = 1
var isBeingRepaired = false
var zone = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	modulate = Globals.LIGHTBLUE


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	



func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		destroySpark()

		

func destroySpark():
	Globals.power = 1000
	queue_free()

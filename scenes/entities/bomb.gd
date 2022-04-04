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
	modulate = Globals.RED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	health -= 2

	if health == 150 || health == 110 || health == 70 || health == 30:
		modulate = Globals.WHITE
	elif health == 130 || health == 90 || health == 50 || health == 10:
		modulate = Globals.RED
	if health <= 0:
		Globals.playDestroy = true
		Globals.damageZone(zone, 1000)
		destroyBomb()
	



func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		destroyBombWithScore()


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		destroyBombWithScore()
		
func destroyBombWithScore():
	Globals.score += 100
	destroyBomb()

func destroyBomb():
	queue_free()

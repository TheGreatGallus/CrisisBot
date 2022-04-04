extends Sprite

var warning_tex = preload("res://assets/warning.png")
var danger_tex = preload("res://assets/danger.png")
var critical_tex = preload("res://assets/critical.png")

var health = 1
var damage = 1
var isBeingRepaired = false
const MAX_HEALTH = 400
var zone = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if health >= MAX_HEALTH:
		texture = critical_tex
		health = MAX_HEALTH
		damage = 3
	elif health >= MAX_HEALTH/2:
		texture = danger_tex
		damage = 2
	elif health > 0:
		texture = warning_tex
		damage = 1
	elif health <= 0:
		destroyFractureWithScore()
	if !isBeingRepaired:
		$RepairSound.stop()
	



func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		isBeingRepaired = true
		$RepairSound.play()


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		isBeingRepaired = false
		
func destroyFractureWithScore():
	Globals.score += 10
	Globals.fracturesFixed += 1
	if Globals.fracturesFixed % 20 == 0:
		Globals.spawnPowerup = true
	destroyFracture()
		
func destroyFracture():
	queue_free()

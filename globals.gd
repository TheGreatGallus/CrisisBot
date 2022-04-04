extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var score = 0
var power = 1000

const STARTING_HEALTH = 10000
var zoneHealth = [STARTING_HEALTH, STARTING_HEALTH, STARTING_HEALTH, STARTING_HEALTH, STARTING_HEALTH, STARTING_HEALTH]

var backgroundColor = Color(0, 0, 0, 1)
var zoneColor = Color(0, 0, 0, 1)
var neutralColor = Color(0, 0, 0, 1)
var botColor = Color(0, 0, 0, 1)
var playDestroy = false
var fracturesFixed = 0
var spawnPowerup = false

const PINK = Color(0.5, 0.15, 0.4, 1)
const GREY = Color(0.5, 0.5, 0.5, 1)
const DARKGREY = Color(0.3211, 0.3163, 0.313)
const YELLOW = Color(1, 1, 0, 1)
const PURPLE = Color(0.121569, 0.003922, 0.152941)
const NAVY = Color(0.039216, 0.035294, 0.25098)
const LIGHTBLUE = Color(0.5, 0.9, 0.8)
const RUST = Color(0.415686, 0.262745, 0.160784)
const BLACK = Color(0, 0, 0, 1)
const TEAL = Color(0.098039, 0.521569, 0.603922)
const RED = Color(0.75, 0, 0, 1)
const DARKGREEN = Color(0.062745, 0.192157, 0.094118)
const LIGHTGREEN = Color(0.302745, 0.602157, 0.34118)
const ORANGE = Color(0.698039, 0.270588, 0.058824)
const WHITE = Color(1, 1, 1)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func damageZone(zone, damage):
	print(zone)
	print(damage)
	zoneHealth[zone] -= damage
		

extends KinematicBody2D

var velocity : Vector2 = Vector2()
var direction : Vector2 = Vector2()

const WALK_SPEED = 150
const RUN_SPEED = 250
var speed = WALK_SPEED
var isMoving = false
var isCharging = false



func _ready():
	pass # Replace with function body.

func read_input():
	velocity = Vector2()
	isMoving = false
	if Input.is_action_pressed("up"):
		velocity.y -= 1
		direction = Vector2(0, -1)
		isMoving = true
	if Input.is_action_pressed("down"):
		velocity.y += 1
		direction = Vector2(0, 1)
		isMoving = true
	if Input.is_action_pressed("left"):
		velocity.x -= 1
		direction = Vector2(-1, 0)
		isMoving = true
	if Input.is_action_pressed("right"):
		velocity.x += 1
		direction = Vector2(1, 0)
		isMoving = true
		
	if Input.is_action_pressed("boost"):
		speed = RUN_SPEED
		if isMoving:
			Globals.power -= 1
			if Globals.power <= 0:
				Globals.power = 0
	else:
		speed = WALK_SPEED
		
	if Globals.power <= 0:
		speed = WALK_SPEED
		
	if isCharging:
		Globals.power += 2
		if Globals.power >= 1000:
			Globals.power = 1000
			$ChargeSound.stop()
		
	velocity = velocity.normalized()
	velocity = move_and_slide(velocity * speed)
	
func playCharge():
	$ChargeSound.play()
	isCharging = true
	
func stopCharge():
	$ChargeSound.stop()
	isCharging = false

func _physics_process(delta):
	read_input()
	
